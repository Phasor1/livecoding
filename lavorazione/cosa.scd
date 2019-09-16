(
SynthDef(\sino, {
	|freq, amp, duration, attack, out|
	var sig = VarSaw.ar(freq, width: 0.5),
	env = Env.perc(attack, duration);
	sig = EnvGen.ar(env) * sig;
	sig = sig * EnvGen.ar(Env.linen(0, duration, 0), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;
)

(
~sino = Pbind(
	\instrument, \sino,
	\attack, 0.1,
	\duration, Pseq([5], inf),
	\scale, Scale.minor,
	\octave, 3,
	\degree, Pseq([0, 3, 4, 6, 7], inf),
	\amp, 0.0,
	\dur, Pseq([5], inf)
)
)
p.fadeTime = 0;
~sino.play
~sino = 0;
~sino.quant = 1;

Scale.major.degrees
[0, 3, 4] ++ [7, 5, 4]

(
~mel = Pbind(
	\instrument, \sino,
	\attack, 0.01,
	\duration, Pseq([1], inf),
	\scale, Scale.minor,
	\octave, 6,
	\degree, Pseq([4,6,5,7], inf),
	\amp, 0.0,
	\dur, Pseq([0.5], inf)
)
)
~mel.play;
~mel.stop;
s.meter;

(
SynthDef(\pan, {
	|out, amp, freq, attack, del, durdel, pan|
	var sig = VarSaw.ar(freq, mul:0.1),
	env = Env.perc(attack, 0.5);
	sig = EnvGen.ar(env) * sig;
	sig = CombN.ar(sig, durdel, del, durdel);
	sig = sig * EnvGen.ar(Env.linen(0, durdel, 0), doneAction: 2) * amp;
	sig = Pan2.ar(sig, pan);
	Out.ar(out, sig!2);
}).add;
)

(
~pan = Pbind(
	\instrument, \pan,
	\dur, Pseq([3], inf),
	\attack, 0.01,
	\scale, Scale.minor,
	\octave, 6,
	\degree, Prand([1,2,3,4], inf),
	\del, 0.1,
	\durdel, 3,
	\amp, 0,
	\pan, Pseq([0.1, 0.2, 0.5, 0.3, 0.1, 0.2, 0.4, 0.5, 0.3], inf)
)

)
~pan.play;




s.meter




















