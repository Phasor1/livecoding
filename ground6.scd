s.boot
(
SynthDef(\space, {
	|freq=200, amp, sus=1, att=0, dec=0.5, out, pan=0, ind=1, dur|
	var freqMod = freq*12,
	attTw = 1/10,
	sig = SinOsc.ar(freq +
		XLine.ar(ind, 1, attTw)*VarSaw.ar(
			XLine.ar(freqMod, freq, attTw)
		)
	);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec, 1, 0), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

)

(
SynthDef(\wreng, {
	|freq=200, amp, sus=1, att=0, dec=0.5, out, pan=0,mAmp=2, cRatio=1, mRatio=2, dur, lfo=0.1|
	var freqMod = freq*4,
	env = SinOsc.ar(lfo/2).abs,
	sig = SinOsc.ar(
		(freq*cRatio) +
		env*VarSaw.ar(
			((env.neg + 1)*freq)*mRatio
		)*mAmp

	);
	sig = AllpassC.ar(sig, 0.2, ((env + 0.1)*0.006));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec, 1, 0), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

)
(
SynthDef(\swreng, {
	|freq=200, amp, sus=1, att=0, dec=0.5, out, pan=0,mAmp=2, cRatio=1, mRatio=2, dur, lfo=0.1|
	var freqMod = freq*4,
	env = SinOsc.ar(lfo).clip(0,1),
	sig = SinOsc.ar(freq*cRatio)*(env+1)*VarSaw.ar(freq/mRatio)*mAmp;
	sig = AllpassC.ar(sig, 0.2, ((env + 0.1)*0.006));
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec, 1, 0), doneAction: 2) * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

(
Pbindef(\space,
	\instrument, \wreng,
	\octave, 4,
	\scale, Scale.major,
	\degree, Prand([0,3,5], inf),
	\amp, 0.3,
	\att, 0.01,
	\sus, 0,
	\dec, 0.25,
	\mRatio, 1.5,
	\mAmp, 2,
	\cRatio, 10,
	\pan, 0,
	\dur, 0.25,
	\lfo, 1/2
).play;
)

s.meter
{SinOsc.ar(1).clip(0, 1).neg + 2}.plot(1)