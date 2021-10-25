~scale = Scale.major;
Scale.names;
~root = 0;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick01]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([8], 3),
		// Pseq([0.25], 4),
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
Pbindef(\s,
	\instrument, \sample,
	\buf, Pseq([d[\Snare13]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([0], 3),
		Pseq([0.25, 0.75, 1], 1),
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
Pbindef(\s).stop.quant_([4, 0.5]).play();
)

(
Pbindef(\k).stop;
Pbindef(\s).stop;
)

(
Pbindef(\k).stop.quant_([4, 0]).play();
Pbindef(\s).stop.quant_([4, 0]).play();
)


(
	Pbindef(\s1,
		\instrument, \sin2,
		\octave,6,
	\ind, 10,
		\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0, 4], [2, 6]], 4).stutter(1),
		Pseq([[0, 4], [2, 6]], 4).stutter(1)-2
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([0.75], inf),
		\att, 0.01,
		\sus, 0,
		\dec, Pkey(\dur)*l.beatDur,
		\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
	Pbindef(\s2,
		\instrument, \flanger,
		\octave,3,
	\ind, 10,
		\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0, 4, 7]], 4).stutter(1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([64], 1),
		\att, 0.01,
		\sus, 0,
		\dec, Pkey(\dur)*l.beatDur*2,
		\amp, 0.2
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
// OSC
SynthDef(\sin2, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0|
	var sig = SinOsc.ar(freq);
	sig = sig + Pan2.ar(CombC.ar(sig, 8, (l.beatDur/2), 8), SinOsc.ar(l.beatDur*4));
	sig = FreeVerb.ar(sig, 0.5, 3, 1);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
SynthDef(\vars2, {
	|freq, amp = 0, sus, dec=0.1, att, out, pan=0, dur|
	var sig = VarSaw.ar(freq, width: 0.5);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec)) * amp;
	sig = sig + Pan2.ar(CombC.ar(sig, 8, (l.beatDur/2), 8), SinOsc.ar(l.beatDur, 2));
	sig = FreeVerb.ar(sig, 0.5, 3, 1);
	sig = sig * EnvGen.ar(Env.linen(0, (dur*8), 0), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)