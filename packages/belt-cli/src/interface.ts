import type minimist from "minimist";

export interface Ctx {
  command: Command;
  argv: minimist.ParsedArgs;
}

export interface Command {
  script: string;
  description: string;
}
