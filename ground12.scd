StageLimiter.activate;

~scale = Scale.harmonicMinor;
Scale.names;
~root = 2;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([4], 4),
		// Pseq([0.25], 8),
		// Pseq([0.75], 16),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)


(
Pbindef(\s1,
	\instrument, \distortion,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 5,
	// \lfo, 2,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,2,4, 6], [-2,0, 2, 4]], 1)
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([4], inf)*l.beatDur,
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\amp, 1
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

