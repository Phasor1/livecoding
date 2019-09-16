s.boot;
s.options.memSize = 65536;
s.freeAll;
(
// SYNTH MUSIC
SynthDef(\saw, {
	|freq, sustain=1, amp=0.5|
	var sig = VarSaw.ar(freq.midicps, mul:amp);
	sig = sig * EnvGen.ar(Env.perc(0, 3, 0.7, sustain), doneAction: 2);
	sig = FreeVerb.ar(sig, room: 1);
	Out.ar(0, sig!2);
}).add;

SynthDef(\sin, {
	|freq, sustain=1, amp=0.5|
	var sig = SinOsc.ar(freq.midicps, mul:0.5);
	sig = sig * EnvGen.ar(Env.perc(0, sustain, 0.7, 3), doneAction: 2);
	sig = FreeVerb.ar(sig, room: 0.2, damp:0.1);
	Out.ar(0, sig!2);
}).add;

// RHYTHM

SynthDef(\rhythm, {
	|freq, sustain=1|
	var sig = PinkNoise.ar(0.5);
	sig = sig * EnvGen.ar(Env.perc(0, sustain, 0.7, 2) , doneAction: 2);
	Out.ar(0, sig!2);
}).add;

SynthDef(\rhythm2, {
	|freq, sustain=1|
	var sig = SinOsc.ar(80.midicps, mul:0.5);
	sig = sig * EnvGen.ar(Env.perc(0, sustain, 0.7, 2), doneAction: 2);
	Out.ar(0, sig!2);
}).add;

)

Synth(\rhythm2, [\rel, 0.06]);
Synth(\sin, [\note, 60, \rel, 0.5]);

(
{
	var sig = PinkNoise.ar(0.5);
	sig =
	sig = sig * EnvGen.ar(Env.perc(0.04, rel, 0.7, 2), doneAction: 2);
	Out.ar(0, sig!2);
}
)

// PBIND
(
Pbind(
	\instrument, \sin,
	\freq, Prand([70, 73, 77, 80, 83, 86, 89], inf),
	\dur, Prand([1, 2, 0.2], inf)
).play;
)
Synth(\sin).set(\rel) = 0.2;
