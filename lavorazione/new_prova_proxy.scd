s.boot;
s.freeAll;

// PROXY CREATION AND PUSHING
(
p = ProxySpace.push;
p.fadeTime = 2;
)
// SYNTHS DEFINITION
(
SynthDef(\point, {
	|freq, dr|
	var sig = Pulse.ar(freq.midicps, width: 0.5, mul:0.7),
	env = Env.perc(0.001, dr);
	freq.midicps.postln;
	sig = sig * EnvGen.ar(env, doneAction: 2);
	Out.ar(0, sig!2);
}).add;

SynthDef(\fondo, {
	|freq, dr|
	var sig = SinOsc.ar(freq.midicps),
	env = Env.sine(dr);
	sig = sig * EnvGen.ar(env, doneAction:2);
	sig = FreeVerb.ar(sig, mix: 0.5, room:0.2, damp: 1);
	Out.ar(0, sig!2);
}).add;

)
// try sound
Synth(\point, [\freq, 50, \dr, 3]);
Synth(\fondo, [\freq, 50, \dr, 1]);

(
// POINTS PBIND
~ping = Pbind(
	\instrument, \point,
	\freq, Prand(Scale.major.degrees + 50, inf),
	\dur, Pseq([0.5, 0.5, 0.1], inf),
	\dr, Pseq([1, 1], inf)
);
)

(
// FONDO PBIND
~fondo = Pbind(
	\instrument, \fondo,
	\freq, Prand(Scale.major.degrees + 35, inf),
	\dur, Pseq([1, 1, 3], inf),
	\dr, Pseq([1, 1, 3], inf)
);
)

p.clear();

{Pulse.ar(200, mul:0.4) * EnvGen.ar(Env.perc(0.001, 1), doneAction: 2)!2}.play