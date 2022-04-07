StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 1;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		Pseq([1], 3),
		// Pseq([0.25, 0.75], 1),
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
	\buf, Pseq([d[\Clap04]], inf),
	\dur, Pseq([
		Pseq([2], 3),
		Pseq([0.75, 1.25], 1),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp,0,
);
Pbindef(\sn).stop.quant_([4, 1]).play();
)


(
Pbindef(\s1,
	\instrument, \distortionPulse,
	\octave, 3,
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 20,
	\root, Pfunc({~root}),
	\degree, Pseq([
/*		Pseq([1, 6,7], 4),
		Pseq([0, 6,7], 4),
		Pseq([0, 6,9], 2),
		Pseq([0, 6,10], 2),*/
		Pseq([[1,5,8]], 2),
		Pseq([[0, 4, 7]], 2),
		Pseq([[2, 6, 9]], 2),
		Pseq([[5, 9, 12]], 2),
	], inf).stutter(1)+4,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([2], 8),
	], inf),
	\att, 0.1,
	\sus, 0,
	\dec, Pkey(\dur),
	\amp, 0,
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s3,
	\instrument, \vars,
	\octave, Pseq([7], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 10,
	\root, Pfunc({~root}),
	\degree, Pseq([
/*		Pseq([
			Pseq([5,6], 1),
			Pseq([1,2], 1),
		], 2),
		Pseq([
			Pseq([4,5], 1),
			Pseq([0,1], 1),
		], 2)*/

		Pseq([0,2,3,4,2,3,5,6], 1),
		Pseq([1,2,3,4], 1),
		Pseq([1,2,6,5], 1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([0.25], 1),
	], inf),
	\att, 0.001,
	\sus, 0,
	\pan, 0,
	\dec, Pkey(\dur),
	\amp,0,
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)

(


Pbindef(\s4,
	\instrument, \wing,
	\octave, 4,
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 20,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[5, 9, 12]], 1),
		Pseq([[4,8,11]], 1),
	], inf).stutter(1),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([8], 8),
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\amp, 0.2,
	);
Pbindef(\s4).stop.quant_([4, 0]).play(l);
)