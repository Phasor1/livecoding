StageLimiter.activate;

~scale = Scale.major;
Scale.names;
~root = 0;
s.latency = 0.16;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\kick_zarro]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([1], 1),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);

Pbindef(\k).stop.quant_([4, 1]).play();
)

(
Pbindef(\sa,
	\instrument, \sample,
	\buf, Pseq([d[\inhale_woman], d[\exhale_woman]], inf),
	\dur, Pseq([
		Pseq([2], 16),
	], inf),
	\rate, Pseq([1], inf),
	\mix, 0.7,
	\pan, 0,
	\amp, 0,
);
Pbindef(\sa).stop.quant_([4, 0]).play();
)


(
Pbindef(\s1,
	\instrument, \teng,
	\octave, Pseq([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([-1], 4),
		Pseq([0], 4),
		Pseq([4], 4),
		// Pseq([0, 7], 1)+3,
		// Pseq([0, 7], 1)+4,
	], inf),
	\dur, Pseq([
		Pseq([0.75], 1)
	], inf),
	\att, 0,
	\ind, 10,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)


(
SynthDef(\sin, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0|
	var sig = SinOsc.ar(freq);
	sig = sig + BLowPass4.ar(VarSaw.ar(freq), 10000);
	sig = sig + Pan2.ar(CombC.ar(sig, 1, 0.25*l.beatDur, l.beatDur), SinOsc.ar(4));
	sig = sig * EnvGen.ar(Env.linen(0, 2, 0), doneAction: 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec)) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

Pbindef(\s1).stop

(
Pbindef(\s2,
	\instrument, \varsAmbient,
	\octave, Pseq([5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0,4,7], [-1, 3, 6], [-3, -1, 4], [-1, -3, 6]], 1).stutter(1),
		Pseq([[0,4,7], [0,4,7]+4], 1).stutter(1),
		// Pseq([[0,4,7], [0,3,7], [-1, 3, 6], [4, 8, 11]], 1).stutter(1),
	], inf),
	\dur, Pseq([
		Pseq([0.25], 1)
	], inf),
	\att, Pkey(\dur),
	\sus, 0,
	\dec, 0.02,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
SynthDef(\teng, {
	|amp=0.5, att=0.01, sus=0, dec=1, freq=440, pan=0, lfo=1, amount=8, out|
	var sig = VarSaw.ar(freq),
	env = XLine.ar(12000, freq*2, 0.2);
	sig = BLowPass4.ar(sig, env);
	sig = sig + CombC.ar(sig, 1, 0.25*l.beatDur, 8);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2)*amp;
	Out.ar(out, Pan2.ar(sig, pan))
}).add;
)

(
SynthDef(\teng, {
	|amp=0.5, att=0.01, sus=0, dec=1, freq=440, pan=0, lfo=1, amount=8, out|
	var sig = VarSaw.ar(freq),
	env = XLine.ar(12000, freq*2, 0.2);
	sig = BLowPass4.ar(sig, env);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2)*amp;
	Out.ar(out, Pan2.ar(sig, pan))
}).add;
)




Pbindef(\s1).stop;
Pbindef(\s2).stop;



Pbindef(\s1).stop.quant_([4, 0]).play(l);
Pbindef(\s2).stop.quant_([4, 0]).play(l);


(
Pbindef(\s3,
	\instrument, \armoNoiz,
	\octave, Pseq([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0,4,7], [-1, 3, 6], [-3, -1, 4], [-1, -3, 6]], 1).stutter(1),
		Pseq([0,5,2, 7], 1).stutter(1),
	], inf),
	\dur, Pseq([
		Pseq([4], 1)
	], inf),
	\att, Pkey(\dur)*2,
	\sus, 0,
	\dec, 0.01,
	\pan, Pwhite(-1, 1),
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)




(
Pbindef(\s4,
	\instrument, \teng,
	\octave, Pseq([2], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0,4,7], [-1, 3, 6], [-3, -1, 4], [-1, -3, 6]], 1).stutter(1),
		Pseq([0,], 1).stutter(1),
	], inf),
	\dur, Pseq([
		Pseq([8], 1)
	], inf),
	\att, Pkey(\dur),
	\sus, 0,
	\dec, 0.01,
	\pan, 0,
	\ind, 5,
	\amp, 0
	);
Pbindef(\s4).stop.quant_([4, 0]).play(l);
)


