StageLimiter.activate;

~scale = Scale.harmonicMinor;
Scale.names;
~root = 3;


(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick06]], inf),
	\dur, Pseq([
		// Pseq([1], 6),
		// Pseq([1], 4),
		Pseq([0.25], 8),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Snare16]], inf),
	\dur, Pseq([
		Pseq([2], 16),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 1]).play();
)

(
Pbindef(\s1,
	\instrument, \varsLfo,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.5,
	\degree, Pseq([
		// Pseq([[0, 4, 7]], 1).stutter(2),
		// Pseq([[0, 4, 7], [-1, 3, 6]], 1).stutter(2),
		Pseq([[0, 4, 7], [-1, 3, 6], [-2, 2, 5], [-1, 3, 6]], 1).stutter(2),
		// Pseq([[2, 6, 9], [5, 9, 12], [0, 4, 7], [4, 8,11]], 1).stutter(2),
		// Pseq([[0, 4, 7], [1, 4, 8], [3, 6, 8], [1, 4, 8]], 1).stutter(1),
		// Pseq([[0, 4, 7]], 1)

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

(
Pbindef(\s2,
	\instrument, \fmBass,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.5,
	\ind, 10,
	\degree, Pseq([
		// Pseq([[0, 4, 7]], 1).stutter(2),
		// Pseq([[0, 4, 7], [-1, 3, 6]], 1).stutter(2),
		Pseq([0,-1], 1).stutter(2),
		// Pseq([[2, 6, 9], [5, 9, 12], [0, 4, 7], [4, 8,11]], 1).stutter(2),
		// Pseq([[0, 4, 7], [1, 4, 8], [3, 6, 8], [1, 4, 8]], 1).stutter(1),
		// Pseq([[0, 4, 7]], 1)

	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([8], 1)*l.beatDur
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)


(
Pbindef(\s1,
	\instrument, \distortion,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\ind, 3,
	\degree, Pseq([
		Pseq([[2, 6, 9], [5, 9, 12], [0, 4, 7], [4, 8,11]], 1).stutter(2)

	], inf),
	\dur, Pseq([
		Pseq([4], 1)
	], inf),
	\freqMod, 5000,
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 1
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);

Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		// Pseq([1], 4),
		Pseq([1], 8),
		// Pseq([0.25], 8),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 10,
);
Pbindef(\k).stop.quant_([4, 0]).play();
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