StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 9;

s.meter
(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\kick_zarro]], inf),
	\dur, Pseq([
		Pseq([1], 4),
		// Pseq([1, 0.75, 1.25, 0.5], 4),
		// Pseq([1, 1, 0.25, 0.75, 1], 4),
	], inf),
	\rate, 1,
	\delay, 0.25,
	\mix, 1,
	\room, 0,
	\damp, 0,
	\mix, 0,
	\pan, 0,
	\amp, 2
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Clap05]], inf),
	\dur, Pseq([
		Pseq([2, 2, 1.25, 0.75], 4),
		// Pseq([1, 0.75, 1.25, 0.5], 4),
	], inf),
	\rate, 1,
	\delay, 0.25,
	\mix, 0,
	\room, 0,
	\damp, 40,
	\mix, 0.3,
	\pan, 0,
	\amp, 0
);
Pbindef(\sn).stop.quant_([4, 1]).play();
)

SynthDef(\sampleFil, {
	|
	amp,
	buf,
	out,
	rate=1,
	pan=0,
	mix=0,
	del=1
	|
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	sig = FreeVerb.ar(sig, mix, 10, 20);
	sig = sig + CombC.ar(sig, 1, 0.5, 4);
	sig = sig * EnvGen.ar(Env.linen(0.001, 4, 0.001), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

(
Pbindef(\h,
	\instrument, \sample,
	\buf, Pseq([d[\Closedhat12]], inf),
	\dur, Pseq([
		Pseq([0.25], 4),
		// Pseq([1, 0.75, 1.25, 0.5], 4),
	], inf),
	\rate, 1,
	\delay, 0.25,
	\mix, 0,
	\room, 0,
	\damp, 40,
	\mix, 0,
	\pan, 0,
	\amp, 0.3
);
Pbindef(\h).stop.quant_([4, 0]).play();
)




(
Pbindef(\s1,
	\instrument, \varsAmbient,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	\distortion, 0.4,
	\ind, 10,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,2,4], [-1, 1, 3]], 1),
		// Pseq([[-2,0,2], [-1, 1, 3]], 1),
		// Pseq([[0,3,7], [0,4,7]-2, [2, 4, 9], [0,4,7]+5], 1),
	], inf),
	\dur, Pseq([
		Pseq([4], 1),
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)/2,
	\pan, 0,
	\amp, 0.2
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

Pbindef(\s1, \amp, 0);
Pbindef(\s2, \amp, 0);
Pbindef(\k, \amp, 0);
Pbindef(\s3,\amp, 0);

Pbindef(\k, \amp, 1);
Pbindef(\s1, \instrument, \distortion, \distortion, 0.47, \octave, 5, \amp, 1).stop.quant_([4, 0]).play(l);

Pbindef(\s1).stop;
Pbindef(\k).stop;

(
Pbindef(\s2,
	\instrument, \teng,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\distortion, 0.4,
	\ind, 10,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0, 0,0, -1,0], 1),
		Pseq([0, 0,0, 2,0], 1),
				Pseq([7, 7,7,6,7], 1),
				Pseq([7, 7,7,6,7], 1)
		// Pseq([[0,3,7], [0,4,7]-2, [2, 4, 9], [0,4,7]+5], 1),
	], inf),
	\dur, Pseq([
		Pseq([1, 1, 0.25, 0.75, 1], 4),
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)/2,
	\pan, 0,
	\amp, 0.1
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s3,
	\instrument, \distortion,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\distortion, 0.47,
	\ind, 10,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Prand([7,0])
		// Pseq([[0,3,7], [0,4,7]-2, [2, 4, 9], [0,4,7]+5], 1),
	], inf),
	\dur, Pseq([
		Pseq([0.25], 4),
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)/2,
	\pan, Pwhite(-1, 1),
	\amp, 0.8
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)


(
SynthDef(\varsAmbient, {
	|amp=0.5, freq=200, att=0.01, sus=0.5, dec=1, lfoF=0.5 ind, out, pan=0|
	var first = BLowPass.ar(
		VarSaw.ar(freq, width:0), freq*2
	),
	second = BLowPass.ar(
		VarSaw.ar(
			(freq*2), width:0

	), (freq*4))*0.2,
	sig = (first+second);
	sig = FreeVerb.ar(sig, 0, 100, 10);
	sig = sig * EnvGen.ar(Env.linen(0, 10, 0.1), doneAction: 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec)) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

)