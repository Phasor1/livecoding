StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 0;
s.latency = 0.201;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([0.75, 1.75, 1.5, 2, 2], 4),
	], inf),
	\rate, Pseq([0.7], inf),
	\pan, 0,
	\out, ~revB,
	\amp, 0.1,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\kick_zarro]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([4], 4),
		// Pseq([0.75, 1.75, 1.5, 2, 2], 4)
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\out, 0,
	\amp, 0.5,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)


(
~revS.free;
SynthDef(\revb,{
	|in, mix=0.5, room=40, damp=1|
	var sig = In.ar(~revbB.index, 2);
	sig = (sig[0] + sig[1])/2;
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = FreeVerb.ar(sig, mix, room, damp);
	Out.ar(0, sig!2);
}).add;
~revS = Synth(\revb);
)


(
Pbindef(\k,
	\instrument, \sampleEnv,
	\buf, Pseq([d[\paper]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([8], 4),
	], inf),
	\rate, Pseq([1], inf),
	\att, 0.01,
	\sus, 0,
	\rel, 1*l.beatDur,
	\pan, 0,
	\out, ~comb2B,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)


(
Pbindef(\s1,
	\instrument, \varsAmbient,
	\octave, Pseq([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.49,
	\degree, Pseq([
		Pseq([[0,2,4]], 1),
		Pseq([[0,2,4]], 1)-2,
		Pseq([[0,2,4]], 1)+2,
		Pseq([[0,2,4]], 1)+7,
		// Pseq([[0,2,4]], 1),
		// Pseq([[0,2,4]], 1)-2,
		// Pseq([[0,2,4]], 1),
		// Pseq([[0,2,4]], 1)+2,
	], inf),
	\dur, Pseq([
		// Pseq([0.25, 0.75, 0.5, 0.5], 4),
		Pseq([8], 4),
	], inf),
	\att, 4*l.beatDur,
	\sus, 0,
	// \lfo, 0.2*l.beatDur,
	\dec, 4*l.beatDur,
	\pan, 0,
	\out, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

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
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)


(
Pbindef(\s1,
	\instrument, \flanger,
	\octave, Pseq([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.49,
	\degree, Pseq([
		Pseq([[0,2,4]], 2),
		Pseq([[0,2,4]], 2)+2,
	], inf),
	\dur, Pseq([
		// Pseq([0.25, 0.75, 0.5, 0.5], 4),
		Pseq([3.75, 0.25], 4),
	], inf),
	\att, 0.02,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, ~combB,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s2,
	\instrument, \teng,
	\octave, Pseq([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.49,
	\degree, Pseq([
		Pseq([0,7,5,4,3], 2),
		Pseq([9,7,5,4,3], 1),
		Pseq([8,7,5,4,3], 1),
	], inf),
	\dur, Pseq([
		// Pseq([0.25, 0.75, 0.5, 0.5], 4),
		Pseq([1,1,0.75, 0.75, 0.5], 4),
	], inf),
	\att, 0.001,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, ~combB,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s3,
	\instrument, \sin,
	\octave, Pseq([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.49,
	\degree, Pseq([
		Pseq([2,0,-2], 2),
		Pseq([2,0,-2], 4)+4,
	], inf),
	\dur, Pseq([
		// Pseq([0.25, 0.75, 0.5, 0.5], 4),
		Pseq([1], 4),
	], inf),
	\att, 0.001,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, 0,
	\amp, 0.2
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)

(
SynthDef(\sin, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0|
	var sig = SinOsc.ar(XLine.ar(freq*4, freq, 0.01));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(

~combS.free;
SynthDef(\comb,{
	|in|
	var sig = In.ar(~combB.index, 2);
	sig = (sig[0] + sig[1])/2;
	sig = sig + CombC.ar(sig, 1, 0.75*l.beatDur, 8*l.beatDur);
	Out.ar(0, sig!2);
}).add;
~combS = Synth(\comb);
)

(
~tremS.free;
SynthDef(\trem,{
	|in, mix=0.5, room=10, damp=10|
	var sig = In.ar(~tremB.index, 2);
	sig = (sig[0] + sig[1])/2;
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	// sig = sig * SinOsc.ar(l.beatDur/8, mul:0.25, add:0.5);
	sig = BLowPass4.ar(sig, SinOsc.ar(4/l.beatDur, mul:15000, add:15000));
	sig = FreeVerb.ar(sig, 0.3, 10, 10);
	Out.ar(0, Pan2.ar(sig, SinOsc.ar(l.beatDur/4, mul: 0.75)));
}).add;
~tremS = Synth(\trem);
)

(

~combS.free;
SynthDef(\comb,{
	|in|
	var sig = In.ar(~combB.index, 2);
	sig = (sig[0] + sig[1])/2;
	sig = sig + CombC.ar(sig, 1, 0.25*l.beatDur, 8*l.beatDur);
	sig = FreeVerb.ar(sig, 0.5, 100, 1);
	Out.ar(0, sig!2);
}).add;
~combS = Synth(\comb);
)

(

~comb2S.free;
SynthDef(\comb2,{
	|in|
	var sig = In.ar(~comb2B.index, 2);
	sig = (sig[0] + sig[1])/2;
	sig = sig + CombC.ar(sig, 1, 2*l.beatDur, 8*l.beatDur);
	Out.ar(0, Pan2.ar(sig, SinOsc.ar(l.beatDur*2, mul: 0.5)));
}).add;
~comb2S = Synth(\comb2);
)
