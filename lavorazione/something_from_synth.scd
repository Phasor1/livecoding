s.boot

(
SynthDef(\distortion2, {
	|amp=0.5, att=0.01, sus=0, dec=1, freq=440, pan=0, lfo=1|
	var sig = Pulse.ar(freq) + SinOscFB.ar(freq/2, 70),
	nArms = 5,
	det = 0;
	nArms.do{
		|i|
		sig = sig + SinOsc.ar(freq*(i+1)+det) * nArms/(i+1);
		sig = sig + SinOsc.ar(freq/(i+1)-det) * nArms/(i+1);
	};
	// sig = (sig * 30).clip(-1, 1);
	sig = sig.clip(-1, 1);
	sig = BLowPass4.ar(sig, freq*10);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2);
	Out.ar(0, Pan2.ar(sig, pan))
}).add;
)

Synth(\distortion2, [\dec, 4,  \freq, 440, \lfo, 0])
s.scope

(
SynthDef(\distortion2, {
	|amp=0.5, att=0.01, sus=0, dec=1, freq=440, pan=0, lfo=1|
	var sig = Pulse.ar(freq) + SinOscFB.ar(freq/2, 0.7),
	nArms = 5;
	// sig = (sig * 30).clip(-1, 1);
	sig = sig.clip(-1, 1);
	sig = BLowPass4.ar(sig, freq*5);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2);
	Out.ar(0, Pan2.ar(sig, pan))
}).add;
)
