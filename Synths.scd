// ALL SYNTHS

// VARSAW
SynthDef(\vars, {
	|freq, amp = 0, duration, att, out|
	var sig = VarSaw.ar(freq, width: 0.5),
	env = Env.perc(att, duration);
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
// NOISE
SynthDef(\noiz, {
	|
	amp,
	att,
	duration,
	out,
	freq
	|
	var sig = WhiteNoise.ar(1);
	sig = BLowPass4.ar(sig, XLine.ar(freq.midicps + 60, 30, att + duration));
	sig = sig * EnvGen.ar(Env.perc(att, duration), doneAction:2) * amp;
	Out.ar(out, sig!2);
}).add;
// Synth(\noiz, [\amp, 0.9, \duration, 1, \out, 0, \freq, 110]);
// LFO
SynthDef(\noizLfo, {
	|out|
	var sig = WhiteNoise.ar(0.5),
	lfo = SinOsc.ar(0.5, mul: 0.5) + 1;
	sig = BLowPass4.ar(sig, lfo * 500);
	Out.ar(out, sig!2);
}).add;

// 2!8
// Synth(\vars, [\freq, 200, \duration, 2, \amp, 1]);