StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = 0;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		Pseq([4], 4),
		// Pseq([0.25], 4),
	], inf),
	\rate, Pseq([1], inf),
	\del, l.beatDur,
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\sn,
	\instrument, \sample2,
	\buf, Pseq([d[\Clap06]], inf),
	\dur, Pseq([
		Pseq([0.25], 4),
		// Pseq([0.25], 4),
	], inf),
	\rate, Pseq([1], inf),
	\del, l.beatDur,
	\pan, Pwhite(-1, 1),
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 0]).play();
)

(
SynthDef(\sample2, {
	|
	amp,
	buf,
	out,
	rate=1,
	pan=0,
	mix=0
	|
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	sig = sig + CombC.ar(sig, l.beatDur, l.beatDur/4, l.beatDur*4);
	sig = sig * EnvGen.ar(Env.linen(0.01, l.beatDur*8, 0.01), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur*8)));
}).add;
)

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		Pseq([1], 4),
		// Pseq([0.25], 4),
	], inf),
	\rate, Pseq([1], inf),
	\del, l.beatDur,
	\pan, 0,
	\amp, 1,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\s1,
	\instrument, \varsAmbient,
	\dist, 0.8,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[-2, 2, 5],[0, 4, 7]], 2),
		// Pseq([[-2, 2, 5],[0, 4, 7]], 2)+4,
	], inf).stutter(1),
	\ind, 10,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		// Pseq([1,1,0.5,0.5,0.5,0.5], 4),
		Pseq([4], 1),
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
	\instrument, \distortionPulse,
	\dist, 0.8,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Prand([-2, 2, 5], 3),
		Prand([0,4,7], 3),
	], inf).stutter(1)+4,
	\ind, 10,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		// Pseq([1,1,0.5,0.5,0.5,0.5], 4),
		Pseq([0.25], 1),
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
SynthDef(\flanger, {
	|freq, amp, dec=2, out, att=0.01, sus=0, lfoF=0.2, cf, dur=1, pan=0|
	var sig = VarSaw.ar(freq, width: 0.8),
	lfo = VarSaw.ar(lfoF, 0,0, 0.003, 0.003),
	// lfo = SinOsc.ar(lfoF, 0, 0.005, 0.005),
	sig2 = VarSaw.ar(freq * 2);
	sig = sig + sig2;
	sig = sig + AllpassL.ar(sig, 10, lfo, 0);
	sig = sig + CombC.ar(sig, 1*l.beatDur, l.beatDur/2, l.beatDur*4);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec)) * amp;
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec+10), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur/2)));
}).add;
)