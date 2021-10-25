StageLimiter.activate;

~scale = Scale.major;
Scale.names;
~root = 3;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick10]], inf),
	\dur, Pseq([
		Pseq([4], 16),
		// Pseq([0.5], 16),
		// Pseq([0.25], 32),
		// Pseq([0.125], 32),
		// Pseq([
			// Pseq([0.125], 3),
			// Pseq([0.25], 1),
		// ], 12)
		// Pseq([0.5], 8),
		// Pseq([0.25], 16),
		// Pseq([0.125], 8),
		// Pseq([1], 1),
		// Pseq([0.125], 8),
		// Pseq([1], 1),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([4], 3),
		// Pseq([0.75], 16),
		// Pseq([0.5, 0.5], 1),
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp,0,
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
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	sig = sig + CombC.ar(sig, 0.5, 0.25, 4);
	sig = sig * EnvGen.ar(Env.linen(0, 4, 0), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
Pbindef(\s,
	\instrument, \sample,
	\buf, Pseq([d[\Snare01]], inf),
	\dur, Pseq([
		Pseq([2], 4),
		Pseq([2], 4),
		// Pseq([1], 4),
		// Pseq([4], 1),
		// Pseq([0.5, 0.5], 1)
		// Pseq([0.125], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4),
		// Pseq([0.25], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([0.8], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\s).stop.quant_([4, 1]).play();
)

(
Pbindef(\s2,
	\instrument, \varsLfo,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 2,
	\lfo, 2,
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([0, 1,4, -1,-1,-1, 5, 1], 3),
		Pseq([[0, 4, 7], [4,9, 12], [5,11, 14]], 2),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		// Pseq([2, 1, 0.5, 0.5, 0.5, 1.5, 2], 3),
		Pseq([4, 8].stutter(1), 2)*2
		// Pseq([0.75].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\s3,
	\instrument, \varsLfo,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 2,
	\lfo, 2,
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([0, 1,4, -1,-1,-1, 5, 1], 3),
		Pseq([[0, 4, 7], [4,9, 12], [5,11, 14]], 2),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		// Pseq([2, 1, 0.5, 0.5, 0.5, 1.5, 2], 3),
		Pseq([4, 8].stutter(1), 2)*2
		// Pseq([0.75].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0.4
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\s1,
	\instrument, \armoNoiz,
	\octave, Pseq([8], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 50,
	\root, Pfunc({~root}),
	\degree, Prand([
		Pseq([0], 1).stutter(1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], inf),
		// Pseq([1].stutter(1), ),
		// Pseq([0.25].stutter(8), 2)
		// Pseq([0.75], 6)
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
Pbindef(\s3,
	\instrument, \sin,
	\octave, Pseq([8], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 10,
	// \lfoF, 0.1,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0,7,6,5,4,3,4,0], 3).stutter(1),
		// Pseq([6,7,6,7,6,7,6,7], 2).stutter(1),
		// Pseq([[0,4,8]], 1)
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], inf),
		// Pseq([1].stutter(1), ),
		// Pseq([0.25].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)/2,
	\pan, Pseq([-1, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1], inf),
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)

(
SynthDef(\fmEnv, {
	|att=0, sus=0, dec=1, amp=0.1, freq=200, carFR=1, modFR=1, modA=0, ind=0, out, pan=0|
	var	indexEnv = Line.ar(0, ind, att + sus + dec),
	modSin = SinOsc.ar(freq * modFR, mul:freq * modFR * indexEnv),
	carrSin = SinOsc.ar((freq * carFR) + modSin);
	carrSin = BLowPass4.ar(carrSin, MouseX.kr(300, 20000), 5);
	carrSin = carrSin * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(carrSin, pan));
}).add;
)

(
Pbindef(\s6,
	\instrument, \bouncing,
	\octave, Pseq([5], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 50,
	\lfoF, 0.1,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[4, 11],[5, 12],[4,11], [6,13]], 1).stutter(1),
		Pseq([[4, 11],[5, 12],[2,9], [0, 7]], 1).stutter(1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], inf),
		// Pseq([1].stutter(1), ),
		// Pseq([0.25].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s6).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\s5,
	\instrument, \fmBass,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 6,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0,0,5,4,3,2], 2).stutter(1),
		Pseq([0,0,6,7,6,7], 2).stutter(1),
		Pseq([
			Pseq([0,1,2,3,4,3], 1).stutter(1),
			Pseq([2,3,4,5,6,7], 1).stutter(1),
		], 2)
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([1, 1, 0.5, 0.5, 0.5, 0.5], 4),
		Pseq([0.5].stutter(6), 4),
		// Pseq([1].stutter(1), ),
		// Pseq([0.25].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s5).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\s4,
	\instrument, \fmBass,
	\octave, Prand([2], inf),
	\scale, Pfunc({~scale}),
	// \dist,
	\ind, 20,
	\root, Pfunc({~root}),
	\degree, Prand([
		Pseq([[0,2, 4], [4,6,8]], 1).stutter(1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], inf),
		// Pseq([1].stutter(1), ),
		// Pseq([0.25].stutter(8), 2)
		// Pseq([0.75], 6)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s4).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\k).stop;
Pbindef(\s).stop;
Pbindef(\s1).stop;
Pbindef(\s2).stop;
/*Pbindef(\s3).stop;*/
Pbindef(\s4).stop;
// Pbindef(\s5).stop;
)
(
Pbindef(\k).play;
Pbindef(\s).play;
Pbindef(\s1).play;
Pbindef(\s2).play;
Pbindef(\s5).play;
Pbindef(\s3).play;
Pbindef(\s4).play;
)