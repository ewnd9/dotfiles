# @belt/tools

Convinience wrappers for scripts with logging

## Install

The `@belt/tools` package was manually unpublished from npm on 2025-08-28. The name has been released for potential future use.

## Usage

```js
const { execa, opn } = require('@belt/tools');
// or
const execa = require('@belt/tools/modules/execa');
const opn = require('@belt/tools/modules/opn');

execa('echo', ['hello world']);
// prints "$ echo 'hello world'"
```

## License

MIT © [ewnd9](http://ewnd9.com)
