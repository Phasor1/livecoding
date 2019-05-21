// ALL SYNTHS

// VARSAW
SynthDef(\vars, {
	|freq, amp, duration, att, out|
	var sig = VarSaw.ar(freq, width: 0.5),
	env = Env.perc(attack, duration);
	sig = EnvGen.ar(env) * sig;
	sig = sig * EnvGen.ar(Env.linen(0, duration, 0), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;

// SIN OSCILLATOR WITH PAN CONTROL
SynthDef(\sinpan, {
	|out, amp, freq, att, duration, del, durdel, pan|
	var sig = VarSaw.ar(freq, mul:1),
	env = Env.perc(att, duration);
	sig = EnvGen.ar(env) * sig;
	sig = CombN.ar(sig, durdel, del, durdel);
	sig = sig * EnvGen.ar(Env.linen(0, durdel, 0), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
// SAMPLE TO REPRODUCE
SynthDef(\sample, {
	|
	amp,
	buf,
	out
	|
	var sig = PlayBuf.ar(2, buf, doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;

// KLANK
SynthDef(\klank, {
	|
	freq,
	amp,
	duration,
	out,
	armDis=1
	|
	var	sig = Klank.ar(
		`[
			(1..10) * (freq / armDis) + freq,
			(10..1) / 10,
			(10..1) * duration
		],
		Impulse.ar(0) * amp;
	);
	sig = sig * EnvGen.ar(Env.linen(0, duration, 0), doneAction: 2);
	Out.ar(out, sig!2);
}).add;
Synth(\klank, [\freq, 300, \amp, 0.3, \duration, 2, \am])
(1..10) -2