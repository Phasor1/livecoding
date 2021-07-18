StageLimiter.activate;

~scale = Scale.major;
Scale.names;
~root = 8;

(
Pbindef(\s1,
	\instrument, \varsLfo,
	\octave, Prand([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[-2, 2, 5], [-3, 1, 4], [0, 4, 7], [-4, 0, 3]], 1).stutter(1),
		// Pseq([[-2, 2, 5], [-1, 2, 6], [-3, 1, 4], [1, 5, 8]], 1).stutter(1),
		// Pseq([[0, 4, 7], [-1, 3, 6], [-2, 2, 5], [-1, 3, 6]], 1).stutter(1),
		// Pseq([[2, 6, 9], [5, 9, 12], [0, 4, 7], [4, 8,11]], 1).stutter(1),
		// Pseq([[0, 4, 7], [1, 4, 8], [3, 6, 8], [1, 4, 8]], 1).stutter(1),
		// Pseq([[2, 6, 7]], 1)

	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], 1)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)


