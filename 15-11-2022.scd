StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 4;
s.latency = 0.201;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\kick_zarro]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([1], 4),
		Pseq([1], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\out, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Clap02]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([1], 4),
		Pseq([2], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\out, 0,
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 1]).play();
)

(
Pbindef(\s1,
	\instrument, \distortion,
	\octave, Pseq([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.46,
	\degree, Prand([
		Pseq([[0, 7]], 1),
		Pseq([[0, 8]], 1),
		Pseq([[1, 7]], 1),
		Pseq([[1, 8]], 1),
		// Pseq([[0, 4]], 16),
		// Pseq([[0, 4, 7]]-2, 1),
		// Pseq([[0, 4, 7]], 1),
		// Pseq([[0, 4, 7]]+3, 1),
		// Pseq([[0, 4, 7]]-2, 1),
		// Pseq([[0, 4, 7]]+4, 1),
		// Pseq([[0, 4, 7]]+3, 1),
		// Pseq([[0, 4, 7]]+4, 1),
		// Pseq([[0, 4, 7], [-5, -1, 2]], 1),
		// Pseq([[2, 6, 9]]-9, 1),
	], inf),
	\dur, Pseq([
		// Pseq([0.25, 0.75, 0.5, 0.5], 4),
		// Pseq([8], 4),
		// Pseq([0.75, 0.75, 0.75, 0.75, 0.5, 0.5], 4),
		Pseq([0.25], 1)
	], inf),
	\att, 0.001,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, Pwhite(-1, 1),
	\out, 0,
	\amp, 0.5
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s1,
	\instrument, \distortion,
	\octave, Pseq([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.48,
	\degree, Pseq([
		Pseq([[0, 7]], 1),
		Pseq([[0, 7.1]], 1),
		Pseq([[-1, 6]], 1),
		Pseq([[3.1, 10]], 1),
		// Pseq([[3, 10]], 4),
		// Pseq([[3.1, 10]], 4),
		// Pseq([[0, 4]], 16),
		// Pseq([[0, 4, 7]]-2, 1),
		// Pseq([[0, 4, 7]], 1),
		// Pseq([[0, 4, 7]]+3, 1),
		// Pseq([[0, 4, 7]]-2, 1),
		// Pseq([[0, 4, 7]]+4, 1),
		// Pseq([[0, 4, 7]]+3, 1),
		// Pseq([[0, 4, 7]]+4, 1),
		// Pseq([[0, 4, 7], [-5, -1, 2]], 1),
		// Pseq([[2, 6, 9]]-9, 1),
	], inf).stutter(1),
	\dur, Pseq([
		// Pseq([0.25, 0.75, 0.5, 0.5], 4),
		// Pseq([8], 4),
		// Pseq([0.75, 0.75, 0.75, 0.75, 0.5, 0.5], 4),
		Pseq([4], 1)
	], inf),
	\att, Pkey(\dur)*l.beatDur/2,
	\sus, 0,
	\dec, 0.25,
	\pan, Pwhite(-0.75, 0.75),
	\out, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s3,
	\instrument, \sin,
	\octave, Pseq([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0, 7, 0, 6, -3, -1], 1),
		Pseq([0, 10, 0, 9, -3, -1], 1)
		// Pseq([0, 7],1),
		// Pseq([3,4],1),
	], inf),
	\dur, Pseq([
		Pseq([0.75, 0.75, 0.75, 0.75, 0.5, 0.5], 4),
		// Pseq([0.25, 1.75], 4),
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, l.beatDur,
	\pan, 0,
	\out, 0,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)


(
~tremS.free;
SynthDef(\trem,{
	|in, mix=0.5, room=10, damp=10|
	var sig = In.ar(~tremB.index, 2);
	sig = sig * SinOsc.ar(SinOsc.ar(l.beatDur/8, mul:10));
	Out.ar(0, Pan2.ar(sig!2, SinOsc.ar(l.beatDur/4, mul: 0.75)));
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






