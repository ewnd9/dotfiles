import boxen from 'boxen';
import prompts from 'prompts';

import { claude } from '../modules/claude.js';
import execa from '../modules/execa.js';

export async function run(_: { argv: any }) {
  const diff = await getGitDiff();
  if (!diff.trim()) {
    console.log('No changes to commit');
    process.exit(1);
  }

  const commitMessages = await Promise.all([
    generateCommitMessage(diff),
    generateCommitMessage(diff),
    generateCommitMessage(diff),
  ]);

  const { value } = await prompts({
    type: 'select',
    name: 'value',
    message: 'Pick a message',
    choices: commitMessages.map((message, i) => ({
      title: message.split('\n')[0],
      value: i,
    })),
    initial: commitMessages.length - 1,
  });

  const commitMessage = commitMessages[value];

  console.log(boxen(commitMessage));
  await execa('git', ['commit', '-m', commitMessage], { stdio: 'inherit' });
}

async function generateCommitMessage(diff: string): Promise<string> {
  const prompt = `Based on the git status and diff below, generate a brief commit message (max 50 chars):

Git Diff:
${diff.substring(0, 2000)}${diff.length > 2000 ? '...' : ''}

Rules:
- Keep it under 50 characters
- Use present tense (add, update, fix, etc.)
- Be specific but concise
- No periods at the end
- Return only the message, no other text`;
  return claude(prompt);
}

async function getGitDiff(): Promise<string> {
  return await execa('git', ['diff', '--cached'], {});
}
