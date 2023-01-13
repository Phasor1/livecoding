StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 9;
s.latency = 0.201;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, d[\kick_zarro],
	\dur, Pseq([
		Pseq([1], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([0.125, 3.975], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\out, 0,
	\amp, 1,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Clap04]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([2], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\out, ~revB,
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 1]).play();
)

Pbindef(\k).stop;
Pbindef(\sn).stop;



Pbindef(\k).stop.quant_([4, 1]).play();
Pbindef(\sn).stop.quant_([4, 1]).play();

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
	\instrument, \distortionPulse,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		0
		// Pseq([[0,2,4]], 1),
		// Pseq([[0,2,4]], 1)+4,
		// Pseq([[0,3,4]], 1),
		// Pseq([[5, 7, 9]], 1),
		// Pseq([[7, 9, 11]], 1),
	], inf).stutter(16),
	\distortion, 0.49,
	\dur, Pseq([0.25], inf),
	\att, 0.001,
	\strum, 0,
	\ind, 8,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\out, 0,
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
	sig = BLowPass4.ar(sig, 12000);
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
Pbindef(\s2,
	\instrument, \teng,
	\octave, 4,
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0, 2], 1),
		Pseq([0, 3], 1),
		Pseq([1, 3], 1),
		Pseq([1, 4], 1),
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		// Pseq([[0,2,4]], 1),
		// Pseq([[0,3,4]], 1),
		// Pseq([[2,4,6]], 1),
		// Pseq([[3,5,7]], 1),
	], inf)+Pseq([0, 0, -2, -1], inf).stutter(1),
	\dur, Pseq([0.25, 0.5], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur/2,
	\pan, 0,
	\strum, 0,
	// \strum, 0.5*l.beatDur,
	\out, ~combB,
	\amp, 0.7
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\k).stop;
Pbindef(\s2).stop;
)

(
Pbindef(\s3,
	\instrument, \teng,
	\octave, 6,
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0,2,3,4,6, 5], 1)
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		// Pseq([[0,2,4]], 1),
		// Pseq([[0,3,4]], 1),
		// Pseq([[2,4,6]], 1),
		// Pseq([[3,5,7]], 1),
	], inf),
	\dur, Pseq([0.5, 0.5, 0.5, 0.5, 1.25, 3.75], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur/2,
	\pan, 0,
	\strum, 0,
	// \strum, 0.5*l.beatDur,
	\out, 0,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s2,
	\instrument, \armoNoiz,
	\octave, [4],
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		Pseq([[0,2,4]], 1),
	], inf),
	\dur, Pseq([4], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	// \strum, 0,
	\strum, 0.25*l.beatDur,
	\out, ~combB,
	\amp, 0.1
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(

~combS.free;
SynthDef(\comb,{
	|in|
	var sig = In.ar(~combB.index, 2);
	sig = (sig[0] + sig[1])/2;
	sig = sig + CombC.ar(sig, 1, 0.5*l.beatDur, 8*l.beatDur);
	Out.ar(0, sig!2);
}).add;
~combS = Synth(\comb);
)

(

~comb2S.free;
SynthDef(\comb,{
	|in|
	var sig = In.ar(~comb2B.index, 2);
	sig = (sig[0] + sig[1])/2;
	sig = sig * Pulse.ar();
	Out.ar(0, sig!2);
}).add;
~comb2S = Synth(\comb);
)




(
~revS.free;
SynthDef(\rev,{
	|in, mix=0.6, room=40, damp=1|
	var sig = In.ar(~revB.index, 2);
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = FreeVerb.ar(sig, mix, room, damp);
	Out.ar(0, sig!2);
}).add;

~revS = Synth(\rev);
)






