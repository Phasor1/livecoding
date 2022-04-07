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
Pbindef(\s1,
	\instrument, \distortion,
	\octave, 5,
	\scale, Pfunc({~scale}),
	\dist, 0.5,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([
			Pseq([0, 3, 2,1,6], 1),
			Pseq([4], 1)
		], 1),
		Pseq([
			Pseq([0, 3, 2,1,6], 1),
			Pseq([7], 1)
		], 1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([1, 0.5, 0.25, 0.75, 0.5, 1], 2),
		// Pseq([0.25], 8),
	], inf),
	\att, 0.001,
	\sus, 0,
	\dec, Pkey(\dur),
	\amp, 0,
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)


(
Pbindef(\s3,
	\instrument, \teng,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.47,
	\degree, Pseq([
		// Pseq([0, 1,4, -1,-1,-1, 5, 1], 3),
		Pseq([[0, 4, 7]], 1),
		Pseq([[0, 4, 7]]+7, 3),
	], inf),
	\dur, Pseq([
		// Pseq([2, 1, 0.5, 0.5, 0.5, 1.5, 2], 3),
		Pseq([0.25].stutter(1), 2)
		// Pseq([0.75].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)

(
SynthDef(\varsAmbient, {
	|amp=0.5, freq=200, att=0.01, sus=0.5, dec=1, lfoF=0.5 ind, out, pan=0, dur|
	var first = BLowPass.ar(
		VarSaw.ar(freq, width:0), freq*2
	),
	second = BLowPass.ar(
		VarSaw.ar(
			(freq*2), width:0

	), (XLine.ar(freq*4, 18000, l.beatDur/4)))*0.2,
	sig = (first+second) * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
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