StageLimiter.activate;

~scale = Scale.harmonicMinor;
Scale.names;
~root = 2;
s.latency = 0.16
(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		Pseq([0.125], 16),
	], inf),
	\mix, 0,
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)
// DA QUI SI PASSA ALLA BALDORIA
(
Pbindef(\s1).stop;
Pbindef(\k, \dur, Pseq([1], inf), \amp, 1);
Pbindef(\hi).stop;
)

(
Pbindef(\hi,
	\instrument, \sample,
	\buf, Pseq([d[\Closedhat14]], inf),
	\dur, Pseq([
		Pseq([0.25], 16),
	], inf),
	\rate, Pseq([1], inf),
	\mix, 0,
	\pan, 0,
	\amp, 0.5,
);
Pbindef(\hi).stop.quant_([4, 0]).play();
)

Pbindef(\boom, \instrument, \fmBass, \freq, 60,\ind, 2, \amp, 1, \dur, Pseq([2], 1), \att, 0.01, \sus, 0, \dec, 4*l.beatDur).stop.quant_([4, 0]).play(l)
40.midicps
(
Pbindef(\s1,
	\instrument, \varsLfo,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.4,
	\degree, Pseq([
		// Pseq([[0, 4, 7]], 1).stutter(2),
		// Pseq([[0, 4, 7], [-1, 3, 6]], 1).stutter(2),
		Pseq([[0, 4, 7], [-2, 2, 5],], 1).stutter(2),
		// Pseq([[2, 6, 9], [5, 9, 12], [0, 4, 7], [4, 8,11]], 1).stutter(2),
		// Pseq([[0, 4, 7], [1, 4, 8], [3, 6, 8], [1, 4, 8]], 1).stutter(1),
		// Pseq([[0, 4, 7]], 1)

	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], 1)
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
	\instrument, \distortion,
	\octave, Pseq([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\distortion, 0.5,
	\degree, Pseq([
		Pseq([[0, 2, 4]-3], 1).stutter(2),
		// Pseq([[0, 4, 7], [-1, 3, 6]], 1).stutter(24),
		// Pseq([[0, 4, 7], [-1, 3, 6], [-2, 2, 5], [-1, 3, 6]], 1).stutter(2),
		// Pseq([[2, 6, 9], [5, 9, 12], [0, 4, 7], [4, 8,11]], 1).stutter(2),
		// Pseq([[0, 4, 7], [1, 4, 8], [3, 6, 8], [1, 4, 8]], 1).stutter(1),
		// Pseq([[0, 4, 7]], 1)

	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([0.25], 1)
	], inf),
	\detune, 0,
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)/4,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)
(
SynthDef(\distortion, {
	|amp=0.5,dur, freq, att=0.01, sus=0.5, dec=1, out, distortion=0.4, pan=0|
	var mod = VarSaw.ar(MouseX.kr(freq/2, freq), 0, 0.5-distortion, 50)*1,
	// (Lag2UD.ar(Dust.ar(30), 0, dur/4) + 0.5),
	sig = VarSaw.ar(freq, width:0.5+distortion,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec*4), doneAction: 2) * amp * 0.01;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)
// QUI SI PASSA DALLA BALDORIA AL TEMA CENTRALE
(
Pbindef(\s1, \amp, 1).stop.quant_([4, 0]).play(l);
Pbindef(\s2).stop;
Pbindef(\k, \dur, Pseq([4], inf), \amp, 1);
Pbindef(\hi).stop;
)

Pbindef(\s1, \amp, 1).stop.quant_([4, 0]).play(l);
(
SynthDef(\distortion, {
	|amp=0.5,dur, freq, att=0.01, sus=0.5, dec=1, out, distortion=0.4, pan=0|
	var mod = VarSaw.ar(freq/2, 0, 0.5-distortion, 50)*1,
	// (Lag2UD.ar(Dust.ar(30), 0, dur/4) + 0.5),
	sig = VarSaw.ar(freq, width:0.5+distortion,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec*4), doneAction: 2) * amp * 0.01;
	Out.ar(out, Pan2.ar(sig, MouseX.kr(-1, 1)));
}).add;
)

(
Pbindef(\s1,
	\instrument, \distortionPulse,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\ind, 3,
	\degree, Pseq([
		// Pseq([[0, 4, 7], [-1, 2, 5]], 1),
		Pseq([0, -1,2,4], 2),
		Pseq([0, -1,2,4], 2)+4,
		Pseq([0, -1,2,4], 4)+7,
		// Pseq([[0, 4, 7], [3, 7, 10]], 1)

	], inf),
	\dur, Pseq([
		Pseq([0.5], 1)
	], inf),
	\freqMod, 5000,
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0.6
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)
(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		// Pseq([1], 4),
		Pseq([1], 8),
		// Pseq([0.25], 8),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 5,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)



(
Pbindef(\s2,
	\instrument, \fmEnv,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\ind, 8,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\degree, Pseq([
		Pseq([0,7], 4),
		Pseq([-1,6], 4),
	], inf).stutter(1),
	\dur, Pseq([
		Prand([8], 1)
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
	\instrument, \armoNoiz,
	\octave, Prand([8], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\ind, 8,
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\degree, Pseq([
		Pseq([0,7, 4], 4),
	], inf).stutter(1),
	\dur, Pseq([
		Prand([0.25], 1)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)




Pbindef(\s1).stop
Pbindef(\s2).stop
Pbindef(\k).stop