var play = require('play').Play();

var arr = ['/home/pi/musics/Epic Sax Guy _.m4a',
'/home/pi/musics/beep1.ogg',
'/home/pi/musics/match0.wav',
'/home/pi/musics/beatboxing flute super mario brothers theme.m4a'];

var i = 0;

function handlePlaysound() {
	play.sound(arr[i], handlePlaysound);

	++i;

	if (!arr[i]) return;
}

handlePlaysound();

/*

var i = 0;

function handleTimeout() {
	console.log(arr[i++]);

	if (!arr[i]) return;

	setTimeout(handleTimeout, 1000);
}

setTimeout(handleTimeout, 1000);

*/
