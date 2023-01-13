StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 0;
s.latency = 0.201;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07], d[\Clap06]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([1], 4),
		Pseq([8], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\out, ~comb2B,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)
Pbindef(\k).stop;
Pbindef(\s1).stop;

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Clap05], d[\Clap04]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([2], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\out, ~combB,
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 0]).play();
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, d[\paper],
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([8], 4),
	], inf),
	\rate, Pseq([0.1], inf),
	\pan, 0,
	\out, ~comb2B,
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 0]).play();
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
Pbindef(\cl,
	\instrument, \sample,
	\buf, Pseq([d[\Clap07]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([0.75], 1),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\cl).stop.quant_([4, 0]).play();
)


(
Pbindef(\s1,
	\instrument, \varsLfo,
	\octave, Pseq([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.49,
	\degree, Pseq([
		Pseq([[0, 2,4]], 1),
		// Pseq([[0.1, 4, 7]], 1),
		// Pseq([[-1,1,3]], 1),
		Pseq([[-2, 0, 2]], 1),
		// Pseq([[2,4,6]], 1),
		// Pseq([[0]], 1),
		// Pseq([[2]], 8),
		// Pseq([[-1.1]], 8),
		// Pseq([[0]], 8),
		// Pseq([[6.1]], 1),
		// Pseq([[0,2,4], [-2, 0, 2]], 1),
		// Pseq([[0,2,4], [2,4,6]], 1),
		// Pseq([[0,2,4], [-1,1,3]], 1),
		// Pseq([[2,6], [3,7]], 1)
	], inf),
	\dur, Pseq([
		// Pseq([0.25, 0.75, 0.5, 0.5], 4),
		Pseq([16], 4),
	], inf),
	\att, Pkey(\dur)*l.beatDur/2,
	\sus, 0,
	\dec, 0.01,
	\pan, 0,
	\out, ~combB,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)


(
SynthDef(\distortion, {
	|amp=0.5,dur, freq, att=0.01, sus=0.5, dec=1, out, distortion=0.4, pan=0|
	var mod = VarSaw.ar(MouseX.kr(freq/2, freq*8), 0, 0.5-distortion, 50)*1,
	// (Lag2UD.ar(Dust.ar(30), 0, dur/4) + 0.5),
	sig = VarSaw.ar(freq, width:0.5+distortion,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp * 0.01;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
SynthDef(\distortion, {
	|amp=0.5,dur, freq, att=0.01, sus=0.5, dec=1, out, distortion=0.4, pan=0|
	var mod = VarSaw.ar(freq/2, 0, 0.5-distortion, 50)*1,
	// (Lag2UD.ar(Dust.ar(30), 0, dur/4) + 0.5),
	sig = VarSaw.ar(freq, width:0.5+distortion,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp * 0.01;
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

	), MouseX.kr(300, 18000))*0.2,
	sig = (first+second);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction:2)*amp;
	// sig = sig * EnvGen.ar(Env.linen(0, 4, 0), doneAction: 2);
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

	), (10000))*0.2,
	sig = (first+second);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction:2)*amp;
	// sig = sig * EnvGen.ar(Env.linen(0, 4, 0), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)


(
Pbindef(\s2,
	\instrument, \armoNoiz,
	\octave, Pseq([4, 5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([8],2),
	], inf),
	\dur, Pseq([
		Pseq([8], 4),
		// Pseq([0.25, 1.75], 4),
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, l.beatDur*8,
	\pan, 0,
	\out, 0,
	\amp, 0.5
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s2,
	\instrument, \sin,
	\octave, Pseq([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0, -3, 4,2 ,6,7], 1),
		// Pseq([5,4,3], 1),
		// Pseq([7,0,7,0], 2),

		// Pseq([5,4,3], 1),
		// Pseq([6,0,6,0], 2)
	], inf),
	\dur, Pseq([
		// Pseq([1], 4),
		Pseq([0.75, 0.75, 0.75, 0.75, 0.5, 0.5], 1),
	], inf)*2,
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, 0,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)


(
SynthDef(\distortionPulseRandom, {
	|amp=0.5, att=0.01, sus=0, dec=1, freq=440, pan=0, lfo=1, out|
	var sig = Pulse.ar(freq) + SinOscFB.ar(freq/2, 70),
	nArms = 5,
	det = 0;
	nArms.do{
		|i|
		sig = sig + SinOsc.ar(freq*(i+1)+det) * nArms/(i+1);
		sig = sig + SinOsc.ar(freq/(i+1)-det) * nArms/(i+1);
	};
	// sig = (sig * 30).clip(-1, 1);
	sig = sig.clip(-1, 1);
	sig = BLowPass4.ar(sig, TExpRand.kr(lo: 300, hi: 18000, trig: Impulse.ar(10, add:-0.01)));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2)*amp;
	Out.ar(out, Pan2.ar(sig, pan))
}).add;
)

(
SynthDef(\distortionPulseRandom, {
	|amp=0.5, att=0.01, sus=0, dec=1, freq=440, pan=0, lfo=1, out|
	var sig = Pulse.ar(freq) + SinOscFB.ar(freq/2, 70),
	nArms = 5,
	det = 0;
	nArms.do{
		|i|
		sig = sig + SinOsc.ar(freq*(i+1)+det) * nArms/(i+1);
		sig = sig + SinOsc.ar(freq/(i+1)-det) * nArms/(i+1);
	};
	// sig = (sig * 30).clip(-1, 1);
	sig = sig.clip(-1, 1);
	sig = BLowPass4.ar(sig, TExpRand.kr(lo: freq, hi: freq*6, trig: Impulse.ar(10, add:-0.01)));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2)*amp;
	Out.ar(out, Pan2.ar(sig, pan))
}).add;
)

(
~tremS.free;
SynthDef(\trem,{
	|in, mix=0.5, room=10, damp=10|
	var sig = In.ar(~tremB.index, 2);
	sig = (sig[0] + sig[1])/2;
	sig = BLowPass4.ar(sig, SinOsc.ar(l.beatDur/4, phase: l.beatDur/2, mul: 15000, add: 15300));
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
	sig = sig + CombC.ar(sig, 1, 0.75*l.beatDur*2, 8*l.beatDur);
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
	sig = CombC.ar(sig, 1, l.beatDur*2, 16*l.beatDur);
	Out.ar(0, sig!2);
}).add;
~comb2S = Synth(\comb2);
)

Pbindef(\s1).stop;
Pbindef(\s2).stop;
Pbindef(\s3).stop;


Pbindef(\s1).stop.quant_(4, 0).play(l);
Pbindef(\s2).stop.quant_(4, 0).play(l);
Pbindef(\s3).stop.quant_(4, 0).play(l);

(

~combS.free;
SynthDef(\comb,{
	|in|
	var sig = In.ar(~combB.index, 2);
	sig = (sig[0] + sig[1])/2;
	sig = CombC.ar(sig, 1, l.beatDur, 8*l.beatDur);
	Out.ar(0, sig!2);
}).add;
~combS = Synth(\comb);
)



(
SynthDef(\rev,{
	|in, mix=0.6, room=40, damp=1|
	var sig = In.ar(~revB.index, 2);
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = FreeVerb.ar(sig, mix, room, damp);
	Out.ar(0, sig!2);
}).add;

~revS.free;
~revS = Synth(\rev);
)






