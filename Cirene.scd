StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 5;


(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([1], 16),
		Pseq([1], 16),
		// Pseq([0.75], 16),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([0.5], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\s1,
	\instrument, \varsLfo,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0, 4, 7], [-1, 3, 6]], 1).stutter(2),
		// Pseq([[0, 4, 7], [-1, 3, 6], [-2, 2, 5], [-1, 3, 6]], 1).stutter(2),
		// Pseq([[2, 6, 9], [5, 9, 12], [0, 4, 7], [4, 8,11]], 1).stutter(2),
		// Pseq([[0, 4, 7], [1, 4, 8], [3, 6, 8], [1, 4, 8]], 1).stutter(1),
		Pseq([[0, 4, 7]], 1)

	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], 1)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 1
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)


(
Pbindef(\s2,
	\instrument, \fmBass,
	\octave, Prand([8], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\ind, 15,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\degree, Pseq([
		Pseq([0,7], 4),
		Pseq([-1,6], 4),
	], inf).stutter,
	\dur, Pseq([
		Prand([0.25], 1)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0.3
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)




Pbindef(\s1).stop
Pbindef(\s2).stop
Pbindef(\k).stop