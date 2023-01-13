StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 4;
s.latency = 0.201;
// \Kick10

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\kick_zarro]], inf),
	\dur, Pseq([
		Pseq([1], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([0.75, 0.75, 1.5, 1.5, 1.5, 1.5, 0.5], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\out, 0,
	\amp, 0.3,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\sn1,
	\instrument, \sample,
	\buf, Pseq([d[\paper]], inf),
	\dur, Pseq([
		Pseq([16], 4),
	], inf),
	\rate, Pseq([0.05], inf),
	\pan, 0,
	\out, ~revbB,
	\amp, 0.2,
);
Pbindef(\sn1).stop.quant_([4, 0]).play();
)

(
SynthDef(\revb,{
	|in, mix=0.5, room=10, damp=10|
	var sig = In.ar(~revB.index, 2);
	sig = (sig[0] + sig[1])/2;
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = FreeVerb.ar(sig, mix, room, damp);
	Out.ar(0, sig!2);
}).add;
)

(
SynthDef(\revb,{
	|in, mix=0.5, room=1000, damp=5|
	var sig = In.ar(~revbB.index, 2);
	sig = (sig[0] + sig[1])/2;
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = FreeVerb.ar(sig, mix, room, damp);
	Out.ar(0, sig!2);
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
	sig = sig * SinOsc.ar(1).abs;
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
	sig = sig + CombC.ar(sig, 1, 0.75*l.beatDur, 8*l.beatDur);
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
	sig = sig + CombC.ar(sig, 1, 0.75*l.beatDur, 8*l.beatDur);
	sig = BLowPass.ar(sig, SinOsc.ar(l.beatDur/4, mul: 10000, add: 10300));
	Out.ar(0, Pan2.ar(sig, SinOsc.ar(l.beatDur/4, mul:0.5)));
}).add;
~comb2S = Synth(\comb2);
)

(
Pbindef(\s4,
	\instrument, \distortionPulse,
	\distortion, 0.46,
	\octave, Pseq([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0,2,4]], 1),
		// Pseq([[0,2,4]], 1)-2,
		// Pseq([[0,2,4]], 1)-1,
		// Pseq([[0,2,4]], 1)-4,
		Pseq([[0,2,4]], 1),
		Pseq([[0,2,4]], 1)+2,
		Pseq([[0,2,4]], 1)+5,
		Pseq([[0,2,4]], 1)+6,
	], inf),
	\dur, Pseq([4], inf),
	// \dur, Pseq([0.25, 0.75, 3], inf),
	\att, Pkey(\dur)*l.beatDur/2,
	\ind, 20,
	\sus, 0,
	\dec, 0.001,
	\pan, 0,
	\out, ~comb2B,
	\amp, 0
	);
Pbindef(\s4).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\s2,
	\instrument, \distortion,
	\distortion, 0.5,
	\octave, Pseq([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([-2, -3], 4),
		Pseq([0,1,2,3,4], 2),
	], inf)+3,
	\dur, Pseq([
		// Pseq([0.75], 4),
		Pseq([0.25], 5)
	], inf),
	// \dur, Pseq([0.25, 0.75, 3], inf),
	\att, 0.001,
	\ind, 20,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, ~combB,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s1,
	\instrument, \distortionPulse,
	\distortion, 0.46,
	\octave, Prand([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,2,4]], 7),
		Pseq([[0,2,4]]+5, 7),
		// Pseq([[0,2,4]]+4, 7)
	], inf),
	\dur, Pseq([0.75, 0.75, 1.5, 1.5, 1.5, 1.5, 0.5], inf),
	// \dur, Pseq([0.25], inf),
	\att, 0.001,
	\ind, 10,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, ~comb2B,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
SynthDef(\distortionPulse, {
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
	// sig = BLowPass4.ar(sig, freq*7);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2)*amp;
	Out.ar(out, Pan2.ar(sig, pan))
}).add;
)

(
SynthDef(\distortionPulse, {
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
	sig = BLowPass4.ar(sig, freq*7);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2)*amp;
	Out.ar(out, Pan2.ar(sig, pan))
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
~revbS.free;
SynthDef(\revb,{
	|in, mix=0.6, room=100, damp=5|
	var sig = In.ar(~revbB.index, 2);
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = FreeVerb.ar(sig, mix, room, damp);
	Out.ar(0, sig!2);
}).add;

~revbS = Synth(\revb);
)






