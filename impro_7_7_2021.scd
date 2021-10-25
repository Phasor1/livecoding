~scale = Scale.major;
Scale.names;
~root = 10;


(
Pbindef(\k,
	\instrument, \sample2,
	\buf, Pseq([d[\exhale_woman], d[\inhale_woman]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([1], 16),
		Pseq([2], 4),
		// Pseq([0.75], 16),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
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

(
(
Pbindef(\kl,
	\instrument, \sample,
	\buf, Pseq([d[\Clap02]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([1], 16),
		Pseq([2], 16),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\kl).stop.quant_([4, 1]).play();
)

)

(

SynthDef(\sample, {
	|
	amp,
	buf,
	out,
	rate=1,
	pan=0
	|
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	sig = sig + CombC.ar(sig, 1, l.beatDur/8, l.beatDur*8);
	sig = BLowPass4.ar(sig, XLine.ar(20000, 100, l.beatDur*4));
	sig = sig * EnvGen.ar(Env.linen(0.001, 8, 0.001), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur)));
}).add;
)


(
Pbindef(\s1,
	\instrument, \flanger,
	\octave, Prand([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0, 4, 7], [-1, 3, 6], [-2, 2, 5], [-1, 3, 6]], 1).stutter(2),
		// Pseq([[2, 6, 9], [5, 9, 12], [0, 4, 7], [4, 8,11]], 1).stutter(2),
		// Pseq([[0, 4, 7], [1, 4, 8], [3, 6, 8], [1, 4, 8]], 1).stutter(1),
/*		Pseq([0, 0, 4,3,2,1], 2),
		Pseq([-1, -1, 4,3,2,1], 1),
		Pseq([6, 6, 4,3,2,1], 1),*/
		Pseq([0, -1], 8),
		Pseq([1, 2], 8),
		// Pseq([0, -1], 8),

	], inf)+4,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		// Pseq([1,1,0.5,0.5,0.5,0.5], 4),
		Pseq([0.5].stutter(16), 1),
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
Pbindef(\s2,
	\instrument, \fmEnv,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	\ind, 8,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0,6,5, 0], 2),
		Pseq([1,6,5, 1], 1),
		Pseq([2,6,5, 2], 1),

	], inf).stutter(2),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([1], 1)
	], inf),
	\att, 0.005,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
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

SynthDef(\varsLfo, {
	|amp=0.5, freq=200, att=0.01, sus=0.5, dec=1, lfoF=0.5 ind, out, pan=0|
	var first = BLowPass.ar(
		VarSaw.ar(freq, width:0), freq*2
	),
	second = BLowPass.ar(
		VarSaw.ar(
			(freq*2)+SinOsc.ar(lfoF, 0,(1/24)*freq), width:0

	), (freq*4))*0.2,
	sig = (first+second) * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur*2)));
}).add;

)