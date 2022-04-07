StageLimiter.activate;

~scale = Scale.lydian;
Scale.names;
~root = 0;


(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([1], 16),
		// Pseq([1], 4),
		// Pseq([0.75], 16),
		// Pseq([0.5], 8),
		// Pseq([0.25], 16),
		Pseq([2], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)


(
Pbindef(\hi,
	\instrument, \sample,
	\buf, Pseq([d[\Closedhat17]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([1], 16),
		// Pseq([1], 4),
		// Pseq([0.75], 16),
		// Pseq([0.5], 8),
		// Pseq([0.25], 16),
		Pseq([0.5], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\hi).stop.quant_([4, 0.25]).play();
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Clap06]], inf),
	\dur, Pseq([
		// Pseq([2], 3),
		// Pseq([0.25].stutter(8), 1),
		// Pseq([1], 16),
		// Pseq([1], 4),
		// Pseq([0.75], 16),
		// Pseq([0.5], 8),
		// Pseq([0.25], 16),
		Pseq([4], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0.4,
);
Pbindef(\sn).stop.quant_([4, 2]).play();
)


(

SynthDef(\varsLfo, {
	|amp=0.5, freq=200, att=0.01, sus=0.5, dec=1, lfoF=0.5 ind, out, pan=0|
	var fr = freq + MouseX.kr(-100, 100), first = BLowPass.ar(
		VarSaw.ar(fr, width:0), fr*2
	),
	second = BLowPass.ar(
		VarSaw.ar(
			(fr*2)+SinOsc.ar(lfoF, 0,(1/24)*fr), width:0

	), (freq*4))*0.2,
	sig = (first+second) * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

)

(
SynthDef(\distortion, {
	|amp=0.5,dur, freq, att=0.01, sus=0.5, dec=1, out, distortion=0.4, pan=0|
	var mod = VarSaw.ar(freq/2, 0, 0.5-distortion, 50)*1,
	// (Lag2UD.ar(Dust.ar(30), 0, dur/4) + 0.5),
	sig = VarSaw.ar(freq, width:0.5+distortion,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = BLowPass.ar(sig, freq*12);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec*4), doneAction: 2) * amp * 0.01;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
Pbindef(\s1,
	\instrument, \varsAmbient,
	\octave, Prand([3], inf),
	\distortion, 0.6,
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,4,7], [-1, 2, 7], [-2, 2, 4], [4, 8, 11]-7], 2),
		// Pseq([[0,4,7]]+2, 1),
		// Pseq([[0,4,7]]+4, 1),
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([24], 1)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)



(
SynthDef(\distortion, {
	|amp=0.5,dur, freq, att=0.01, sus=0.5, dec=1, out, distortion=0.4, pan=0|
	var mod = VarSaw.ar(freq/2, 0, 0.5-distortion, 50)*1,
	// (Lag2UD.ar(Dust.ar(30), 0, dur/4) + 0.5),
	sig = VarSaw.ar(freq, width:(SinOsc.ar(l.beatDur)*0.5)+0.5,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec*4), doneAction: 2) * amp * 0.01;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
Pbindef(\s2,
	\instrument, \distortion,
	\octave, Prand([5], inf),
	\distortion, 0.6,
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0,4,7]], 16),
		Pseq([[0,4,7]], 16)+1,
		Pseq([[0,4,7]], 16)+2,
		Pseq([[0,4,7]], 16)+4,
	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([4], inf),
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
SynthDef(\bouncing, {
	|freq, amp, dec=1, out, att, pan=0|
	var sig = VarSaw.ar(freq + MouseX.kr(-100, 100)),
	env = (VarSaw.ar(XLine.ar(1,100,dec), width: 0) * 0.5) + 1;
	sig = sig * env;
	sig = sig * EnvGen.ar(Env.perc(0, dec, 1, 0), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

