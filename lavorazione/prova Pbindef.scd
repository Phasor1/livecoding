s.boot;
s.latency = 0;
(
SynthDef(\mario, {
	|freq=200, amp=0.1, att=0.01, sus=0, rel=1|
	var sig = SinOsc.ar(freq + SinOsc.ar(freq + 3, mul:50 * 10));
	sig = sig * EnvGen.ar(Env.linen(att, sus, rel), doneAction: 2) * amp;
	Out.ar(0, sig!2)
}).add;
)
m = MandelHub.start("gigino");

x = m.space;
x[\scale] = Scale.major;
m.gui;
~fun = Pfunc({
	x[\scale];
})
(
Pbindef(\ciccio,
	\instrument, \mario,
	\octave, 6,
	\att, 0.001,
	\scale, ~fun,
	\degree, Pseq([
		Pseq([6, 5, 4, 5])]
	,inf),
	\amp, 0.1,
	\dur, Pseq([0.5], inf),

	// \strum, 0.01
).play
)
Pbindef(\ciccio).quant = 4;
Pbindef(\ciccio).play