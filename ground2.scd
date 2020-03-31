
(
Pbindef(\mario,
	\instrument, \phsr,
 	\att, 0,
 	\sus, 0,
 	\dec, 8,
 	\octave, 2,
 	\scale, Scale.minor,
	\degree, 0,
 	\dur, Pseq([8], inf),
 	\amp, 0.4
).play
)
Pbindef(\mario).quant = 4;
(
Pbindef(\boing,
	\instrument, \bouncingBall,
 	\att, 0,
 	\sus, 0,
 	\dec, 8,
 	\octave, 7,
 	\scale, Scale.minor,
 	\degree, Pseq([[0, 1, 2, 3]] , inf),
 	\dur, Pseq([8], inf),
 	\amp, 0
).play
)
Pbindef(\boing).play;
Pbindef(\boing).quant = 4;
(
Pbindef(\fm,
	\instrument, \fmBass,
 	\att, 0,
 	\sus, 0,
 	\dec, 0.5,
 	\octave, 2,
	\ind, 5,
 	\scale, Scale.minor,
	\degree, Pseq([
		Pseq([0, 1, 5, 6].stutter(2), 2),
		Pseq([0, 7, 0, 7].stutter(1))
	], inf),
 	\dur, Pseq([0.5], inf),
 	\amp, 0.01
).play
)
Pbindef(\fm).quant = 4;
(
Pbindef(\kick,
	\instrument, \sample,
	\buf, d[\Kick08],
	\rate, 1,
 	\dur, Pseq([1], inf),
 	\amp, 0
).play;

Pbindef(\kick).stop;
Pbindef(\kick).quant = 4;
Pbindef(\kick).play;
)
[1, 0.125, 0.125, 0.75, 0.125, 0.125, 0.75, 0.5, 0.5]++
		[0.75, 0.75, 0.75, 0.75]
[1, 0.25, 0.25, 0.75, 0.25, 1, 0.125, 0.125, 0.75]
(
Pbindef(\snare,
	\instrument, \sample,
	\buf, d[\Snare17],
	\rate, 0.7,
 	\dur, Pseq([2, 2, 1.5, 0.5], inf),
 	\amp, 0
).play
)
[2, 2, 2, 0.75, 0.25, 1]
Pbindef(\snare).stop;
Pbindef(\snare).quant = 1;
Pbindef(\snare).play;
(
Pbindef(\ph,
	\instrument, \fmBass,
 	\att, 0,
 	\sus, 0,
 	\dec, 0.5,
 	\octave, 6,
	\ind, 5,
 	\scale, Scale.minor,
	\degree, Prand([0, 1, 2, 3, 4, 5, 6, 7].stutter(1) , inf) + 2,
 	\dur, Prand([0.5, 0.25, 1], inf),
 	\amp, 0
).play;
Pbindef(\ph).stop;
Pbindef(\ph).quant = 4;
Pbindef(\ph).play;

)
[0, 2, 4], [3, 5, 7], [6, 8, 10]
Pbindef(\boing).quant = 4;
(
Pbindef(\rm,
	\instrument, \fmBass,
 	\att, 0,
 	\sus, 0,
 	\dec, 1,
 	\octave, 5,
	\ind, 5,
 	\scale, Scale.minor,
	\degree, Prand([0, 7, 0, 7, 0, 1, 2, 3, 4, 3, 1].stutter(8) , inf),
 	\dur, Pseq([0.25], inf),
 	\amp, 0.0
).play
)
[1, 1, 0.25, 0.25, 0.5, 1]
Pbindef(\boing).quant = 4;



(
Pbindef(\armN,
	\instrument, \armoNoiz,
 	\att, 0,
 	\sus, 0,
 	\dec,0.75,
 	\octave, 12,
 	\scale, Scale.minor,
	\degree, Pseq([1], inf),
 	\dur, Pseq([0.75, 0.75, 0.75, 0.125, 0.125, 0.125, 0.975], inf),
 	\amp, 0
).play
)
Pbindef(\armN).stop;
Pbindef(\armN).quant = 4;
Pbindef(\armN).play;

s.plotTree
