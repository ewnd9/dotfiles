# belt-cli

Global CLI scripts registry, inspired by [`oclif`](https://github.com/oclif/oclif)

## Install

The `@belt/cli` package was manually unpublished from npm on 2025-08-28. The name has been released for potential future use.

## Usage

```sh
# uses npm programmatically underhood, see https://docs.npmjs.com/cli/install
$ belt install <name>
$ belt install @<scope>/<name> # scoped from npm
$ belt install <user>/<name> # from github
$ belt install git+ssh://git@gitlab.com:<user>/<name>.git # from any git repo by ssh
$ belt install git+https://github.com/<user>/<name>.git # from any git repo by https

$ belt link local/path/to/module

$ belt list
$ belt <command> <args>
```

## License

MIT © [ewnd9](http://ewnd9.com)
