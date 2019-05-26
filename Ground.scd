/*******************************/
/********* PLAYGROUND **********/
/*******************************/


/*~snare = Pbind(
	\instrument, \snare,
	\dur, Pseq([0.25, 0.5, 0.1, 0.25, 0.5, 0.5], inf),
	\amp, 0
);*/
// p.fadeTime = 10
// SNARE
(
~snare = Pbind(
	\instrument, \sample,
	\dur, Pseq([1, 0.25,  0.5, 0.25] * 2, inf),
	\amp, 0,
	\buf, d[\snare]
);
)

~snare.quant = 1;
~snare.play;
~snare.stop;
// KICK
(
~kick = Pbind(
	\instrument, \sample,
	\dur, Pseq([0.125, 0.125, 0.5, 0.5], inf),
	\amp, 0,
	\buf, d[\kick]
);
)
[0.125, 0.125, 0.5, 0.25, 0.25, 0.25];
[0.125, 0.125, 0.25, 0.25, 0.5];
~kick.play;
~kick.stop;
~kick.quant = 1;
p.fadeTime  =2
// KLANK
(
~klank = Pbind(
	\instrument, \klank,
	\octave, 3,
	\armDis, 1,
	\scale, Scale.major,
	\degree, Pseq([0, 4, 5, 5, 4, 7,6,7,6,7,6] - 6, inf),
	\dur, Pseq([0.5, 0.125, 0.5, 0.125, 0.25, 0.125, 0.125, 0.25] , inf),
	\amp, 0,
	\duration, 0.5,
);
)
~klank.play;
~klank.stop;
~klank.quant = 1;
// VAR
(
~varsin = Pbind(
	\instrument, \vars,
	\octave, 6,
	\att, 0.1,
	\scale, Scale.major,
	\degree, Pseq([0, 2, 3, 2, 7, 6, 5, 4, 7, 0, 7, 0] + 2 , inf),
	\dur, Pseq([0.25] * 1, inf),
	\amp, 0,
	\duration, 1
);
)
p.makeTempoClock;
p.clock
[0, 7, 0, 1,2,3, 4, 7,7,7,7]
[0, 2, 3, 2, 7, 6, 5, 4, 7, 0, 7, 0]
~varsin.play;
~varsin.stop;
~varsin.quant = 1;

// SINPAN
(
~sinp = Pbind(
	\instrument, \sinpan,
	\octave, 5,
	\att, 0,
	\duration, 6,
	\scale, Scale.major,
	\degree, Pseq([0,7,5,4, 7], inf),
	\dur, Pseq([1] , inf),
	\amp, 0,
	\del, 0.5,
	\durdel, 6,
	\pan, Pseq([0], inf)
);
)
~sinp.play;
~sinp.stop;
~sinp.quant = 1;
(
~noiz = Pbind(
	\instrument, \noiz,
	\amp, 0.5,
	\att, 1,
	\freq, Pseq([40, 50, 60] * 2, inf),
	\duration, 1,
	\dur, Pseq([0.5, 0.125, 0.5] / 2, inf);
);
)

~noiz.play;
~noiz.stop;
~noiz.quant = 1;
s.meter;
{EnvGen.ar(Env.perc(0, 2), doneAction: 2) * WhiteNoise.ar(0.3)!2}.play;

// LFO
(
~mario = Synth(\noizLfo);
)
~mario.play;
~mario = nil;
