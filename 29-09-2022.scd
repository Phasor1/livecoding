StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 9;
s.latency = 0.201;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([2], 4),
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
	\buf, Pseq([d[\Clap05]], inf),
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
	\octave, Prand([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0, 2, 4], [0, 2, 4]+2], 1),
		Pseq([[0,2,4]], 1),
		Pseq([[0,2,4]]+2, 1),
		Pseq([[0,2,4]]+4, 1),
		Pseq([[0,2,4]]+7, 1),
	], inf),
	\dur, Pseq([4], inf),
	\att, 2*l.beatDur,
	\distortion, 0.49,
	\ind, 8,
	\sus, 0,
	\dec, 0.001,
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
	sig = BLowPass4.ar(sig, MouseX.kr(300, 17000));
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

~comb2S.free;
SynthDef(\comb2,{
	|in|
	var sig = In.ar(~comb2B.index, 2);
	sig = (sig[0] + sig[1])/2;
	sig = sig + CombC.ar(sig, 1, 0.75*l.beatDur, 8*l.beatDur);
	Out.ar(0, Pan2.ar(sig, SinOsc.ar(l.beatDur*2, mul: 0.5)));
}).add;
~comb2S = Synth(\comb2);
)


(
Pbindef(\s2,
	\instrument, \vars,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([2,3,4], 1),
		Pseq([7,0], 1),
		Pseq([2,3,4], 1),
		Pseq([8,1], 1),
		Pseq([2,3,4], 1),
		Pseq([5, -2], 1)
	], inf),
	\dur, Pseq([
		Pseq([0.25, 0.25, 0.75], 1),
		Pseq([0.25, 2.75], 1),
	], inf),
	\att, 0.001,
	\ind, 10,
	\sus, 0,
	\dec, 0.5*l.beatDur,
	\pan, 0,
	\out, ~combB,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)


(
Pbindef(\s2,
	\instrument, \teng,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0, 7], 2),
		// Pseq([-1, 0], 2),
	], inf),
	\dur, Pseq([2, 0.5, 0.25, 0.5, 0.25, 0.25, 0.25], inf),
	\att, 0.001,
	\ind, 20,
	\sus, 0,
	\dec, Pkey(\dur)/4,
	\pan, 0,
	\out, 0,
	\amp, 0.2
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);

)

Pbindef(\s1).stop;
Pbindef(\s2).stop;
Pbindef(\s3).stop;


Pbindef(\s1).stop.quant_(4, 0).play(l);
Pbindef(\s2).stop.quant_(4, 0).play(l);
Pbindef(\s3).stop.quant_(4, 0).play(l);

(
Pbindef(\s3,
	\instrument, \flanger,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0,3,0,-2], 1),
	], inf),
	\dur, Pseq([1], inf),
	\att, 0.001,
	\sus, 0,
	\dec, Pkey(\dur)/2,
	\pan, 0,
	\out, ~combB,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)


(

~combS.free;
SynthDef(\comb,{
	|in|
	var sig = In.ar(~combB.index, 2);
	sig = (sig[0] + sig[1])/2;
	sig = CombC.ar(sig, 1, 0.75/l.beatDur, 8*l.beatDur);
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






