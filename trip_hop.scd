StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 2;
{SinOsc.ar(220)!2}.play;
(
Pbindef(\s1,
	\instrument, \varsLfo,
	\dist, 0.8,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([0, 6, 5, 0], 2),
		// Pseq([1, 6, 5, 1], 1),
		// Pseq([2, 6, 5, 2], 1),
		Pseq([[0, 4, 7], [6, 10, 13], [5, 9, 12], [0,4,7]], 2),
		Pseq([[0, 4, 7]+1, [6, 10, 13], [5, 9, 12], [0,4,7]+1], 1),
		Pseq([[0, 4, 7]+2, [6, 10, 13], [5, 9, 12], [0,4,7]+2], 1),
	], inf).stutter(2),
	\ind, 10,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		// Pseq([1,1,0.5,0.5,0.5,0.5], 4),
		Pseq([1], 1),
	], inf),
	\att, 0.01,
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
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur*32)));
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
	\buf, Pseq([d[\Kick06]], inf),
	\dur, Pseq([
		Pseq([1], 4),
		// Pseq([0.25], 16),
	], inf),
	\rate, Pseq([1.3], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)
s.latency = 0.2

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
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur*32)));
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