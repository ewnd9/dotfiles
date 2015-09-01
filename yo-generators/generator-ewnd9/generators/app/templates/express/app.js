require('babel/register')({
  only: [__dirname + '/src']
});
require('./src/server');
