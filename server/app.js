var express = require('express');
var path = require('path');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var app = express();

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

var examplePlaylist = {
  playlist: {
    current : {
      id: "a76f8c",
      name: "Super Mario Bros. Theme",
      img: "https://upload.wikimedia.org/wikipedia/en/9/99/MarioSMBW.png",
      artist: "Gregg Pollack"
    },
    following: [
      {
        id: "b5da8",
        name: "Doctor Who Theme",
        img: null,
        artist: null,
        likes: 13,
        dyslikes: 2
      },
      {
        id: "b5da8",
        name: "Doctor Who Theme",
        img: null,
        artist: null,
        likes: 13,
        dyslikes: 2
      }
    ]
  }
};

app.use('/playlist', function(req, res, next) {
	res.send(JSON.stringify(examplePlaylist));
});

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;
