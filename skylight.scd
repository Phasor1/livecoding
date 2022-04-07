StageLimiter.activate;

~scale = Scale.major;
Scale.names;
~root = 5;


(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick04]], inf),
	\dur, Pseq([
		// Pseq([1], 4),
		// Pseq([0.25], 16),
		Pseq([1], 6),
		// Pseq([0.25], 8),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\rate, Pseq([0.76], inf),
	\pan, 0,
	\amp, 5,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
SynthDef(\sample, {
	|
	amp,
	buf,
	out,
	rate=1,
	pan=0
	|
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	sig = sig + CombC.ar(sig, 1, 0.25*l.beatDur, 1*l.beatDur);
	sig = EnvGen.ar(Env.linen(0.001, 2*l.beatDur, 0.001), doneAction:2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Clap05]], inf),
	\dur, Pseq([
		// Pseq([1], 4),
		Pseq([0.75], 8),
		// Pseq([0.75], 4),
		// Pseq([0.75], 4)
		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
	], inf),
	\mix, 0.5,
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 0]).play();
)

(
Pbindef(\s1,
	\instrument, \distortion,
	\octave, Prand([4], inf),
	\ind, 4.6,
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0, 2, 7], [1, 3, 8],[2, 4, 9],[6,8,13]], 1),
		Pseq([[0, 3, 7], [1, 4, 8],[2, 5, 9],[-2, 1, 5]], 1),
	], inf),
	\dur, Pseq([
		Pseq([2], 1)
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
Pbindef(\s3,
	\instrument, \vars,
	\octave, Prand([5], inf),
	\ind, 4.6,
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([0,3,0,2], 1),
		Pseq([0,3,0,6], 1),
		Pseq([7,0,7,0], 1),
		Pseq([4,0,4,0], 1),
		// Pseq([], 1),
	], inf),
	\dur, Pseq([
		Pseq([0.5, 1.5, 0.5, 1.5], 4),
		Pseq([1,1,1,1], 4)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, 0,
	\amp, 0
	);
Pbindef(\s3).stop.quant_([4, 0]).play(l);
)



(

SynthDef(\distortion, {
	|amp=0.5,dur, freq, att=0.01, sus=0.5, dec=1, out, distortion=0.4, pan=0|
	var mod = VarSaw.ar(freq/2, 0, 0.5-distortion, 50)*1,
	// (Lag2UD.ar(Dust.ar(30), 0, dur/4) + 0.5),
	sig = VarSaw.ar(freq, width:0.5+distortion,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec*4), doneAction: 2) * amp * 0.01;
	Out.ar(out, Pan2.ar(sig, SinOsc.ar(l.beatDur*2)));
}).add;
)

(
Pbindef(\s2,
	\instrument, \armoNoiz,
	\octave, Prand([7], inf),
	\distortion, 0.6,
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([1

	], inf),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([
		Pseq([8], 1)
	], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
	\pan, Pseq([-0.5, 0.5], inf),
	\amp, 0.3
	);
Pbindef(\s2).stop.quant_([4, 0]).play(l);
)

