(
Pbindef(\k,
	\instrument, \sample,
	\buf, d[\Kick07],
	\dur, Pseq([
		Pseq([2, 2], 1),
		Pseq([2, 1.75, 0.25], 1),
	], inf),
	\rate, 1
);
// Pbindef(\k).stop;
// Pbindef(\k).quant = 4;
Pbindef(\k).play;
)

(
Pbindef(\s,
	\instrument, \sample,
	\buf, d[\Vermona_Snare02],
	\dur, Pseq([
		Pseq([2, 2, 2, 0.75, 1.25], 2),
		Pseq([2, 2, 2, 0.25, 1.75], 2)
	], inf),
	\rate, 1
);
Pbindef(\s).stop;
Pbindef(\s).quant = 1;
Pbindef(\s).play;
)

(
Pbindef(\sin,
	\instrument, \sin,
	\octave, 6,
	\scale, Scale.minor.degrees,
	\degree, Pseq([
		Pseq([0, 2, 1, 3].stutter(1), 2),
		Pseq([6, 5, 3, 0].stutter(1), 2),
		Pseq([1, 3, 2, 4].stutter(1), 2),
		Pseq([6, 7, 6, 1].stutter(1), 2),
	], inf),
	\att, 0.01,
	\dur, Prand([
		Pseq([1, 0.5, 0.5], 2),
		Pseq([1, 0.25, 0.75], 2),
		Pseq([1, 0.75, 0.25], 2),
		Pseq([1, 0.5, 0.5], 2),
	], inf),
	\sus, 0,
	\dec, Pkey(\dur),
	\amp, 0.0
);
// Pbindef(\sin).stop;
// Pbindef(\sin).quant = 4;
Pbindef(\sin).play;
)

(
Pbindef(\fl,
	\instrument, \flanger,
	// \
	\octave, 4,
	\scale, Scale.minor.degrees,
	\degree, Pseq([
		Pseq([[0, 2, 4], [2, 4, 6], [6, 8, 10]].stutter(4), inf),
	], inf),
	\att, 0.01,
	\dur, Pseq([1], inf),
	\sus, 0,
	\dec, 1,
	\amp, 0.03
);
// Pbindef(\fl).stop;
// Pbindef(\fl).quant = 4;
Pbindef(\fl).play;
)


(
Pbindef(\env,
	\instrument, \fmEnv,
	\octave, 3,
	\scale, Scale.minor.degrees,
	\degree, Pseq([
		Pseq([[0, 2, 4, 6], [1,3], [2,4]].stutter(1), 1),
	], inf),
	\att, 8,
	\dur, Pseq([8], inf),
	\sus, 0,
	\dec, 0.01,
	\ind, 5,
	\amp, 0.1
);
// Pbindef(\env).stop;
// Pbindef(\env).quant = 4;
Pbindef(\env).play;
)
(
Pbindef(\k).stop;
Pbindef(\s).stop;
)
(
Pbindef(\k).play;
Pbindef(\s).play;
)















