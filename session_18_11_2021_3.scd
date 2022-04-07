StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 1;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		Pseq([1], 3),
		// Pseq([0.25, 0.75], 1),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\s4,
	\instrument, \varsLfo,
	\octave, 4,
	\scale, Pfunc({~scale}),
	// \dist,
	\ind,6,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,2,4,7]-4], 1),
		Pseq([[0,2,4,7]], 1),
		Pseq([[0,2,4,7]+2], 1),
		Pseq([[0,2,4,7]-1], 1),
	], inf).stutter(1),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], 8),
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\amp, 0,
	);
Pbindef(\s4).stop.quant_([4, 0]).play(l);
)



(
(
Pbindef(\s1,
	\instrument, \sin,
	\octave, 4,
	\scale, Pfunc({~scale}),
	\dist, 0.47,
	\amount, 12,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([
			Pseq([[0,7]], 1),
			Pseq([[0, 7]+7], 3)
		], 4),
		Pseq([
			Pseq([[0,7]], 1),
			Pseq([[0, 7]+7], 3)
		], 4)+1,
		Pseq([
			Pseq([[0,7]], 1),
			Pseq([[0, 7]+7], 3)
		], 4)+2,
		Pseq([
			Pseq([[0,7]], 1),
			Pseq([[0, 7]+7], 3)
		], 4)+3,
		Pseq([
			Pseq([[0,7]], 1),
			Pseq([[0, 7]+7], 3)
		], 16)+7
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([0.25], 8),
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\amp, 0,
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

)

(
Pbindef(\s1,
	\instrument, \flanger,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\dist, 0.47,
	\amount, 12,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([-4, 2, 1, 6], 1),
		Pseq([-4, 2, 1, 7], 1),
		Pseq([-4, 2, 1, 9], 1),
		Pseq([-4, 2, 1, 8], 1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([0.25], 8),
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\amp, 0,
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
SynthDef(\wing, {
	|amp=0.5, att=0.01, sus=0, dec=1, dur, freq=440, pan=0, lfo=1, out|
	var sig = VarSaw.ar(XLine.ar(60, freq, dec/8));
	sig = BLowPass4.ar(sig, XLine.ar(freq, freq*10, dec/8));
	sig = sig + CombL.ar(sig, 1, l.beatDur/4, l.beatDur*4);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec))*amp;
	sig = sig * EnvGen.ar(Env.linen(att, sus*4, dec), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur*8)));
}).add;
)