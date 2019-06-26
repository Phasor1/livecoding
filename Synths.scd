// ALL SYNTHS

// VARSAW
SynthDef(\vars, {
	|freq, amp = 0, sus, dec=0.1, att, out|
	var sig = VarSaw.ar(freq, width: 0.5);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;

// SIN OSCILLATOR WITH PAN CONTROL
SynthDef(\sinPan, {
	|out, amp, freq=200, att=0, sus=1, dec=0.2, pan=0|
	var sig = VarSaw.ar(freq, mul:1);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
// SAMPLE TO REPRODUCE
SynthDef(\sample, {
	|
	amp,
	buf,
	out,
	rate=1
	|
	var sig = PlayBuf.ar(2, buf, rate, doneAction: 2) * amp;
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
	|freq, att=0, amp=0.5, sus=1, dec=0.1, nArm=2, out, pan=0|
	var sig = VarSaw.ar(freq.midicps),
	envFill = Env.sine(sus + dec);
	nArm.do({
		|i|
		sig = sig + VarSaw.ar(freq.midicps * (i + 1));
	});
	sig = BLowPass4.ar(sig, (EnvGen.ar(envFill) * 6000));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig!2, pan));
}).add;

// FM
SynthDef(\sawFM, {
	|freq, amp=0.5, att=0, sus=1, dec=0.1, index=5, freqMod=100, out, pan=0|
	var modulator = SinOsc.ar(freqMod) * index,
	sig = VarSaw.ar(freq + modulator);
	sig = BLowPass4.ar(sig, (EnvGen.ar(Env.sine(sus + dec)) * 6000) + freq);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig!2, pan));
}).add;

// VIOLIN
SynthDef(\violin, {
	| freq, sus, amp=0.25, out |
	var env = EnvGen.ar(Env.linen(0.1, sus, 0.1), doneAction:2),
	sig = VarSaw.ar(
		freq,
		width:LFNoise2.kr(1).range(0.2, 0.8)*SinOsc.kr(5, Rand(0.0, 1.0)).range(0.7,0.8))*0.25;
	sig = sig * env * amp;
	Out.ar(out, sig!2);
}).add;

SynthDef(\sinchord, {
	|freq, att, amplitude=0.5, out, sus=1, dec=0.1|
	var sig = SinOsc.ar(freq);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction:2) * amplitude;
	Out.ar(out, sig!2);
}).add;

SynthDef(\bass, {
	|dec= 0.25, amp, out|
	var sig = Klank.ar(
		`[
			[30, 25, 20],
			[0.5, 0.3, 0.1],
			[dec, dec / 2, dec / 4]
		],
		Impulse.ar(0) * EnvGen.ar(Env.perc(0, dec), doneAction:2) * amp;
	);
	Out.ar(out, sig!2);
}).add;

SynthDef(\klank, {
	|freq, amp, dec=1, out|
	var sig = Klank.ar(
		`[
			 [freq, freq + 70, freq + 127],
			(10..1) / 10,
			((10..1) / 10) * dec
		],
		Impulse.ar(0) * EnvGen.ar(Env.perc(0, dec), doneAction: 2) * amp;
	);
	Out.ar(out, sig!2);
}).add;

SynthDef(\SawFm, {
	| freq, att=0, sus=0.5, dec=0.1, amp=0.25, out, freqMod=440, index=3|
	var sig = VarSaw.ar(freq + index * (EnvGen.ar(Env.sine((sus + dec) * 2)) + 1) * SinOsc.ar(freq * 2));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2);
	Out.ar(out, sig!2);
}).add;

