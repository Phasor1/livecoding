StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 5;
s.latency = 0;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Clap03]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([1], 1),
	], inf),
	\rate, Pseq([1, 0.7, 0.5, 0.3], inf)*1.5,
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\s1,
	\instrument, \fmEnv,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0, 3, 4], [2, 4, 6],[-2, 0, 2], [-4, -2, 0]], 1).stutter(1),
	], inf),
	\dur, Pseq([
		Pseq([4, 4, 4, 4], 1)
	], inf),
	\att, Pkey(\dur)*l.beatDur,
	\ind, 10,
	\sus, 0,
	\dec, 0.01,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)













