s.boot;
s.freeAll;
(
p = ProxySpace.push(s);
p.fadeTime = 3;
p.clock = TempoClock.default;
p.clock.tempo = 1;
)
p.clock.tempo = 1
// KICK
(
SynthDef(\kick, {
	|duration, amp|
	var line = XLine.ar(70, 30, duration),
	sig = SinOsc.ar(line, mul:amp),
	env = Env.perc(0.01, duration, 0.5);
	sig = sig * EnvGen.ar(env, doneAction: 2);
	Out.ar(0, sig!2);
}).add;
)
p.fadeTime = 10;
// SNARE
(
SynthDef(\snare, {
	|amp, note|
	var sig = Klank.ar(
		`[
			(1..30) * 2,
			(9..1) / 10,
			(9..1) / 10
		],
		Impulse.ar(0) * amp;
	);
	DetectSilence.ar(sig, doneAction: 2);
	// sig = BLowPass.ar(sig, 60)
	Out.ar(0, sig!2);
}).add;
)
{Impulse.ar(10, 0.5) * EnvGen.ar(Env.perc(0, 0.1), doneAction:2)!2}.play
// PBIND KICK
(
~bass = Pbind(
	\instrument, \kick,
	\dur, Pseq([0.25, 0.10], inf),
	\amp, 0,
	\duration, 0.5
);
)
~bass.quant = 1
Synth(\snare, [\amp, 1])
// PBIND SNARE
(
~snare = nil
~snare = Pbind(
	\instrument, \snare,
	\dur, Pseq([0.5, Pseq([1], inf)], inf),
	\amp, 0.005
	// \type, Pseq([\note, \rest], inf)
)
)

~snare.stop
~snare.quant = 1;
s.meter
s.plotTree