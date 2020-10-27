s.latency = 0.1
(
Pbindef(\k,
    \instrument, \sample,
    \buf, d[\Kick16],
    \dur, Pseq(
		[
			Pseq([
				Pseq([4], 2),
				/*Pseq([0.25, 0.25, 0.5], 2),
				Pseq([1], 2),
				Pseq([0.75, 0.75, 0.5], 2),*/
			], 4),
			// Pseq([4], 8)
	], inf),
    \amp, 0
);
Pbindef(\k).stop;
Pbindef(\k).quant = 4;
Pbindef(\k).play;
)


(
Pbindef(\k).stop;
Pbindef(\sn).stop;
Pbindef(\s2).stop;
)

(
Pbindef(\k).play;
Pbindef(\sn).play;

Pbindef(\noise,
    \instrument, \armoNoiz,
    \att, 0.01,
	\sus, 4,
    \dec, 4,
	\octave, 7,
	\scale, Scale.minor,
	\degree, Prand([0, 7] , inf),
	\root, 4,
	\dur, Pseq([1], inf),
    \amp, 0
);
Pbindef(\noise).stop;
Pbindef(\noise).quant = 4;
Pbindef(\noise).play;
Pbindef(\s2).play;

)

(
Pbindef(\sn,
    \instrument, \sample,
    \buf, d[\Snare12],
    \dur, Pseq([
		// Pseq([2, 2, 2, 0.75, 1.25], inf)
		Pseq([2], inf)
	], inf),
    \amp, 0
);
Pbindef(\sn).stop;
Pbindef(\sn).quant = 1;
Pbindef(\sn).play;
)


(
Pbindef(\s2,
    \instrument, \varsLfo,
    \att, 0.01,
	\sus, 0,
    \dec, 4,
	\octave, 5,
	\scale, Scale.major,
	\degree, Pseq([
		Pseq([0,7,6, 5,4,3, 2, 1], 2),
		/*Pseq([0, 7, 4], 4),
		Pseq([[0, 4], [5, 9]], 4) - 8,
		Pseq([[0, 4], [5, 9]], 4) - 16,*/
		/*Pseq([[0, 2, 4], [2,4 ,6], [4,6,7]], 4),
		Pseq([[0, 2, 4], [2,4 ,6], [4,6,7]], 8) + Prand([1,3,2,5], inf),*/
	], inf),
    \dur, Prand([4], inf),
	\root, 4,
	\pan, 0,
    \amp, 0
);
Pbindef(\s2).stop;
Pbindef(\s2).quant = 4;
Pbindef(\s2).play;
)

(
Pbindef(\s3,
    \instrument, \armoBubble,
    \att, 0.01,
	\sus, 0,
    \dec, 4,
	\octave, 2,
	\scale, Scale.minor,
	\degree, Pseq([
		Pseq([[0,2,4], [4,6,8]])
	] , inf),
	\root, 4,
	\dur, Pseq([4], inf),
    \amp, 0.2
);
Pbindef(\s3).stop;
Pbindef(\s3).quant = 4;
Pbindef(\s3).play;
)



(

Pbindef(\k,
    \instrument, \sample,
    \buf, d[\Vermona_Kick03],
    \dur, Pseq(
		[
			Pseq([
				Pseq([1], 2),
				/*Pseq([0.25, 0.25, 0.5], 2),
				Pseq([1], 2),
				Pseq([0.75, 0.75, 0.5], 2),*/
			], 4),
			// Pseq([4], 8)
	], inf),
    \amp, 0
);
Pbindef(\k).stop;
Pbindef(\k).quant = 4;
Pbindef(\k).play;
)