SynthDef(\armoNoiz, {
	|freq, amp, dec, out, att|
	var sig = BBandPass.ar(WhiteNoise.ar(1), XLine.ar(freq *4, freq, dec), 0.1);
	sig = sig * EnvGen.ar(Env.perc(att, dec), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;

SynthDef(\noiseSynth, {
	|freq, amp, sus=0.5, dec=0.1, out, att|
	var sig = BBandPass.ar(WhiteNoise.ar(1), freq, 0.05);
	3.do{
		|i|
		sig = sig + BBandPass.ar(WhiteNoise.ar(1), freq * (i + 2), 0.05) * (((3 - i) / 3) - 0.1);
	};
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;

SynthDef(\bouncing, {
	|freq, amp, dec=1, out, att|
	var sig = VarSaw.ar(freq),
	env = (VarSaw.ar(XLine.ar(1,100,dec), width: 0) * 0.5) + 1;
	sig = sig * env;
	sig = sig * EnvGen.ar(Env.perc(0, dec, 1, 0), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;

SynthDef(\bouncingBall, {
	|freq, amp, dec=2, out, att|
	var sig = SinOsc.ar(VarSaw.ar(XLine.ar(1,100,dec), width: 0)),
	env = (VarSaw.ar(XLine.ar(1,100,dec), width: 0) * 0.5) + 1;
	sig = sig * EnvGen.ar(Env.perc(0, dec, 1, 0), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;


SynthDef(\sawFMSynth, {
	|freq=200, amp, sus=1, att=0, dec=0.5, out, i=200, fc=50|
	var car = SinOsc.ar(fc) * (VarSaw.ar(1 / ((sus + dec) * 2), width: 1) + 1) * i,
	sig = SinOsc.ar(freq + car);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec, 1, 0), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;

SynthDef(\waveTable1, {
	|freq=200, amp, att=0, sus=1, dec=0.1, out|
	var buffer = Buffer.alloc(s, 2048),
	signal = Signal.newClear(1024),
	sig = {};
	// mod = (abs(SinOsc.ar(1/ ((sus + dec) * 2), mul: 5)) + 1) * 0.2;
	signal.waveFill({
		|x, old, i|
		var out;
		out = sin(x) + sin(5 * x);
		out = out.cubed();
		// out;
	}, 0, 2pi);
	buffer.loadCollection(signal.asWavetable);
	sig = (Osc.ar(buffer, 200) * 2).fold(-0.5, 0.5);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;

SynthDef(\waveTable2, {
	|freq=200, amp, att=0, sus=1, dec=0.1, out|
	var sig = Signal.newClear(1024),
	bf = Buffer.alloc(s, 2048), wt;
	sig.waveFill({
		|x, old, i|
		var out;
		if(abs(sin(x)) < 0.3,{
			out = sin(x) + sin(15 * x);
		},{
			out = sin(x) + sin(5 * x) + (sin(7 * x) * 0.5);
		});
		// if( > 90,{
		// out = sin(x).fold(-0.8, 0.8);
	// }, {});
	}, 0, 2pi);
	wt = sig.asWavetable;
	bf.loadCollection(wt);
	sig = Osc.ar(bf, freq);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;

SynthDef(\armoBubble, {
	|amp, freq=200, dec=0.5, sus=1, frBubble=30, out|
	var sig = VarSaw.ar((/*abs(SinOsc.ar(frBubble)) **/ freq) + 50),
	benv = abs(SinOsc.ar(frBubble)), // single bubble env
	envFil = (SinOsc.ar(1 / ((sus + dec) * 2)) * 4000) + 40; // frequency bubble env
	sig = BBandPass.ar(sig, envFil) * benv;
	sig = sig * EnvGen.ar(Env.linen(0, sus, dec), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;
//IMPULSE
SynthDef(\imp, {
	|amp, out, dec=0.5|
	var sig = Impulse.ar(1);
	sig = EnvGen.ar(Env.perc(0, dec), doneAction: 2) * sig * amp;
	Out.ar(out, sig!2);
}).add;
// SINUSOIDAL GLITCH
SynthDef(\gl1, {
	|amp, out, start=1000, end=500, dec=0.1|
	var sig = SinOsc.ar(XLine.ar(start, end, dec));
	sig = sig * EnvGen.ar(Env.linen(0, dec, 0.01), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;