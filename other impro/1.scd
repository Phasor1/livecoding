StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 0;
s.latency = 0.01
(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		// Pseq([2], 4),
		Pseq([4], 8),
		// Pseq([0.25], 8),
		// Pseq([0.75], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\s1,
	\instrument, \sin,
	\distortion, 0.6,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,2,4, 6], [3, 5, 7, 9]], 1),
		// Pseq([[0, 4, 7], [6, 10, 13], [5, 9, 12], [0,4,7]], 2),
		// Pseq([[0, 4, 7]+1, [6, 10, 13], [5, 9, 12], [0,4,7]+1], 1),
		// Pseq([[0, 4, 7]+2, [6, 10, 13], [5, 9, 12], [0,4,7]+2], 1),
	], inf).stutter(1)+2,
	\ind, 30,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		// Pseq([1,1,0.5,0.5,0.5,0.5], 4),
		Pseq([8], 1)*l.beatDur,
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, Pwhite(-1, 1),
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
(
Pbindef(\s2,
	\instrument, \bouncing,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([6,5], 2),
		Pseq([8,7], 2),
		Pseq([14, 13], 1)
		// Pseq([[2, 6, 7]], 1)

	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([2], 1)
	], inf),
	\att, 0.001,
	\ind, 6,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)
)

(
SynthDef(\sin, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0|
	var sig = SinOsc.ar(freq);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur*10)));
}).add;
)

(
Pbindef(\sa,
	\instrument, \sample,
	\buf, Pseq([d[\inhale_woman], d[\exhale_woman]], inf),
	\dur, Pseq([
		Pseq([2], 16),
	], inf),
	\rate, Pseq([1.2], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\sa).stop.quant_([4, 0]).play();
)

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick02]], inf),
	\dur, Pseq([
		Pseq([2], 16),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 20,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)


(
Pbindef(\snare,
	\instrument, \sample,
	\buf, Pseq([d[\Snare08]], inf),
	\dur, Pseq([
		Pseq([0.5, 0.5, 1, 1, 1], 16),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\snare).stop.quant_([4, 0]).play();
)



(
SynthDef(\vars, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0|
	var sig = VarSaw.ar(freq, width: 0.5);
	sig = sig + Pan2.ar(sig + CombC.ar(sig, 8, l.beatDur/16, l.beatDur*4), SinOsc.ar(l.beatDur*4));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec)) * amp;
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec*l.beatDur*16), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur*16)/2));
}).add;
)





(
SynthDef(\sample2, {
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
)

s.plotTree