/*******************************/
/********* PLAYGROUND **********/
/*******************************/


/*~snare = Pbind(
	\instrument, \snare,
	\dur, Pseq([0.25, 0.5, 0.1, 0.25, 0.5, 0.5], inf),
	\amp, 0
);*/
// SNARE
(
~snare = Pbind(
	\instrument, \sample,
	\dur, Pseq([1] * 2, inf),
	\amp, 0,
	\buf, d[\snare]
);
)
~snare.quant = 0.5;
~snare.play;
~snare.stop;
// KICK
(
~kick = Pbind(
	\instrument, \sample,
	\dur, Pseq([0.125, 0.125, 0.5, 0.25, 0.25, 0.25] * 2, inf),
	\amp, 0,
	\buf, d[\kick]
);
)
~kick.start;
~kick.stop;
~kick.quant = 0.25;
// KLANK
(
~klank = Pbind(
	\instrument, \klank,
	\octave, 3,
	\armDis, 1,
	\scale, Scale.minor,
	\degree, Pseq([0, 2, 5, 0, 1, 2, 6] + 3, inf),
	\dur, Pseq([0.25], inf),
	\amp, 0,
	\duration, 2,
);
)
~klank.play;
~klank.stop;
~klank.quant = 0.25;
// VAR
(
~varsin = Pbind(
	\instrument, \vars,
	\octave, 5,
	\att, 0.25,
	\scale, Scale.minor,
	\degree, Pseq([0, 2, 5, 0, 1, 2, 6] + 0, inf),
	\dur, Pseq([0.25], inf),
	\amp, 0,
	\duration, 2,
);
)
~varsin.play;
~varsin.stop;
~varsin.quant = 0.25;

// SINPAN
(
~sinp = Pbind(
	\instrument, \sinpan,
	\octave, 5,
	\att, 0.01,
	\duration, 2,
	\scale, Scale.minor,
	\degree, Pseq([0, 2, 5, 0, 1, 2, 6] + 0, inf),
	\dur, Pseq([0.25], inf),
	\amp, 0,
	\duration, 2,
	\del, 0.25,
	\durdel, 5,
	\pan, Pseq([-0.5, 0, 0.5], inf)
);
)
~sinp.play;
~sinp.stop;
~sinp.quant = 1;