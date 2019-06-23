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
	\dur, Pseq([1, 0.25,  0.5, 0.25, 0.125, 0.125, 0.5]++([0.0625] / 2).stutter(8), inf),
	\amp, 0,
	\buf, d[\wood]
);
)

~snare.quant = 4;
~snare.play;
~snare.stop;
// KICK
(
~kick = Pbind(
	\instrument, \sample,
	\dur, Pseq([0.5] * 1 , inf),
	\amp, 0,
	\buf, d[\kick]
);
)
[0.125, 0.125, 0.5, 0.25, 0.25, 0.25];
[0.125, 0.125, 0.25, 0.25, 0.5];
~kick.play;
~kick.stop;
~kick.quant = 4;
// KLANK
(
~klank = Pbind(
	\instrument, \oscbank,
	\octave, 3,
	\armDis, 1,
	\scale, Scale.major,
	\degree, Pseq([0, 2, 3], inf),
	\dur, Pseq([0.5] * 4 , inf),
	\amp, 0,
	\duration, 0.5,
);
)
~klank.play;
~klank.stop;
~klank.quant = 4;
// VAR
(
~varsin = Pbind(
	\instrument, \vars,
	\octave, 3,
	\att, 3,
	\scale, Scale.major,
	\degree, Prand([0, 2, 3, 7, 6, 5].stutter(8) +3  , inf),
	\dur, Prand([0.25] * 1, inf),
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
~varsin.quant = 4;

// SINPAN
(
~sinp = Pbind(
	\instrument, \sinpan,
	\octave, 4,
	\att, 0,
	\duration, 4,
	\scale, Scale.major,
	\degree, Pseq([0,7,5,4,7, 6, 5, 4] + 4, inf),
	\dur, Pseq([0.5], inf),
	\amp, 0,
	\del, 0.125,
	\durdel, 4,
	\pan, Pseq([Pwhite(-1, 1)], inf)
);
)
~sinp.play;
~sinp.stop;
~sinp.quant = 4;
// NOIZ
(
~noiz = Pbind(
	\instrument, \noiz,
	\amp, 0.9,
	\att, 0,
	\freq, Pseq([60,65, 70] * 2, inf),
	\duration, 2,
	\dur, Pseq([0.25, 125, 0.5], inf);
);
)

~noiz.play;
~noiz.stop;
~noiz.quant = 4;
// PIANOT VST
(
~piano = Pbind(
	\instrument, \piano,
	\amp, 0.3,
	\vel, 100,
	\att, 0,
	\octave, 4,
	\scale, Scale.minor,
	\degree, Pseq([[0, 3, 4], [3, 5, 6]], inf),
	\duration, 1,
	\dur, Pseq([0.5] /2, inf),
	\pan, Pseq([Pwhite(-1, 1)], inf)
);
)

~piano.play;
~piano.stop;
~piano.quant = 4;

//GLITCH
(
~glitch = Pbind(
	\instrument, \glitch,
	\amp, 0,
	\pan, Pwhite(-1, 1),
	\octave, 8,
	\scale, Scale.major,
	\degree, Pseq([0, 2, 3, 2, 5, 7].stutter(8)++([0, 1,2,1].stutter(8))++([5,4,8,7].stutter(8)) + 7, inf) + 1,
	// \detuneFreq, Pseq([Pwhite(-1, 1)], inf),
	\dur, Prand([0.125] , inf)
);
)

~glitch.play;
~glitch.stop;
~glitch.quant = 4;

// VARSAW FILTERED
(
~sawf = Pbind(
	\instrument, \sawFM,
	\amp, 0,
	\octave, 7,
	\scale, Scale.major,
	\degree, Prand([0, 1, 2, 3, 7, 5], inf),
	\pan, Pwhite(-1, 1),
	\index, Pseq([5], inf),
	\freqMod, Pseq([1000], inf),
	\duration, 10,
	\dur, Pseq([10], inf)
);
)

~sawf.play;
~sawf.stop;
~sawf.quant = 4;
~glitch.quant = 4;

// violin
(
~v = Pbind(
	\instrument, \sinchord,
	\amp, 0,
	\att, 2,
	\octave, 6,
	\scale, Scale.minor,
	\degree, Pseq([[0, 3, 4], [3, 5, 6]], inf),
	\amplitude, Pseq([[0.9, 0.4, 0.3]] *0, inf),
	\duration, 5,
	\dur, Pseq([5], inf)
);
)
~v.play;
~v.stop;
~v.quant = 4;
s.meter;
s.scope;
s.plotTree

(
~b = Pbind(
	\instrument, \bass,
	\amp, 0,
	\dur, Pseq([0.5].stutter(6) ++ [0.25].stutter(4) ++[0.5].stutter(4), inf) / 2,
	\duration, 1
)
)
~b.play;
~b.quant = 4;

(
~snare = Pbind(
	\instrument, \sample,
	\dur,  Pseq([2], inf),
	\amp, 0,
	\buf, d[\snare]
);
)
~snare.play;
~snare.quant = 2;
[0.25, 0.25, 0.5, 0.5, 2.5]


(
~mario = Pbind(
	\instrument, \sample,
	\dur,  Pseq([0.5, 0.25, 0.5, 0.5, 0.25, 0.5], inf),
	\amp, 0,
	\buf, d[\kick_zarro]
);
)
[1, 0.25, 0.5, 0.5, 0.25, 0.5]
[1, 0.5, 1, 0.5, 0.25, 0.0625, 0.0625, 0.125, 0.5]++
~mario.play;
~mario.stop;
/*~mario.stop;
~sinp.stop;*/
~mario.quant = 4


Synth(\klank, [\out, 0, \freq, 400, \duration, 2, \amp, 0.5])

Synth(\SawFm, [\amp, 0.5, \att, 0, \duration, 4, \freq, 200, \index, 10, \freqMod, 600])
Synth(\armoNoiz, [\amp, 0.9, \att, 0, \duration, 5, \freq, 1000])

// CHORDS
(
~chords = Pbind(
	\instrument, \vars,
	\octave, 3,
	\att, 5,
	\scale, Scale.major,
	\degree, Prand([[0, 4, 7], [0, 3, 4, 7], [4, 7, 14]], inf),
	\dur, Prand([4], inf),
	\amp, 0,
	\duration, 2
);
)
~chords.play;
~chords.quant = 4;


(
~n = Pbind(
	\instrument, \armoNoiz,
	\octave, 7,
	\att, 0,
	\scale, Scale.major,
	\degree, Prand([1,2,3] ++([1,2,3] * 2)  , inf),
	\dur, Prand([4], inf),
	\amp, 0,
	\duration, 5
);
)
~n.play;
~n.stop;
~n.quant = 4;


(
~n = Pbind(
	\instrument, \noiseSynth,
	\octave, 6,
	\att, 0,
	\scale, Scale.major,
	\degree, Prand([0, 2,3,4, 5, 6, 7], inf),
	\dur, Prand([0.25], inf),
	\amp, 1,
	\duration, 2
);
)
~n.play;
~n.stop;
~n.quant = 4;
Synth(\bouncing, [\amp, 0.5, \freq, 200, \duration, 4])
{VarSaw.ar(200) * abs(EnvGen.ar(Env.perc(0, 10)) * SinOsc.ar(XLine.ar(1,300,10)))}.plot(10, bounds: Rect(0,0,800, 800))
{VarSaw.ar(1, width: 0)}.plot(1)
s.meter

