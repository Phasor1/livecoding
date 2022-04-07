StageLimiter.activate;

~scale = Scale.major;
Scale.names;
~root = 8;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		Pseq([4], 4),
		// Pseq([0.25], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0.5,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\s1,
	\instrument, \ambient,
	\octave, Pseq([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.7,
	\ind, 10,
	\degree, Pseq([
		// Pseq([0,-3, -2], 1),
		// Pseq([0, 2, -2], 1)
		Pseq([[0, 2, 4]-2], 1)
	], inf).stutter(1),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		// Pseq([0.75]*2, 4),
		Pseq([8], 16),
	], 1),
	// \mtranspose, -2,
	\att, 1,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur*1.5,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
SynthDef(\sample, {
	|
	amp,
	buf,
	out,
	rate=1,
	pan=0,
	mix=0
	|
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	sig = sig+CombL.ar(sig, 4*l.beatDur, 0.75*l.beatDur, l.beatDur*16);
	sig = sig+CombC.ar(sig, 0.001, 0.001, 0.001);
	sig = sig*EnvGen.ar(Env.linen(0.01, 16*l.beatDur, 0.01), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, 0));
}).add;
)
