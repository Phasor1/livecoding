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
SynthDef(\oscbank, {
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

// PIANO
SynthDef(\piano, {
	|freq, vel, amp, duration, out|
	var sig = MdaPiano.ar(freq.midicps, 1, vel, duration);
	sig = sig * EnvGen.ar(Env.perc(0, duration), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;

// GLITCH
SynthDef(\glitch, {
	|freq, amp, pan, out|
	var sig = VarSaw.ar(freq);
	pan = SinOsc.ar(0.001);
	sig = sig * EnvGen.ar(Env.perc(0, 0.05), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan)!2);
}).add;

// LOW PASS FILTER SYNTH
SynthDef(\sawf, {
	|freq, amp=0.5, duration=1, nArm=2, out, pan=0|
	var sig = VarSaw.ar(freq.midicps),
	envFill = Env.sine(duration);
	nArm.do({
		|i|
		sig = sig + VarSaw.ar(freq.midicps * (i + 1));
	});
	sig = BLowPass4.ar(sig, (EnvGen.ar(envFill) * 6000));
	sig = sig * EnvGen.ar(Env.linen(0, duration, 0), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig!2, pan));
}).add;

// FM
SynthDef(\sawFM, {
	|freq, amp=0.5, duration=1, index=5, freqMod=100, out, pan=0|
	var modulator = SinOsc.ar(freqMod) * index,
	sig = VarSaw.ar(freq + modulator);
	sig = BLowPass4.ar(sig, (EnvGen.ar(Env.sine(duration)) * 6000) + freq);
	sig = sig * EnvGen.ar(Env.linen(0, duration, 0), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig!2, pan));
}).add;

// VIOLIN
SynthDef(\violin, {
	| freq, duration, amp=0.25, out |
	var env = EnvGen.ar(Env.linen(0.1, duration, 0.1), doneAction:2),
	sig = VarSaw.ar(
		freq,
		width:LFNoise2.kr(1).range(0.2, 0.8)*SinOsc.kr(5, Rand(0.0, 1.0)).range(0.7,0.8))*0.25;
	sig = sig * env * amp;
	Out.ar(out, sig!2);
}).add;

SynthDef(\sinchord, {
	|freq, att, amplitude=0.5, out, duration|
	var sig = SinOsc.ar(freq);
	sig = sig * EnvGen.ar(Env.perc(att, duration), doneAction:2) * amplitude;
	Out.ar(out, sig!2);
}).add;

SynthDef(\bass, {
	|duration= 0.25, amp, out|
	var sig = Klank.ar(
		`[
			[30, 25, 20],
			[0.5, 0.3, 0.1],
			[duration, duration / 2, duration / 4]
		],
		Impulse.ar(0) * EnvGen.ar(Env.linen(0, duration, 0), doneAction:2) * amp;
	);
	Out.ar(out, sig!2);
}).add;

SynthDef(\klank, {
	|freq, amp, duration, out|
	var sig = Klank.ar(
		`[
			 [freq, freq + 70, freq + 127],
			(10..1) / 10,
			((10..1) / 10) * duration
		],
		Impulse.ar(0) * EnvGen.ar(Env.linen(0, duration, 0), doneAction: 2) * amp;
	);
	Out.ar(out, sig!2);
}).add;

SynthDef(\SawFm, {
	| freq, duration, amp=0.25, out, freqMod=440, att=0, index=3|
	var sig = VarSaw.ar(freq + index * (EnvGen.ar(Env.sine(duration * 2)) + 1) * SinOsc.ar(freq * 2));
	sig = sig * EnvGen.ar(Env.perc(att, duration), doneAction: 2);
	Out.ar(out, sig!2);
}).add;

SynthDef(\armoNoiz, {
	|freq, amp, duration, out, att|
	var sig = BBandPass.ar(WhiteNoise.ar(1), XLine.ar(freq *4, freq, duration), 0.1);
	sig = sig * EnvGen.ar(Env.perc(att, duration), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;





















