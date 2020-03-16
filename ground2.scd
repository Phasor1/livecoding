
(
Pbindef(\mario,
	\instrument, \fmBass,
 	\att, 0,
 	\sus, 0,
 	\dec, Pkey(\dur),
 	\octave, 2,
 	\carFR, 2,
 	\scale, Scale.minor,
	\degree, Pseq([0, 2, 1, 4].stutter(4) , inf) + 2,
 	\ind, 10,
 	\dur, Pseq([0.5], inf),
 	\amp, 0.1
).play
)
Pbindef(\mario).quant = 4;
(
Pbindef(\noiz,
	\instrument, \armoNoiz,
 	\att, 0,
 	\sus, 0,
 	\dec, 8,
 	\octave, 10,
 	\scale, Scale.minor,
 	\degree, Pseq([0, 1, 2, 3] , inf),
 	\dur, Pseq([1], inf),
 	\amp, 0.5
).play
)
Pbindef(\noiz).quant = 4;
(
Pbindef(\kick,
	\instrument, \sample,
	\buf, d[\Kick07],
	\rate, 1,
 	\dur, Pseq([2], inf),
 	\amp, 0.3
).play
)

Pbindef(\kick).quant = 2;
(
Pbindef(\snare,
	\instrument, \sample,
	\buf, d[\Snare16],
	\rate, 1,
 	\dur, Pseq([2], inf),
 	\amp, 0.1
).play
)
Pbindef(\snare).stop;
Pbindef(\snare).quant = 1;
Pbindef(\snare).play;

Pbindef(\mario).stop;
Pbindef(\kick).stop;
Pbindef(\noiz).stop;

Pbindef(\mario).play;
Pbindef(\kick).play;
Pbindef(\noiz).play;




SynthDef(\fmBass, {
	|att=0, sus=0, dec=1, amp=0.1, freq=200, carFR=1, modFR=1, modA=0, ind=0, out=0|
	var	indexEnv = Line.ar(ind, 0, att + sus + dec),
	modSin = SinOsc.ar(freq * modFR, mul:freq * modFR * indexEnv),
	carrSin = SinOsc.ar((freq * carFR) + modSin);
	carrSin = carrSin * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	carrSin = BLowPass.ar(carrSin, MouseX.kr(30, 1000).poll);
	Out.ar(0, carrSin!2);
}).add;
