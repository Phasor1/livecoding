StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 0;
s.latency = 0.01;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Snare14]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([2, 0.75, 1.25], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\out, ~revB,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 1]).play();
)

(
Pbindef(\k1,
	\instrument, \sample,
	\buf, Pseq([d[\kick_zarro]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([1, 1], 4),
		Pseq([1, 1, 0.75, 0.25, 0.5, 0.5], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\out, 0,
	\amp, 0,
);
Pbindef(\k1).stop.quant_([4, 0]).play();
)


(
Pbindef(\s1,
	\instrument, \sin,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		Pseq([0,7, 0, 6], 1),
		Pseq([0,7, 4,4,6,5,4], 1),
	], inf),
	\dur, Pseq([
		Pseq([2, 2, 2, 2], 1),
		Pseq([2, 2, 1, 1, 0.5, 0.5, 1], 1),
	], inf),
	\att, 0.001,
	\ind, 10,
	\sus, 0,
	\dec, Pkey(\dur)/2,
	\pan, 0,
	\out, ~revB,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s2,
	\instrument, \armoNoiz,
	\octave, Pseq([5, 7], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		Pseq([[0, 7]], 1),
	], inf),
	\dur, Pseq([8], inf),
	\att, Pkey(\dur)*l.beatDur,
	\ind, 10,
	\sus, 0,
	\dec, 0.001,
	\pan, 0,
	\out, 0,
	\amp, 0.2
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s4,
	\instrument, \teng,
	\octave, Pseq([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		// Pseq([[0,3,7]-3], 1),
		Prand([0,4, 7], 1)
/*		Pseq([0], 16),
		Pseq([0], 16)-3,
		Pseq([6], 16),
		Pseq([5], 8),
		Pseq([2], 4),
		Pseq([1], 4),*/
	], inf),
	\dur, Pseq([0.25], inf),
	\att, 0.001,
	\ind, 10,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, 0,
	\amp, 0
	// \amp, Pwhite(0.02, 0.2)
	);
Pbindef(\s4).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s3,
	\instrument, \distortion,
	\distortion, 0.5,
	\octave, Pseq([5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		// Pseq([[0,3,7]-3], 1),
		Pseq([[0,2,4, 7]], 1),
		Pseq([[0,4, 7]], 1)-4,
	], inf).stutter(6),
	\dur, Pseq([0.75, 0.75, 0.75, 0.75, 0.5, 0.5], inf),
	\att, 0.001,
	\ind, 10,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, 0,
	\amp, 0.2
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s3,
	\instrument, \varsLfo,
	\octave, Pseq([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		// Pseq([[0,3,7]-3], 1),
		Pseq([[0,4, 7]], 1),
		// Pseq([[0,4, 5]], 1),
		// Pseq([[0,4, 7]], 1)-2,
	], inf).stutter(1),
	\dur, Pseq([8], inf),
	\att, 0.001,
	\ind, 10,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, 0,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)
//MINOR
(
Pbindef(\s1,
	\instrument, \ten,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		Pseq([
			Pseq([0,7, 0, 7], 1),
			Pseq([0,7, 0, 9], 1),
		]+3, 1),
		Pseq([
			Pseq([0,7, 0, 7], 1),
			Pseq([0,7, 0, 9], 1),
		]+2, 1),
		Pseq([
			Pseq([0,7, 0, 7], 1),
			Pseq([0,7, 0, 9], 1),
		]+1, 1),
		Pseq([
			Pseq([0,7, 0, 7], 1),
			Pseq([0,7, 0, 9], 1),
		], 1)
	], inf),
	\dur, Pseq([
		Pseq([1, 1, 1, 1], 1),
	], inf),
	\att, 0.001,
	\ind, 6,
	\sus, 0,
	\dec, l.beatDur/2,
	\pan, 0,
	\out, ~combB,
	\amp, 0.2
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s1,
	\instrument, \fmBass,
	\octave, Prand([7], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		0, 1,
	], inf),
	\dur, Pseq([
		Pseq([4], 1),
	], inf),
	\att, 0.001,
	\ind, 6,
	\sus, 0,
	\dec, l.beatDur/2,
	\pan, 0,
	\out, ~combB,
	\amp, 0.05
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s4,
	\instrument, \varsLfo,
	\octave, Pseq([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		// Pseq([[0,3,7]-3], 1),
		Pseq([[0,4, 7]], 1),
		// Pseq([[0,4, 5]], 1),
		// Pseq([[0,4, 7]], 1)-2,
	], inf).stutter(1),
	\dur, Pseq([8], inf),
	\att, 0.001,
	\ind, 10,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, 0,
	\amp, 0
	);
Pbindef(\s4).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s5,
	\instrument, \varsAmbient,
	\octave, Pseq([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		// Pseq([[0,3,7]-3], 1),
		Pseq([[0,4, 7], [3, 7, 11], [0,4,7], [2,7,11]], 1),
		// Pseq([[0,4, 5]], 1),
		// Pseq([[0,4, 7]], 1)-2,
	], inf).stutter(1),
	\dur, Pseq([4], inf),
	\att, 0.001,
	\ind, 10,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, 0,
	\amp, Pseq([0], inf)
	);
Pbindef(\s5).stop.quant_([4, 0]).play(l);
)

(

~combS.free;
SynthDef(\comb,{
	|in|
	var sig = In.ar(~combB.index, 2);
	sig = (sig[0] + sig[1])/2;
	sig = sig + CombC.ar(sig, 1, 0.75/l.beatDur/4, 8*l.beatDur);
	Out.ar(0, sig!2);
}).add;
~combS = Synth(\comb);
)



(
SynthDef(\rev,{
	|in, mix=0.6, room=4, damp=40|
	var sig = In.ar(~revB.index, 2);
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = FreeVerb.ar(sig, mix, room, damp);
	Out.ar(0, sig!2);
}).add;

~revS.free;
~revS = Synth(\rev);
)
