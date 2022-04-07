StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 5;
s.latency = 0.16;

(
Pbindef(\k,
	\instrument, \sampleFil,
	\buf, Pseq([d[\Clap02]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([0.75], 1),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\sa,
	\instrument, \sample,
	\buf, Pseq([d[\inhale_woman], d[\exhale_woman]], inf),
	\dur, Pseq([
		Pseq([2], 16),
	], inf),
	\rate, Pseq([1], inf),
	\mix, 0.7,
	\pan, 0,
	\amp, 0,
);
Pbindef(\sa).stop.quant_([4, 0]).play();
)


(
Pbindef(\s1,
	\instrument, \varsLfo,
	\octave, Prand([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0, 3, 4], [2, 4, 6],[-2, 0, 2], [-4, -2, 0]], 1).stutter(1)+4,
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

(
Pbindef(\s2,
	\instrument, \fmEnv,
	\octave, Prand([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,4,7], [-1, 3, 6], [-3, -1, 4], [-1, -3, 6]], 1).stutter(1),
	], inf),
	\dur, Pseq([
		Pseq([4, 4, 4, 4], 1)
	], inf),
	\att, Pkey(\dur)*l.beatDur,
	\ind, 8,
	\sus, 0,
	\dec, 0.01,
	\pan, 0,
	\amp, 0.3
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)













