s.boot
s.scope
~scale = Scale.major;
Scale.names;
~root = 0;
(
SynthDef(\varsPew, {
	|amp=0.1, freq=200, att=0, sus=0, dec=1, out, lfoF=0.5, pan=0, pewEnv=0.02|
	var pew = XLine.ar(freq*8, freq, pewEnv),
	sig = VarSaw.ar(pew, width: 1);
	sig = RLPF.ar(sig, SinOsc.ar(lfoF, 0, freq*2, freq*4), 10);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
SynthDef(\fmVars, {
	|amp=0.1, freq=200, att=0, sus=0, dec=1, out, pan=0|
	var	lfoF = 1/(att+sus+dec)/2,
	sig = SinOscFB.ar(freq, SinOsc.ar(lfoF));
	sig = RLPF.ar(sig, SinOsc.ar(lfoF, mul: freq*2, add: freq*4), 0.07);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

Synth(\varsPew, [\freq, 400, \att, 0.01, \sus, 0, \dec, 1, \amp, 1, \out, 0, \lfoF, 0]);

(
Pbindef(\s1,
	\instrument, \fmVars,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Prand([
		Pseq([0, 0, 0, 2], 1).stutter(1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([4], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0.2
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)