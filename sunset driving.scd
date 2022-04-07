StageLimiter.activate;

~scale = Scale.major;
Scale.names;
~root = 8;


(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		Pseq([1], 4),
		// Pseq([0.25], 16),
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
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Clap04]], inf),
	\dur, Pseq([
		// Pseq([1], 4),
		Pseq([0.25], 16),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pwhite([1, 3]),
	\pan, 0,
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 0]).play();
)

(
Pbindef(\s1,
	\instrument, \varsAmbient,
	\octave, Prand([4], inf),
	\distortion, 1,
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[-2, 2, 5], [-3, 1, 4], [0, 4, 7], [-4, 0, 3]], 1).stutter(1),
		// Pseq([[-2, 2, 5], [-1, 2, 5], [0, 4, 7], [1, 5, 8]], 1).stutter(1),
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
(
SynthDef(\varsAmbient, {
	|amp=0.5, freq=200, att=0.01, sus=0.5, dec=1, lfoF=0.5 ind, out, pan=0|
	var first = BLowPass.ar(
		VarSaw.ar(freq, width:0), freq*2
	),
	second = BLowPass.ar(
		VarSaw.ar(
			(freq*2), width:0

	), (freq*4))*0.2,
	sig = (first+second) * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
Pbindef(\s1,
	\instrument, \armoNoiz,
	\octave, Prand([8], inf),
	\distortion, 0.6,
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([1

	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([0.75], 1)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, Pwhite(-1, 1),
	\amp, 0.8
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

