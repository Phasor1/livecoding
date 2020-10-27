~scale = Scale.major;
Scale.names
~root = 5;

(

)

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Snare17]], inf),
	\dur, Pseq([
		Pseq([0.75], 7),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\pan, Pwhite(-1, 1),
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 2]).play();
)

(
Pbindef(\s,
	\instrument, \sample,
	\buf, Pseq([d[\exhale_woman], d[\inhale_woman]], inf),
	\dur, Pseq([
		Pseq([2], 7),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1.2], inf),
	\amp, 0
);
Pbindef(\s).stop.quant_([4,2]).play();
)


(
Pbindef(\s1,
	\instrument, \varsLfo,
	\octave, 4,
	\scale, Pfunc({~scale}),
	// \dist,
	\root, Pfunc({~root}),
	\degree, Pseq([-2,0].stutter(1), inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([4], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s2,
	\instrument, \bouncing,
	\octave, 5,
	\scale, Pfunc({~scale}),
	// \dist,
	\root, Pfunc({~root}),
	\degree, Pseq([[4,6,8], [2,4,6], [0,2,4], [2,4,6]].stutter(1), inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\ind, 15,
	\dur, Pseq([4
		// Pseq([0.5, 0.5, 0.5, 0.5], 2),
		// Pseq([0.5, 0.25, 0.25, 0.5, 1, 1, 0.5], 1)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s3,
	\instrument, \fmEnv,
	\octave, 6,
	\scale, Pfunc({~scale}),
	// \dist,
	\root, Pfunc({~root}),
	\degree, Pseq([0,3,6,3,7,6,1,1].stutter(1), inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\ind, 10,
	\dur, Pseq([
		Pseq([1,0.25, 0.25, 1.5, 1], 2),
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)