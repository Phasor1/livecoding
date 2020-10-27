~scale = Scale.major;
~root = 1;

(

)

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\page_flip_4], d[\page_flip_3], d[\page_flip_2], d[\paper]], inf),
	\dur, Pseq([
		Pseq([2], 7),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1.3], inf),
	\amp, 0.6,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\v,
	\instrument, \sample,
	\buf, Pseq([d[\inhale_woman], d[\exhale_woman]], inf),
	\dur, Pseq([
		Pseq([2], 7),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\amp, 0,
);
Pbindef(\v).stop.quant_([4, 2]).play();
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, d[\Snare14],
	\dur, Pseq([
		Pseq([2], 7),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 2]).play(l);
)
(
	Pbindef(\s1,
		\instrument, \varsLfo,
		\octave, 4,
	\ind, 10,
		\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([[4,6,8], [5,7,9]], inf).stutter(1),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([16], inf),
		\att, 1,
		\sus, 0,
		\dec, Pkey(\dur)*l.beatDur - 1,
		\amp, 0.3
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)


(
	Pbindef(\s2,
		\instrument, \ethereal,
		\octave, 5,
		\scale, Pfunc({~scale}),
	// \dist,
	\root, Pfunc({~root}),
	\degree, Pseq(([[4,6,8], [2,4,6]]).stutter(1), inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([4], inf),
		\att, 0.01,
		\sus, 0,
		\dec, Pkey(\dur)*l.beatDur*2,
	\pan, Pwhite(-1, 1),
		\amp, 0.2
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s1).stop;
Pbindef(\s2).stop;
Pbindef(\k).stop;
Pbindef(\v).stop;
)

(

Pbindef(\s1).stop.quant_([4, 0]).play(l);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
Pbindef(\v).stop.quant_([4, 0]).play(l);
Pbindef(\k).stop.quant_([4, 0]).play(l);
)

