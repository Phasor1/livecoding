s.boot;
s.freeAll;
(
p = ProxySpace.push(s);
p.fadeTime = 5
)

// KLANK
(
SynthDef(\note, {
	|freq, dur, amp, noteDur|
	var sig = Klank.ar(
		`[
			[freq.midicps, freq.midicps * 2, freq.midicps * 3/2, freq.midicps * 3],
			[0.9, 0.5, 0.3] * amp,
			[0.9, 0.7, 0.3] * noteDur],
		EnvGen.ar(Env.perc(0, 0.015, 0.5)) * Impulse.ar(0.01) * amp
	);
	Out.ar(0,sig!2);
}).add;
)
// LANDSCAPE
(
SynthDef(\landscape, {
	|freq, dur, amp, noteDur|
	var sig = Klang.ar(
		`[
			[
				freq.midicps,
				freq.midicps * 3/2,
				freq.midicps * 2,
				freq.midicps, freq.midicps * 3,
				freq.midicps * 4

			],
			[0.9, 0.7, 0.5, 0.4, 0.3] * amp,
			[0.5, 0.6, 0.7, 0.8, 0.9] * noteDur
		]
	);
	sig = sig * EnvGen.ar(Env.sine(noteDur, 0.3), doneAction: 2);
	Out.ar(0, sig!2);
}).add;
)
Synth(\landscape, [\freq, 30, \dur, 3, \noteDur, 3, \amp, 0.7];)
(
// PATTERN
~beat = Pbind(
	\instrument, \note,
	\freq, Prand([52, 56, 59, 63], inf),
	// \freq, Prand((Scale.minor.degrees + 40) ++ (Scale.major.degrees + 52), inf),
	\amp, 0,
	\dur, Pseq([0.5, 0.5, 0.35, 0.5, 0.35], inf),
	\noteDur, 10
)
)
(
~landscape = Pbind(
	\instrument, \landscape,
	\freq, Prand((Scale.minor.degrees + 16), inf),
	\amp, 0,
	\dur, 2,
	\noteDur, 3
)
)
s.meter;
p.clear;
