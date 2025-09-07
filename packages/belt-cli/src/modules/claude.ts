import { type Options, query, type SDKMessage } from '@anthropic-ai/claude-code';

export async function claude(prompt: string, options?: Options): Promise<string> {
  const abortController = new AbortController();
  const messages: SDKMessage[] = [];

  for await (const message of query({
    prompt,
    options: {
      abortController,
      maxTurns: 5,
      allowedTools: [],
      ...options,
    },
  })) {
    messages.push(message);

    if (message.type === 'result' && message.subtype === 'success') {
      abortController.abort();
      return message.result;
    }
  }

  throw new Error(`Failed to get result: ${JSON.stringify(messages, null, 2)} messages`);
}
