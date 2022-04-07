StageLimiter.activate;

~scale = Scale.minor;
Scale.names;
~root = -1;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		Pseq([0.5], 4),
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
	\instrument, \sample,
	\buf, Pseq([d[\Clap06]], inf),
	\dur, Pseq([
		Pseq([0.125], 3),
		// Pseq([0.75, 0.25], 1),
		// Pseq([0.25], 4),
	], inf),
	\rate, Pseq([1], inf),
	\del, l.beatDur,
	\pan, 0,
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 0.5]).play();
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
	sig = FreeVerb.ar(sig, mix, 10, 20);
	sig = sig + AllpassL.ar(sig, 10, SinOsc.ar(l.beatDur)*0.003 + 0.003, 0);
	sig = sig * EnvGen.ar(Env.linen(0.01, 4, 0.01), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
Pbindef(\s1,
	\instrument, \varsAmbient,
	\octave, Pseq([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.4,
	\ind, 10,
	\degree, Pseq([
		// Pseq([0,-3, -2], 1),
		// Pseq([0, 2, -2], 1)
		Pseq([[0, 2, 4],[ -3, -1, 1], [-2, 0, 2]], 1),
		Pseq([[0, 2, 4], [2, 4, 6], [-2, 0, 2]], 1)
	], inf).stutter(1),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		// Pseq([0.75]*2, 4),
		Pseq([2,2,8], 16),
	], inf),
	// \mtranspose, -2,
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur*1.5,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

[0, 4, 7],[2, 6, 9], [4, 8,11], [5, 9, 12]

(
SynthDef(\armoNoiz, {
	|freq, amp, dec, out, att, pan=0|
	var sig = BBandPass.ar(WhiteNoise.ar(1), XLine.ar(freq *4, freq, dec), 0.1);
	sig = sig * EnvGen.ar(Env.perc(att, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur*32)));
}).add;
)

(

(
Pbindef(\s2,
	\instrument, \armoNoiz,
	\octave, Pseq([7], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.8,
	\degree, Pseq([
		Pseq([0,1,2], 1)
	], inf)+4,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([0.125], 1)
	], inf),
	// \mtranspose, -2,
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, Pwhite(-1, 1),
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)
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
	sig = sig + CombC.ar(sig, l.beatDur*4, l.beatDur/3, l.beatDur*4);
	sig = sig * EnvGen.ar(Env.linen(att, sus*4, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
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
	mix=0
	|
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	sig = FreeVerb.ar(sig, mix, 10, 20);
	sig = sig * EnvGen.ar(Env.linen(0.001, 4, 0.001), doneAction: 2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)