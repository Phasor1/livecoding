// RHYTM
s.boot;
s.freeAll;
s.freeAll;8
(
z = ProxySpace.push(s);
z.fadeTime = 5;
)
z.clear;
// BEAT BUFFER SYNTH
(
SynthDef(\beat, {
	var sig = PlayBuf.ar(2, Buffer.read(s, 'beats\\b.wav'), doneAction:2) * 0.2;
	Out.ar(0, sig!2);
}).add;
)
// BEAT SYNTH
(
SynthDef(\beatSynth, {
	|freq, dur, amp|
	var sig = Klank.ar(
		`[[freq.midicps, freq.midicps * 2, freq.midicps * 3/2, freq.midicps * 3], [0.9, 0.5, 0.3] * dur, [0.9, 0.7, 0.3] * amp],
		EnvGen.ar(Env.perc(0, 0.015, 0.5)) *  Impulse.ar(0.01)
	);
	Out.ar(0,sig!2);
}).add;
)

// BEAT PATTERN
(
~pattern = Pbind(
	\instrument, \beat,
	\dur, Pseq([0.2, 0.4, 0.2, 0.4, 0.4] / 2, inf)
)
)
z.clear;

// BEAT SYNTH PATTERN
(
~pattern = Pbind(
	\instrument, \beatSynth,
	\amp, 7,
	\freq, Prand(Scale.major.degrees ++ Scale.major.degrees + 60, inf),
	\dur, Pseq([0.2, 0.2, 0.4, 0.4] /3 , inf)
)
)
{var freq = 100, sig = EnvGen.ar(Env.sine(1), doneAction: 2) * SinOsc.ar(freq, 0, 0.5); sig!2}.play()

{EnvGen.ar(Env.perc(0.5, 1.5), doneAction:2) *  Impulse.ar()!2}.play

f = s.record();
f.stopRecording()