StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 5;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([2], 16),
		// Pseq([0.75], 16),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1.2], inf),
	\pan, 0,
	\amp, 0.5,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)
(
Pbindef(\s,
	\instrument, \sample,
	\buf, Pseq([d[\Snare03]], inf),
	\dur, Pseq([
		Pseq([2], 7),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([0.7], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\s).stop.quant_([4, 1]).play();
)

(
Pbindef(\s2,
	\instrument, \sin,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 20,
	\lfo, 2,
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([0, 1,4, -1,-1,-1, 5, 1], 3),
		Pseq([[0, 4], [4, 8]], 2),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		// Pseq([2, 1, 0.5, 0.5, 0.5, 1.5, 2], 3),
		Pseq([4].stutter(8), 2)
		// Pseq([0.75].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*2,
	\pan, 0,
	\amp, 0.2
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\s1,
	\instrument, \armoNoiz,
	\octave, Pseq([8], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 50,
	\root, Pfunc({~root}),
	\degree, Prand([
		Pseq([0], 1).stutter(1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([0.225], inf),
		// Pseq([1].stutter(1), ),
		// Pseq([0.25].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\s3,
	\instrument, \varsLfo,
	\octave, Pseq([2], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 50,
	\lfoF, 0.1,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[4, 11],[5, 12],[4,11], [6,13]], 1).stutter(1),
		Pseq([[4, 11],[5, 12],[2,9], [0, 7]], 1).stutter(1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([1], inf),
		// Pseq([1].stutter(1), ),
		// Pseq([0.25].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att,0,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0.3
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\s6,
	\instrument, \bouncing,
	\octave, Pseq([5], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 50,
	\lfoF, 0.1,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[4, 11],[5, 12],[4,11], [6,13]], 1).stutter(1),
		Pseq([[4, 11],[5, 12],[2,9], [0, 7]], 1).stutter(1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], inf),
		// Pseq([1].stutter(1), ),
		// Pseq([0.25].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s6).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\s5,
	\instrument, \fmEnv,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 10,
	\root, Pfunc({~root}),
	\degree, Prand([
		Pseq([[4, 11],[5, 12],[2,9], [6, 13]], 1).stutter(4),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([1], inf),
		// Pseq([1].stutter(1), ),
		// Pseq([0.25].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, Pkey(\dur),
	\sus, 0,
	\dec, 0.001,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s5).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\s4,
	\instrument, \ethereal,
	\octave, Prand([4], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 10,
	\root, Pfunc({~root}),
	\degree, Prand([
		Pseq([[1,3,5], [0,2,4]], 1).stutter(1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([8], inf),
		// Pseq([1].stutter(1), ),
		// Pseq([0.25].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, Pkey(\dur),
	\sus, 0,
	\dec, 0.01,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s4).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\k).stop;
Pbindef(\s).stop;
Pbindef(\s1).stop;
Pbindef(\s2).stop;
/*Pbindef(\s3).stop;*/
Pbindef(\s4).stop;
// Pbindef(\s5).stop;
)
(
Pbindef(\k).play;
Pbindef(\s).play;
Pbindef(\s1).play;
Pbindef(\s2).play;
Pbindef(\s5).play;
Pbindef(\s3).play;
Pbindef(\s4).play;
)