var express = require('express');
var path = require('path');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var play = require('play').Play();

var app = express();

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

var playlistPaths = {
	'a76f8c': '/home/pi/musics/Epic Sax Guy _.mp3',
	'b5da8': '/home/pi/musics/match0.wav'
};

var examplePlaylist = {
  playlist: {
    current : {
      id: 'a76f8c',
      name: 'Super Mario Bros. Theme',
      img: 'https://upload.wikimedia.org/wikipedia/en/9/99/MarioSMBW.png',
      artist: 'Gregg Pollack'
    },
    following: [
      {
        id: 'b5da8',
        name: 'Doctor Who Theme',
        img: null,
        artist: null,
        likes: 13,
        dyslikes: 2
      },
      {
        id: 'b5da8',
        name: 'Doctor Who Theme',
        img: null,
        artist: null,
        likes: 13,
        dyslikes: 2
      }
    ]
  }
};

app.get('/playlist', function(req, res, next) {
	res.send(JSON.stringify(examplePlaylist));
});

app.get('/playcurrent', function(req, res, next) {
	play.sound(playlistPaths[examplePlaylist.playlist.current.id]);
	res.send('ok');
});

app.get('/play/:id', function(req, res, next) {
//	play.sound(playlistPaths[req.id]);
	res.send('ok');
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
