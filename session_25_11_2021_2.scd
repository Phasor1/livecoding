StageLimiter.activate;

~scale = Scale.major;
Scale.names;
~root = 0;


(
Pbindef(\sn,
	\instrument, \sampleFil,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		Pseq([0.75], 4),
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
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		Pseq([1], 4),
	], inf),
	\rate, 1,
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
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
	del=1
	|
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	var duration = 16*l.beatDur;
	sig = FreeVerb.ar(sig, mix, 20, 20);
	sig = sig + CombC.ar(sig, duration, l.beatDur*0.75*2, duration);
	sig = BLowPass4.ar(sig, XLine.ar(18000, 200, duration));
	sig = FreeVerb.ar(sig, 0.3, 40, 10);
	sig = sig * EnvGen.ar(Env.linen(0.001, duration, 0.001), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur)));
}).add;
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
	del=1
	|
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	sig = FreeVerb.ar(sig, mix, 100, 20);
	sig = sig * EnvGen.ar(Env.linen(0.001, 4, 0.001), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Snare15]], inf),
	\dur, Pseq([
		Pseq([2], 4),
	], inf),
	\rate, Pseq([1], inf),
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
		Pseq([0, 1, 2, 1, 0, 8, 6, 7], 1),
		Pseq([0, 1, 2, 1, 0, 8, 6, 7]+5, 1),
	], inf),
	\dur, Pseq([1], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
SynthDef(\distortionPulse, {
	|amp=0.5, att=0.01, sus=0, dec=1, freq=440, pan=0, lfo=1, out|
	var sig = Pulse.ar(freq) + SinOscFB.ar(freq/2, 70),
	nArms = 5,
	det = 0;
	freq = MouseX.kr(freq, freq*4);
	nArms.do{
		|i|
		sig = sig + SinOsc.ar(freq*(i+1)+det) * nArms/(i+1);
		sig = sig + SinOsc.ar(freq/(i+1)-det) * nArms/(i+1);
	};
	// sig = (sig * 30).clip(-1, 1);
	sig = sig.clip(-1, 1);
	sig = BLowPass4.ar(sig, freq*7);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2)*amp;
	Out.ar(out, Pan2.ar(sig, pan))
}).add;
)

(
SynthDef(\distortionPulse, {
	|amp=0.5, att=0.01, sus=0, dec=1, freq=440, pan=0, lfo=1, out|
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
	sig = BLowPass4.ar(sig, freq*7);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2)*amp;
	Out.ar(out, Pan2.ar(sig, pan))
}).add;
)

(
Pbindef(\s2,
	\instrument, \armoNoiz,
	\octave, Prand([8], inf),
	\scale, Pfunc({~scale}),
	\distortion, 0.4,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Prand([0,7], 1)
	], inf),
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
Pbindef(\s3,
	\instrument, \varsLfo,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\distortion, 0.4,
	\root, Pfunc({~root}),
	\degree, Pseq([
		Prand([[0, 4, 7], [-2, 2, 5]], 1)+2
	], inf),
	\dur, Pseq([4], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)
