StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 4;


(
Pbindef(\sn,
	\instrument, \sampleFil,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		Pseq([3, 3, 0.75, 0.25, 1], 4),
	], inf),
	\rate, 0.5,
	\room, 100,
	\mix, 0.5,
	\pan, 1,
	\amp, 0
);
Pbindef(\sn).stop.quant_([4, 0]).play();
)

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		Pseq([0.75], 4),
	], inf),
	\rate, 1,
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Clap02]], inf),
	\dur, Pseq([
		Pseq([2], 4),
	], inf),
	\rate, 1,
	\pan, 0,
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 1]).play();
)



(
Pbindef(\s1,
	\instrument, \teng,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\ind, 15,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[2,6, 9]], 2),
		Pseq([[1.1,4,8]], 2),
	], inf)-2,
	\dur, Pseq([0.75], inf),
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
	\instrument, \distortionPulse,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	\ind, 15,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,7]], 2),
		Pseq([[0.1,7.1]], 1),
		Pseq([[-1,6.1]], 1),
/*		Pseq([[3,6]], 2)-7,
		Pseq([[2,8]], 2)-7,
		Pseq([[1,4]], 2)-7,*/
	], inf),
	\cut, 6,
	\dur, Pseq([8], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
SynthDef(\distortionPulse, {
	|amp=0.5, att=0.01, sus=0, dec=1, freq=440, pan=0, lfo=1, out, cut=7|
	var sig = Pulse.ar(freq) + SinOscFB.ar(freq/2, 70),
	nArms = 5,
	det = 0;
	nArms.do{
		|i|
		sig = sig + SinOsc.ar(freq*(i+1)+det) * nArms/(i+1);
		sig = sig + SinOsc.ar(freq/(i+1)-det) * nArms/(i+1);
	};
	// sig = (sig * 30).clip(-1, 1);
	sig = sig.clip(-1, 1);
	sig = BLowPass4.ar(sig, freq*cut);
	sig = FreeVerb.ar(sig, 0.3, 50, 5);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2)*amp;
	Out.ar(out, Pan2.ar(sig, pan))
}).add;

)


