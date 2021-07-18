// ALL SYNTHS

// VARSAW
SynthDef(\vars, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0|
	var sig = VarSaw.ar(freq, width: 0.5);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
// OSC
SynthDef(\sin, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0|
	var sig = SinOsc.ar(freq);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

/*SynthDef(\square, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0|
	var sig = VarSaw.ar(freq, width: 0.5);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;*/

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
	rate=1,
	pan=0
	|
	var sig = PlayBuf.ar(2, buf, rate, doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

// KLANK
SynthDef(\oscbank, {
	|
	freq,
	amp,
	duration,
	out,
	armDis=1,
	pan=0
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
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
// NOISE
SynthDef(\noiz, {
	|
	amp,
	att,
	duration,
	out,
	freq,
	pan=0
	|
	var sig = WhiteNoise.ar(1);
	sig = BLowPass4.ar(sig, XLine.ar(freq.midicps + 60, 30, att + duration));
	sig = sig * EnvGen.ar(Env.perc(att, duration), doneAction:2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
// Synth(\noiz, [\amp, 0.9, \duration, 1, \out, 0, \freq, 110]);
// LFO
SynthDef(\noizLfo, {
	|out, pan=0|
	var sig = WhiteNoise.ar(0.5),
	lfo = SinOsc.ar(0.5, mul: 0.5) + 1;
	sig = BLowPass4.ar(sig, lfo * 500);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

// PIANO
SynthDef(\piano, {
	|freq, vel, amp, duration, out, pan=0|
	var sig = MdaPiano.ar(freq.midicps, 1, vel, duration);
	sig = sig * EnvGen.ar(Env.perc(0, duration), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

// GLITCH
SynthDef(\glitch, {
	|freq, amp, out, pan=0|
	var sig = VarSaw.ar(freq);
	pan = SinOsc.ar(0.001);
	sig = sig * EnvGen.ar(Env.perc(0, 0.05), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
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
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

// FM

SynthDef(\fm, {
	|att=0, sus=0, rel=1, amp=0.1, freq=200, carFR=1, modFR=1, modA=0, ind=0, out, pan=0|
	var	indexEnv = ind,
	modSin = SinOsc.ar(freq * modFR, mul:freq * modFR * indexEnv),
	carrSin = SinOsc.ar((freq * carFR) + modSin);
	carrSin = carrSin * EnvGen.ar(Env.linen(att, sus, rel), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(carrSin, pan));
}).add;

SynthDef(\fmBass, {
	|att=0, sus=0, dec=1, amp=0.1, freq=200, carFR=1, modFR=1, modA=0, ind=0, out, pan=0|
	var	indexEnv = Line.ar(ind, 0, att + sus + dec),
	modSin = SinOsc.ar(freq * modFR, mul:freq * modFR * indexEnv),
	carrSin = SinOsc.ar((freq * carFR) + modSin);
	carrSin = carrSin * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(carrSin, pan));
}).add;

SynthDef(\fmEnv, {
	|att=0, sus=0, dec=1, amp=0.1, freq=200, carFR=1, modFR=1, modA=0, ind=0, out, pan=0|
	var	indexEnv = Line.ar(0, ind, att + sus + dec),
	modSin = SinOsc.ar(freq * modFR, mul:freq * modFR * indexEnv),
	carrSin = SinOsc.ar((freq * carFR) + modSin);
	carrSin = carrSin * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(carrSin, pan));
}).add;

SynthDef(\sawFM, {
	|freq, amp=0.5, att=0, sus=1, dec=0.1, index=5, freqMod=100, out, pan=0|
	var modulator = SinOsc.ar(freqMod) * index,
	sig = VarSaw.ar(freq + modulator);
	sig = BLowPass4.ar(sig, (EnvGen.ar(Env.sine(sus + dec)) * 6000) + freq);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

// VIOLIN
SynthDef(\violin, {
	| freq, sus, amp=0.25, out, pan=0|
	var env = EnvGen.ar(Env.linen(0.1, sus, 0.1), doneAction:2),
	sig = VarSaw.ar(
		freq,
		width:LFNoise2.kr(1).range(0.2, 0.8)*SinOsc.kr(5, Rand(0.0, 1.0)).range(0.7,0.8))*0.25;
	sig = sig * env * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\sinchord, {
	|freq, att, amplitude=0.5, out, sus=1, dec=0.1, pan=0|
	var sig = SinOsc.ar(freq);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction:2) * amplitude;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\bass, {
	|dec= 0.25, amp, out, pan=0|
	var sig = Klank.ar(
		`[
			[30, 25, 20],
			[0.5, 0.3, 0.1],
			[dec, dec / 2, dec / 4]
		],
		Impulse.ar(0) * EnvGen.ar(Env.perc(0, dec), doneAction:2) * amp;
	);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\klank, {
	|freq, amp, dec=1, out, pan=0|
	var sig = Klank.ar(
		`[
			 [freq, freq + 70, freq + 127],
			(10..1) / 10,
			((10..1) / 10) * dec
		],
		Impulse.ar(0) * EnvGen.ar(Env.perc(0, dec), doneAction: 2) * amp;
	);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\SawFm, {
	| freq, att=0, sus=0.5, dec=0.1, amp=0.25, out, freqMod=440, index=3, pan=0|
	var sig = VarSaw.ar(freq + index * (EnvGen.ar(Env.sine((sus + dec) * 2)) + 1) * SinOsc.ar(freq * 2));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\armoNoiz, {
	|freq, amp, dec, out, att, pan=0|
	var sig = BBandPass.ar(WhiteNoise.ar(1), XLine.ar(freq *4, freq, dec), 0.1);
	sig = sig * EnvGen.ar(Env.perc(att, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\noiseSynth, {
	|freq, amp, sus=0.5, dec=0.1, out, att, pan=0|
	var sig = BBandPass.ar(WhiteNoise.ar(1), freq, 0.05);
	3.do{
		|i|
		sig = sig + BBandPass.ar(WhiteNoise.ar(1), freq * (i + 2), 0.05) * (((3 - i) / 3) - 0.1);
	};
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\bouncing, {
	|freq, amp, dec=1, out, att, pan=0|
	var sig = VarSaw.ar(freq),
	env = (VarSaw.ar(XLine.ar(1,100,dec), width: 0) * 0.5) + 1;
	sig = sig * env;
	sig = sig * EnvGen.ar(Env.perc(0, dec, 1, 0), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\bouncingBall, {
	|freq, amp, dec=2, out, att, pan=0|
	var sig = SinOsc.ar(VarSaw.ar(XLine.ar(1,100,dec), width: 0)),
	env = (VarSaw.ar(XLine.ar(1,100,dec), width: 0) * 0.5) + 1;
	sig = sig * EnvGen.ar(Env.perc(0, dec, 1, 0), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;


SynthDef(\lfoBounce, {
	|freq, amp, dec=2, out, att=0.01, sus=0, lfoF=0.2, max=10, pan=0|
	var sig = SinOsc.ar(freq),
	lfo = (SinOsc.ar(lfoF) * max) + max,
	// env = (VarSaw.ar(XLine.ar(1,100,dec), width: 0) * 0.5) + 1;
	env = (VarSaw.ar(lfo, width: 0.1) * 0.5) + 1;
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * env * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;



SynthDef(\sawFMSynth, {
	|freq=200, amp, sus=1, att=0, dec=0.5, out, i=200, fc=50, pan=0|
	var car = SinOsc.ar(fc) * (VarSaw.ar(1 / ((sus + dec) * 2), width: 1) + 1) * i,
	sig = SinOsc.ar(freq + car);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec, 1, 0), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\waveTable1, {
	|freq=200, amp, att=0, sus=1, dec=0.1, out, pan=0|
	var buffer = Buffer.alloc(s, 2048),
	signal = Signal.newClear(1024),
	sig = {};
	// mod = (abs(SinOsc.ar(1/ ((sus + dec) * 2), mul: 5)) + 1) * 0.2;
	signal.waveFill({
		|x, old, i|
		var out;
		out = sin(x) + sin(5 * x);
		out = out.cubed();
	}, 0, 2pi);
	buffer.loadCollection(signal.asWavetable);
	sig = (Osc.ar(buffer, freq) * 2).fold(-0.5, 0.5);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\waveTable2, {
	|freq=200, amp, att=0, sus=1, dec=0.1, out, pan=0|
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
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\armoBubble, {
	|amp, freq=200, dec=0.5, sus=1, frBubble=30, out, pan=0|
	var sig = VarSaw.ar((/*abs(SinOsc.ar(frBubble)) **/ freq) + 50),
	benv = abs(SinOsc.ar(frBubble)), // single bubble env
	envFil = (SinOsc.ar(1 / ((sus + dec) * 2)) * 4000) + 40; // frequency bubble env
	sig = BBandPass.ar(sig, envFil) * benv;
	sig = sig * EnvGen.ar(Env.linen(0, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
//IMPULSE
SynthDef(\imp, {
	|amp, out, dec=0.5, pan=0|
	var sig = Impulse.ar(1);
	sig = EnvGen.ar(Env.perc(0, dec), doneAction: 2) * sig * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
// SINUSOIDAL GLITCH
SynthDef(\gl1, {
	|amp, out, start=1000, end=500, dec=0.1, pan=0|
	var sig = SinOsc.ar(XLine.ar(start, end, dec));
	sig = sig * EnvGen.ar(Env.linen(0, dec, 0.01), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

// -------- ORGAN -----------
SynthDef(\organ, {
	|freq=200, amp=0.2, dur=0.5, att=0.1, sus=0, rel=1, envelope=1,out, pan=0|
	var /*osc1, osc2, osc3, osc4,*/
	sig = Klang.ar(
		`[
			[freq, freq * 0.3, freq * 0.5, freq * (3/2), freq * 2, freq * 4, freq * 6],
			[0.9, 0.5, 0.4, 0.9, 0.5, 0.1, 0.06],
			[0,0,0,0,0,0,0]
		]
	) * EnvGen.ar(Env.linen(att, sus, rel));
	sig = sig * EnvGen.ar(Env.linen(0, att + sus + rel + 5, 0.1), doneAction: 2);
	sig = sig * amp;
	sig = FreeVerb.ar(sig, 0.5, 200, 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
SynthDef(\ethereal, {
	|freq=200, amp= 0.1, att=0, sus=0, dec=1, out, pan=0|
	var sig = Klang.ar(
		`[
			[freq, freq * (4/3), freq * (3/2), freq * 2, freq * 4, freq * 6],
			[0.9, 0.8, 0.2, 0.1, 0.1, 0.05, 0.01],
			[0].stutter(7)
		],
	);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction:2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\lightSound, {
	|amp=0.5, freq=200, att=0, sus=0.5, rel=1, chord=4,out, pan=0|
	var amplitudes = switch(chord,
		0, {[0.2,0,0,0]},
		1, {[0.2, 0.05, 0,0]},
		2, {[0.2, 0.05, 0.01, 0]},
		3, {[0.2, 0.05, 0.01, 0.005]},
	),
	sig = Klang.ar(
		`[
			[freq, freq * (5/4), freq * (3/2), freq * (15/8)],
			amplitudes,
			[0,0,0,0]
		]
	) * EnvGen.ar(Env.linen(att, sus, rel), doneAction: 2) * amp;
	// sig = BLowPass.ar(sig, MouseY.kr(200, 17000).poll);
	sig = sig * LagUD.kr(amp, 0.5, 0.5);
	Out.ar(out, Pan2.ar(sig,pan));
}).add;

SynthDef(\stone, {
	|amp=0.5, out, pan=0|
	var sig = BBandPass.ar(WhiteNoise.ar(), 200, 0.5) * BLowPass.ar(WhiteNoise.ar(), 100) * 40;
	30.do({
		var env = BLowPass.ar(WhiteNoise.ar(), 2);
		sig = sig +( BBandPass.ar(WhiteNoise.ar(), Rand(400, 1000), 0.5) * env);
	});
	Out.ar(out, Pan2.ar(sig, pan));
}).add;


SynthDef(\phsr, {
	|amp=0.5, freq=200, att=0.01, sus=0.5, dec=1, out, pan=0|
	var sig = Silent.ar(1);
	[freq, freq * 2, freq * 3].do{
		|item, i|
		sig = sig + VarSaw.ar(item,0,1
		) * 1/(i + 1);
	};
	sig = BLowPass.ar(sig, XLine.ar(10000, freq, att+sus+dec), 3);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction:2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\flanger, {
	|freq, amp, dec=2, out, att=0.01, sus=0, lfoF=0.2, cf, dur=1, pan=0|
	var sig = VarSaw.ar(freq, width: 0.8),
	lfo = VarSaw.ar(lfoF, 0,0, 0.003, 0.003),
	// lfo = SinOsc.ar(lfoF, 0, 0.005, 0.005),
	sig2 = VarSaw.ar(freq * 2);
	sig = sig + sig2;
	sig = sig + AllpassL.ar(sig, 10, lfo, 0);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\pad, {
	|amp=0.5, freq=200, att=0.01, sus=0.5, dec=1, lfo=0.2, out, pan=0|
	var sig = Silent.ar(1);
	[freq / 2, freq, freq * 2].do{
		|item, i|
		sig = sig + VarSaw.ar(item,0,1
		) * 1/(i + 1);
	};
	sig = BLowPass4.ar(sig, SinOsc.ar(lfo, 0, 200, freq + 200), 3);
	sig = FreeVerb.ar(sig, 0.3, 3, 10);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec + 10), doneAction:2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\glitchCloud, {
	|freq=12000, amp=0.5, duration=4, numGl=90, out, fMod=(12000*1.23), ampMod=2, pan=0|
	var selector = Amplitude.kr(BLowPass4.ar(WhiteNoise.ar(10), 30, 0.2)).clip(0, 1),
	sig = [
		SinOsc.ar(freq, add:SinOsc.ar(freq*1.34, mul:1.23)),
		SinOsc.ar(freq*1.34, add:SinOsc.ar(freq*4.34, mul:4.23)),
		SinOsc.ar(freq*3.24, add:SinOsc.ar(freq*9.34, mul:1.23))
	];
	selector.poll;
	sig = SelectX.ar(selector*sig.size, sig);
	sig = sig * EnvGen.ar(Env.sine(duration), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan))
}).add;

SynthDef(\notchEnv, {
	|amp=0.5, dur=1, freq=200, att=0.01, sus=0.5, dec=1, out, pan=0|
	var sig = VarSaw.ar(freq),
	lfEnv = SinOsc.ar((1/dur)/2, 3.14, 20, 20),
	lfCtFil = SinOsc.ar((1/dur)/2, 3.14, 15000, 15000),
	env = SinOsc.ar(lfEnv).abs;
	sig = BLowPass.ar(sig, lfCtFil, 5);
	sig = sig * env * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\varsLfo, {
	|amp=0.5, freq=200, att=0.01, sus=0.5, dec=1, lfoF=0.5 ind, out, pan=0|
	var first = BLowPass.ar(
		VarSaw.ar(freq, width:0), freq*2
	),
	second = BLowPass.ar(
		VarSaw.ar(
			(freq*2)+SinOsc.ar(lfoF, 0,(1/24)*freq), width:0

	), (freq*4))*0.2,
	sig = (first+second) * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\thin, {
	|amp=0.5, att=0.01, sus=0.5, dec=1, out, pan=0|
	var freq = Rand(8000, 15000),
	mod = SinOsc.ar(freq/5, 0, 10),
	sig = SinOsc.ar(freq + mod);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, Rand(-1, 1)));
}).add;


SynthDef(\distortion, {
	|amp=0.5,dur, freq, att=0.01, sus=0.5, dec=1, out, distortion=0.4, pan=0|
	var mod = VarSaw.ar(freq/2, 0, 0.5-distortion, 50)*1,
	// (Lag2UD.ar(Dust.ar(30), 0, dur/4) + 0.5),
	sig = VarSaw.ar(freq, width:0.5+distortion,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec*4), doneAction: 2) * amp * 0.01;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\magma, {
	|amp=0.5, dur, freq, att=0.01, sus=0.5, dec=1, ind=10, out, pan=0|
	var mod = SinOsc.ar(BLowPass.ar(WhiteNoise.ar(50), 2)*(freq*2) + (freq*2), 0, BLowPass.ar(WhiteNoise.ar(100), 2)*ind),
	sig = SinOsc.ar(freq + mod);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\fx,{
	|in|
	// var sig = CombC.ar(In.ar(in), 1, 0.25, 2);
	var sig = In.ar(in);
	Out.ar(0, sig!2);
}).add;

SynthDef(\rev,{
	|in, mix=1, room=10, damp=10|
	var sig = In.ar(in);
	sig = sig + CombC.ar(sig, 1, 0.25, 2);
	// sig = FreeVerb.ar(sig, mix, room, damp);
	Out.ar(0, sig!2);
}).add;

SynthDef(\varsLP, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0, dur|
	var freq2 = freq*2,
	sig1 = BLowPass4.ar(VarSaw.ar(freq, width: 1), XLine.ar(freq*10, freq, dur) ,4),
	sig2 = BLowPass4.ar(VarSaw.ar(freq2, width: 1), XLine.ar(freq2*10, freq2, dur) ,4),
	sig = sig1 + sig2;
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;


SynthDef(\varsEnv, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0, dur|
	var sig = VarSaw.ar(freq, width: 1);
	sig = BLowPass.ar(sig, EnvGen.ar(Env.xyc([[0.0, freq, \exp], [0.01, freq*4, \squared], [att+sus+dec/2, freq/2, \exp]])), 8);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\am, {
	|att=0, sus=0, dec=1, amp=0.1, freq=200, carFR=1, modFR=1, modA=0, ind=0, out, pan=0|
	var	indexEnv = Line.ar(ind, 0, att + sus + dec),
	modSin = SinOsc.ar(freq/150),
	carrSin = SinOsc.ar((freq * carFR))*modSin;
	carrSin = carrSin * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(carrSin, pan));
}).add;


SynthDef(\sbrubble, {
	|att=0, sus=0, dec=1, amp=0.1, freq=200, carFR=1, modFR=1, modA=0, ind=0, out, pan=0|
	var duration = att+sus+dec,
	envM = EnvGen.ar(Env.linen(duration*(2/4), duration*(1/4), duration*(1/4))),
	ampM = SinOsc.ar((freq/2)*envM),
	fmM = SinOsc.ar(freq*2, mul: freq*30*envM),
	sig = SinOsc.ar(freq + fmM)*ampM;
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\varsPew, {
	|amp=0.1, freq=200, att=0, sus=0, dec=1, out, lfoF=0.5, pan=0, pewEnv=0.02|
	var pew = XLine.ar(freq*8, freq, pewEnv),
	sig = VarSaw.ar(pew, width: 1);
	sig = RLPF.ar(sig, SinOsc.ar(lfoF, 0, freq*2, freq*4), 10);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\particles, {
	|att=0, sus=0, dec=1, amp=0.1, freq=200, out, pan=0|
	var duration = att+sus+dec,
	envM = EnvGen.ar(Env.asr(0.001, duration, 0.001)),
	ampM = VarSaw.ar((freq/30)*envM),
	sig = VarSaw.ar(freq)*ampM;
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\ambient, {
	|freq=200, amp = 0, sus, dec=0.1, att, out, pan=0, cf=400|
	var sig = VarSaw.ar(freq, width: 0);
	sig = BLowPass4.ar(sig, cf);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

/*
Synth(\am, [\amp, 0.4, \dur, 2, \att, 0.01, \sus, 0, \dec, 2, \freq, 10000, \out, 0])
Env.xyc([[0.0, 0.0, \exp], [0.01, 1, \squared], [1, 0, \exp]]).plot

(Env.xyc([[0.0, 0.0, \exp], [0.01, 1, \squared], [1, 0, \exp]])*300).plot*/































