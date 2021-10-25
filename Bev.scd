StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 0;

(
Pbindef(\s1,
	\instrument, \fmEnv,
	\octave, Prand([2], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.6,
	\degree, Pseq([
		Pseq([0], 1).stutter(1),
		Pseq([1], 1).stutter(1),
		Pseq([2], 1).stutter(1),
		Pseq([3], 1).stutter(1),
		// Pseq([[2, 6, 7]], 1)

	], inf).stutter(16),
	\ind, 10,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], 1)*l.beatDur
	], inf),
	\att, Pkey(\dur),
	\sus, 0,
	\dec, 0,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

Pbindef(\k).stop
(
Pbindef(\s2,
	\instrument, \distortion,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.6,
	\degree, Pseq([
		Pseq([[0, 4, 7], [1,5,8], [2,6,9], [3,6,10]], 1).stutter(1),
		// Pseq([[2, 6, 7]], 1)

	], inf),
	\ind, 10,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], 1)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 2
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)










Pbindef(\k).play
(
SynthDef(\flanger, {
	|freq, amp, dec=2, out, att=0.01, sus=0, lfoF=0.2, cf, dur=1, pan=0|
	var sig = VarSaw.ar(freq, width: 0.8),
	lfo = VarSaw.ar(lfoF, 0,0, 0.003, 0.003),
	// lfo = SinOsc.ar(lfoF, 0, 0.005, 0.005),
	sig2 = VarSaw.ar(freq * 2);
	sig = sig + sig2;
	sig = sig + AllpassL.ar(sig, 10, lfo, 0);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur*16)));
}).add;
)

