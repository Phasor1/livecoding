StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 9;

(
Pbindef(\s1,
	\instrument, \distortion,
	\octave, Prand([3], inf),
	\distortion, 0.47,
	\scale, Pfunc({~scale}),
	\ind, 15,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,2,4]], 1),
		Pseq([[-2,0,2]], 1),
		Pseq([[3, 5, 7]], 1),
	], inf),
	\dur, Pseq([4], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0.8
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)



(
Pbindef(\s2,
	\instrument, \glitch,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\ind, 15,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0, 2, 6, 8, 7], 4),
	], inf),
	\dur, Pseq([0.5], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0.4
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)
s.plotTree

(
// GLITCH
SynthDef(\glitch, {
	|freq, amp, out, pan=0|
	var sig = VarSaw.ar(freq);
	sig = sig * EnvGen.ar(Env.perc(0, 0.05)) * amp;
	sig = sig + CombL.ar(sig, 1, l.beatDur*0.25, 1);
	sig = FreeVerb.ar(sig, 0.3, 1, 4);
	sig = sig * EnvGen.ar(Env.linen(0, 4, 0.1), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

s.plotTree

(// GLITCH
SynthDef(\glitch, {
	|freq, amp, out, pan=0|
	var sig = VarSaw.ar(freq);
	sig = sig * EnvGen.ar(Env.perc(0, 0.05), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;)

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		Pseq([1], 4),
		// Pseq([0.25], 16),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0.8,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)



(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Clap04]], inf),
	\dur, Pseq([
		Pseq([2], 4),
		// Pseq([0.25], 16),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0.8,
);
Pbindef(\sn).stop.quant_([4, 1]).play();
)

(
Pbindef(\hi,
	\instrument, \sample,
	\buf, Pseq([d[\Closedhat14]], inf),
	\dur, Pseq([
		Pseq([0.25], 4),
		// Pseq([0.25], 16),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0.3,
);
Pbindef(\hi).stop.quant_([4, 0]).play();
)