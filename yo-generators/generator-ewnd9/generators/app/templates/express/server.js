var express = require('express');
var app = express();

var morgan = require('morgan');
var cors = require('express-cors');

app.use(morgan('request: :remote-addr :method :url :status'));
app.use(express.static('public'));
app.use(cors({
  allowedOrigins: [
    'localhost:3000',
    'localhost:8080',
    'localhost:8000',
  ]
}));

app.get('/api/v1/data', (req, res) => {
  res.json({});
});

var server = app.listen(3000, () => console.log('localhost:3000'));
