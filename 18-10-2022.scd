StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 9;
s.latency = 0.201;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick10]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([8], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\out, ~revbB,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\paper]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([8], 4),
	], inf),
	\rate, Pseq([0.6], inf),
	\pan, 0,
	\out, ~revB,
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 0]).play();
)

(
Pbindef(\sn1,
	\instrument, \sample,
	\buf, Pseq([d[\paper]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([8], 4),
	], inf),
	\rate, Pseq([0.6], inf),
	\pan, 0,
	\out, ~revB,
	\amp, 0,
);
Pbindef(\sn1).stop.quant_([4, 0]).play();
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
	\out, 0,
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
	sig = BLowPass4.ar(sig, SinOsc.ar(l.beatDur, mul: 18000-60, add:18000));
	Out.ar(0, sig!2);
}).add;
~comb2S = Synth(\comb2);
)

(
Pbindef(\s4,
	\instrument, \distortionPulse,
	\distortion, 0.46,
	\octave, Prand([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,2,4]], 2),
		Pseq([[-2,0,2]], 1),
		Pseq([[-1,1,3]], 1),

/*		Pseq([0, 7, 6], 1),
		Pseq([0, 8, 7], 1),
		Pseq([0, 6, 5], 1),
		Pseq([0, 5, 4], 1),*/
		// Pseq([-3, -2, 0, 3], 1),
		// Pseq([-1, 0], 2),
	], inf),
	\dur, Pseq([4], inf),
	// \dur, Pseq([0.25, 0.75, 3], inf),
	\att, Pkey(\dur)*l.beatDur/2,
	\ind, 20,
	\sus, 0,
	\dec, 0.001,
	\pan, 0,
	\out, ~combB,
	\amp, 0
	);
Pbindef(\s4).stop.quant_([4, 0]).play(l);
)

(
SynthDef(\sin, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0|
	var sig = SinOsc.ar(freq);
	sig = sig + SinOsc.ar(SinOsc.ar(l.beatDur/2, mul: 8,add: freq/2));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)


(
SynthDef(\sin, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0|
	var sig = SinOsc.ar(freq);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)


(
Pbindef(\s4,
	\instrument, \teng,
	\octave, Prand([7], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0, 5, 3, 7], 2),
		// Pseq([-1, 0], 2),
	], inf).stutter(16),
	\dur, Pseq([0.25], inf),
	\att, 0.001,
	\ind, 20,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur/2,
	\pan, 0,
	\out, 0,
	\amp, 0.1
	);
Pbindef(\s4).stop.quant_([4, 0]).play(l);
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
	|in, mix=0.6, room=100, damp=500|
	var sig = In.ar(~revbB.index, 2);
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = FreeVerb.ar(sig, mix, room, damp);
	Out.ar(0, sig!2);
}).add;

~revbS = Synth(\revb);
)






