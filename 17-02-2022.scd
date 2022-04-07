StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 4;


(
Pbindef(\sn,
	\instrument, \sampleFil,
	\buf, Pseq([d[\Clap04], d[\Clap05], d[\Clap03]], inf),
	\dur, Pseq([
		Pseq([ 1.25, 0.75, 2], 4),
	], inf),
	\rate, 1,
	\mix, 0,
	\delay, 0.75,
	\room, 100,
	\mix, 0,
	\pan, Pseq([-1, 1, 0],inf),
	\amp, 0
);
Pbindef(\sn).stop.quant_([4, 1]).play();
)
(
Pbindef(\sn2,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		Pseq([1], 4),
	], inf),
	\rate, 1,
	\delay, 0.25,
	\mix, 0,
	\room, 100,
	// \room, 100,
	// \mix, 0.5,
	\pan, 0,
	\amp, 0
);
Pbindef(\sn2).stop.quant_([4, 0]).play();
)

(
SynthDef(\sampleFil, {
	|
	amp,
	buf,
	out,
	rate=1,
	pan=0,
	mix=0,
	del=1,
	delay=0.75
	|
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	sig = FreeVerb.ar(sig, mix, 10, 20);
	sig = sig + CombC.ar(sig, 1, l.beatDur*delay, 4);
	sig = sig * EnvGen.ar(Env.linen(0.001, 4, 0.001), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
Pbindef(\s2,
	\instrument, \varsAmbient,
	\octave, Prand([4], inf),
	\scale, Pfunc({~scale}),
	\distortion, 0.5,
	\root, Pfunc({~root}),
	\degree, Pseq([
		// Pseq([[0,3,7], [0,4,7]+5, [2, 4, 9], [4,8,11]], 1),
		Pseq([[0,4,7]], 16),
		Pseq([[0,4]]+5, 12),
		Pseq([[0,4]]+6, 2),
		Pseq([[0,4]]+4, 2),
		Pseq([[0,4]]+2, 16),
		Pseq([[0,4]]+4, 12),
		Pseq([[0,4]]+5, 2),
		Pseq([[0,4]]+4, 2),
		// Pseq([[0,3,7], [0,4,7]-2, [2, 4, 9], [0,4,7]+5], 1),
	], inf),
	\dur, Pseq([0.25], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\s4,
	\instrument, \fmEnv,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	\distortion, 0.4,
	\ind, 10,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0], 1),
		// Pseq([[0,3,7], [0,4,7]-2, [2, 4, 9], [0,4,7]+5], 1),
	], inf),
	\dur, Pseq([0.75], inf),
	\att, Pkey(\dur),
	\sus, 0,
	\dec, 0.01,
	\pan, 0,
	\amp, 0.5
	);
Pbindef(\s4).stop.quant_([4, 0]).play(l);
)





(
Pbindef(\s3,
	\instrument, \teng,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	\distortion, 0.4,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([7,0,7,0,7,0,7,0], 1),
		Pseq([0,1,2,3,4,5,6,7], 1),
		Pseq([8,0,8,0,8,0,8,0], 1),
		Pseq([0,1,2,3,4,5,6,7], 1)
	], inf)+2,
	\dur, Pseq([0.25], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)
