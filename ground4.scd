(
Pbindef(\k,
    \instrument, \sample,
    \buf, d[\Kick18],
    \dur, Pseq([1], inf),
    \amp, 0.1
);
// Pbindef(\k).stop;
// Pbindef(\k).quant = 4;
Pbindef(\k).play;
)

(
Pbindef(\sn,
    \instrument, \sample,
    \buf, d[\Snare12],
    \dur, Pseq([
		Pseq([2, 2, 2, 0.75, 1.25], inf)
	], inf),
    \amp, 0.1
);
Pbindef(\sn).stop;
Pbindef(\sn).quant = 1;
Pbindef(\sn).play;
)


(
Pbindef(\s,
    \instrument, \notchEnv,
    \att, 0,
	\sus, 0,
    \dec, 4,
	\octave, 5,
	\scale, Scale.minor,
	\degree, Pseq([[0, 2, 4], [3, 5, 7]] , inf),
    \dur, Pseq([4], inf),
    \amp, 0.05
);
// Pbindef(\s).stop;
// Pbindef(\s).quant = 4;
Pbindef(\s).play;
)
(
Pbindef(\s2,
    \instrument, \fmBass,
    \att, 0,
	\sus, 0,
    \dec, Pkey(\dur),
	\octave, 6,
	\ind, 2,
	\scale, Scale.minor,
	\degree, Pseq([
		Prand([0, 2, 4, 3, 5, 7], inf)
	], inf) + 6,
    \dur, Pseq([
		Pseq([1, 1, 0.5, 1.5], 3),
		Pseq([1, 1, 0.25, 0.75, 0.25, 0.75], 1)
	], inf),
    \amp, 0.05
);
// Pbindef(\s2).stop;
// Pbindef(\s2).quant = 4;
Pbindef(\s2).play;
)

(
Pbindef(\s3,
    \instrument, \fmBass,
    \att, 0,
	\sus, 0,
    \dec, Pkey(\dur),
	\octave, 2,
	\ind, 5,
	\scale, Scale.minor,
	\degree, Pseq([
		Pseq([[0, 2, 4], [3, 5, 7], [6, 8, 10]].stutter(2), inf)
	] , inf),
	\dur, Pseq([0.5], inf),
    \amp, 0.05
);
Pbindef(\s3).stop;
Pbindef(\s3).quant = 4;
Pbindef(\s3).play;
)