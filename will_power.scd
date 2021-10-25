StageLimiter.activate;

~scale = Scale.major;
Scale.names;
~root = 0;
s.latency = 0;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([1], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\cl,
	\instrument, \sample,
	\buf, Pseq([d[\Clap04]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		Pseq([0.25], 1),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\cl).stop.quant_([4, 0]).play();
)

(
(
Pbindef(\s1,
	\instrument, \varsLfo,
	\distortion, 0.5,
	\octave, Prand([4], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0, 2, 4], [3,5,7]], 1).stutter(1),
		Pseq([[0, 2, 4], [3,5,7], [4,6,8]], 1).stutter(1),
		Pseq([[-2,0,2]+7, [3,5,7], [4,6,8]], 1).stutter(1),
	], inf),
	\dur, Pseq([
		Pseq([8, 2, 2], 1),
		Pseq([8, 2, 2], 1),
		// Pseq([8, 8], 1)
	], inf),
	\att, 0.01,
	\ind, 10,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)
)

(
Pbindef(\s2,
	\instrument, \bouncing,
	\distortion, 0.5,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Prand([0,2,0,3,5,3, -2, -2], 1)
	], inf).stutter(2),
	\dur, Pseq([
		4
	], inf),
	\att, 0.01,
	\ind, 10,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

(
SynthDef(\distortion, {
	|amp=0.5,dur, freq, att=0.01, sus=0.5, dec=1, out, distortion=0.4, pan=0|
	var mod = VarSaw.ar(freq/2, 0, 0.5-distortion, 50)*1,
	// (Lag2UD.ar(Dust.ar(30), 0, dur/4) + 0.5),
	sig = VarSaw.ar(freq, width:0.2+distortion,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec*4), doneAction: 2) * amp * 0.01;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)











