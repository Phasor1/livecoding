
s.boot;
s.meter;
s.plotTree;

Document.current.string;

{postln("mario")}.value
// synth example
(
SynthDef(\mario, {
	|freq, amp=0.5, att, sus=1, dec=0.1, out=0, tremolo=0.25, tremoloWin=0.03|
    var sig = VarSaw.ar(freq, width:0.2);
	sig = BLowPass4.ar(sig, freq *2);
	sig = sig * EnvGen.ar(Env.linen(tremoloWin, tremolo - (tremoloWin*2), tremoloWin).circle);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;
)
(
SynthDef(\glitchCloud, {
	|freq=12000, amp=0.5, duration=4, numGl=90, out, fMod=(12000*1.23), ampMod=2|
	var selector = Amplitude.kr(BLowPass4.ar(WhiteNoise.ar(10), 10, 0.2)).clip(0, 1),
	sig = [
		SinOsc.ar(freq, add:SinOsc.ar(freq*1.34, mul:1.23)),
		SinOsc.ar(freq*1.34, add:SinOsc.ar(freq*4.34, mul:4.23)),
		SinOsc.ar(freq*2.24, add:SinOsc.ar(freq*5.34, mul:1.23))
	];
	selector.poll;
	sig = SelectX.ar(selector*sig.size, sig);
	sig = sig * EnvGen.ar(Env.linen(0.01, duration, 0.01), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;
)
// pattern
(
Pbindef(\mario,
	\instrument, \mario,
	\amp, 0.15,
	\dur, Pseq([0.5, 0.5], inf),
	\octave, 5,
	\scale, Scale.minor,
	\degree, Pseq([
		Pseq([0,2,1,3], 1),
		Pseq([1,4,3,6], 1),
		Pseq([[0, 2, 3], [2, 4, 6], [3,5,7], [6,8,10]], 2),
	], inf),
	\att, 0,
	\sus, 0,
	\dec, Pkey(\dur),
	\tremolo, Pkey(\dur)
).play
)
Synth(\glitchCloud ,[\amp, 0.1, \duration, 8, \fre~q, 10000])
// dropBass
SinOsc.ar(XLine.ar(50, 30, dur))
{var dur = 4; EnvGen.ar(Env.perc(0, dur), doneAction: 2) * BLowPass4.ar(VarSaw.ar(XLine.ar(50, 30, dur)), 50) * 0.5!2}.play






