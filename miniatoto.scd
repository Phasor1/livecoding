~scale = Scale.major;
Scale.names;
~root = 0;
StageLimiter.activate;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Clap05]], inf),
	\dur, Pseq([
		Pseq([2], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4,1]).play();
)


(
Pbindef(\kk,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		Pseq([1], 4),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\kk).stop.quant_([4,0]).play();
)



(
Pbindef(\s1,
	\instrument, \vars,
	\octave, Prand([6], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([6,1], 1),
		Pseq([7,1], 1),
		Pseq([7,0], 1),
		Pseq([6,0], 1),
		// Pseq([0, 7,6,7], 3),
		// Pseq([8, 7,6,7], 1),

	], inf),
	\dur, Pseq([
		// Pseq([1,1,0.5,0.5,0.5,0.5], 4),
		Pseq([0.75], 1),
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
	\instrument, \varsAmbient,
	\octave, Prand([3], inf),
	\distortion, 0.48,
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,2,4,6], [4, 6, 8, 13], [3,5,7,12]], 1),
		// Pseq([[0,2,7]], 1),
		// Pseq([[0,2,4]], 1)+4,
		// Pseq([[0,2,4]], 1)+3,
		// Pseq([[4, 6, 8, 13]], 8),
		// Pseq([[3,5,7,12]], 8),
		// Pseq([[0,2,4,6], [8, 13, 15], [7,12, 14]], 1),

	], inf).stutter(1),
	\dur, Pseq([
		// Pseq([1,1,0.5,0.5,0.5,0.5], 4),
		Pseq([8, 4, 4], 1),
	], inf),
	\strum, 0,
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
	\instrument, \fmEnv,
	\octave, Prand([3], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\ind, 10,
	\degree, Pseq([
		Pseq([[2,4,6,8], [0,2,4,6]], 1),

	], inf),
	\dur, Pseq([
		// Pseq([1,1,0.5,0.5,0.5,0.5], 4),
		Pseq([4], 1),
	], inf),
	\strum, 0,
	\att, Pkey(\dur),
	\sus, 0,
	\dec, 0.01,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)




(
SynthDef(\distortion, {
	|amp=0.5,dur, freq, att=0.01, sus=0.5, dec=1, out, distortion=0.4, pan=0|
	var mod = VarSaw.ar(MouseX.kr(freq/2, freq), 0, 0.5-distortion, 50)*1,
	// (Lag2UD.ar(Dust.ar(30), 0, dur/4) + 0.5),
	sig = VarSaw.ar(freq, width:0.5+distortion,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp * 0.01;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(SynthDef(\distortion, {
	|amp=0.5,dur, freq, att=0.01, sus=0.5, dec=1, out, distortion=0.4, pan=0|
	var mod = VarSaw.ar(freq/2, 0, 0.5-distortion, 50)*1,
	// (Lag2UD.ar(Dust.ar(30), 0, dur/4) + 0.5),
	sig = VarSaw.ar(freq, width:0.5+distortion,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp * 0.01;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;)