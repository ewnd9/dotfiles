import { claude } from '../modules/claude.js';
import execa from '../modules/execa.js';

export async function run(_: { argv: any }) {
  const diff = await getGitDiff();
  if (!diff.trim()) {
    console.log('No changes to commit');
    process.exit(1);
  }

  const commitMessage = await generateCommitMessage(diff);

  console.log(`\nCommit message: ${commitMessage}`);
  await execa('git', ['commit', '-m', commitMessage], { stdio: 'inherit' });
  console.log('Changes committed successfully');
}

async function generateCommitMessage(diff: string): Promise<string> {
  const prompt = `Based on the git status and diff below, generate a brief commit message (max 50 chars):

Git Diff:
${diff.substring(0, 2000)}${diff.length > 2000 ? '...' : ''}

Rules:
- Keep it under 50 characters
- Use present tense (add, update, fix, etc.)
- Be specific but concise
- No periods at the end`;
  return claude(prompt);
}

async function getGitDiff(): Promise<string> {
  return await execa('git', ['diff', '--cached'], {});
}
