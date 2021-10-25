~scale = Scale.minor;
Scale.names;
~root = 0;

(
Pbindef(\k,
	\instrument, \sample,
	\buf, Pseq([d[\Kick07]], inf),
	\dur, Pseq([
		Pseq([1], 8),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)

(
Pbindef(\sn,
	\instrument, \sample,
	\buf, Pseq([d[\Clap04]], inf),
	\dur, Pseq([
		Pseq([0.75], 8),
	], inf),
	\rate, Pseq([1], inf),
	\pan, Pwhite(-1, 1),
	\amp, 0,
);
Pbindef(\sn).stop.quant_([4, 0]).play();
)


(
Pbindef(\s1,
	\instrument, \varsLfo,
	\distortion, 0.5,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([[0, 2, 4], [-1, 1, 3], [0, 2, 4], [-1, 1, 3]], 1).stutter(1)+4,
	], inf),
	\dur, Pseq([
		Pseq([8], 1)
	], inf),
	\att, 0.01,
	\ind, 15,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur*4,
	\pan, 0,
	\amp, 0
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

(
Pbindef(\s2,
	\instrument, \distortion,
	\distortion, 0.8,
	\octave, Prand([5], inf),
	\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([
		Pseq([
			Pseq([6, 2, 1, -1], 3).stutter(1),
			Pseq([7,6,7,5], 1).stutter(1),
		], 2),
		Pseq([
			Pseq([6, 2, 1, -1], 3).stutter(1),
			Pseq([7,6,7,5], 1).stutter(1),
		], 2)+5
	], inf),
	\dur, Pseq([
		Pseq([0.25], 1)
	], inf),
	\att, 0,
	\ind, 10,
	\sus, 0,
	\dec, Pkey(\dur)*l.beatDur/2,
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
	sig = VarSaw.ar(freq, width:0.5+distortion,add:mod);
	// sig = BLowPass4.ar(sig, MouseX.kr(freq, 20000));
	// sig = sig + CombC.ar(sig, 1, 0.25, 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec*4), doneAction: 2) * amp * 0.01;
	sig = FreeVerb.ar(sig, MouseX.kr(0, 1), 1, 5);
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
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
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)