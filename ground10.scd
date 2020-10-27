~scale = Scale.minor;
Scale.names;
~root = 5;

(
SynthDef(\sample2, {
	|
	amp,
	buf,
	out,
	rate=1,
	pan=0
	|
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	sig = sig + CombC.ar(sig, 1, 0.25, 1);
	sig = sig*EnvGen.ar(Env.linen(0.001, 4, 0.001), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
Pbindef(\k,
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
	\rate, Pseq([1.2], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)
(
Pbindef(\s,
	\instrument, \sample2,
	\buf, Pseq([d[\page_flip_2], d[\page_flip_3], d[\page_flip_4]], inf),
	\dur, Pseq([
		Pseq([2], 7),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([2], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\s).stop.quant_([4, 0]).play();
)

(
Pbindef(\s1,
	\instrument, \varsLfo,
	\octave, Prand([4], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 20,
	\root, Pfunc({~root}),
	\degree, Pseq([[4,6,8], [0,2,4]].stutter(1), inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([8], inf),
	\att, Pkey(\dur)*l.beatDur/3,
	\sus, Pkey(\dur)*l.beatDur/3,
	\dec, Pkey(\dur)*l.beatDur/3,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s2,
	\instrument, \armoNoiz,
	\octave, Prand([8], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 15,
	\root, Pfunc({~root}),
	\degree, Pseq([0, 4, 2, 5,4,5,4,5,6].stutter(16), inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], 2),
		// Pseq([0.75], 6)
	], inf)/2,
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
	\instrument, \bouncing,
	\octave, Pseq([6], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 20,
	\root, Pfunc({~root}),
	// \degree, Pseq([0,5,4,1,2,3,0].stutter(1), inf) + 0,
	\degree, Pseq([0,4,5,4,2,1,2,0].stutter(1), inf) + 0,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([1
		// Pseq([1, 0.5, 1, 0.25, 0.25, 0.25, 0.75], 2),
		// Pseq([0.75].stutter(8), 2),
		// Pseq([8], 2),
/*		Pseq([0.75].stutter(6), 1),
		Pseq([0.5].stutter(6), 1),
		Pseq([0.25].stutter(12), 1),
		Pseq([0.5].stutter(6), 1),
		Pseq([0.125].stutter(24), 4)*/
		// Pseq([0.75], 6)
	], inf) ,
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)