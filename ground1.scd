(
SynthDef(\comb, {
	|amp=0.5, freq=200, att=0.01, sus=0.5, rel=1|
	var sig = WhiteNoise.ar();
	sig = sig + AllpassN.ar(sig, 1, SinOsc.ar(1, 0, 0.005, 0.005), 2);
	sig = sig * EnvGen.ar(Env.linen(att, sus, rel), doneAction:2) * amp;
	Out.ar(0, sig!2);
}).add;
)
(
SynthDef(\fmFilt, {
	|amp=0.5, freq=200, att=0.01, sus=0.5, rel=1, ind=1, fMod=1|
	var sig = SinOsc.ar(freq + SinOsc.ar(freq * fMod, 0, ind)),
	durS = att+sus+rel;
	sig = sig + AllpassN.ar(sig, 1, EnvGen.ar(Env.sine(durS, 0.05)), durS * 4);
	sig = sig * EnvGen.ar(Env.linen(att, sus, rel), doneAction:2) * amp;
	Out.ar(0, sig!2);
}).add;
)

// PATTERN
(
Pbind(
	\instrument, \phsr,
	\amp, 0.3,
	\scale, Scale.minor,
	\degree, Pseq([0, 1, 3, 5].stutter(16), inf),
	\octave, 2,
	\att, 0.01,
	\sus, Pkey(\dur),
	\rel, 0.25,
	\dur, Pseq([0.5, 0.25, 0.5, 0.25, 0.25, 0.25],inf) / 2
).play;
)

Synth(\phsr, [\freq, 50, \amp, 0.4, \att, 0.01, \sus, 1, \rel, 3])
Synth(\comb, [\freq, 500, \amp, 0.6, \att, 0.01, \rel, 1])
Synth(\fmFilt, [\freq, 500, \amp, 0.6, \att, 0.01, \sus, 1, \rel, 3, \fMod, 300, \ind, 10])
FreqScope(400, 400, server: s)
{(Env.sine(1) * -1) + 1}.test.plot
["ciccio", "mario", "gino"].do{|item, i| (item).postln; (i).postln;}