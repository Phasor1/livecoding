x[\scale] = Scale.minor;
(
~r1[0] = Pbind(
    \instrument, \sample,
    \buf, d[\kick_zarro],
    \rate, 1,
	\dur, Pseq([1], inf),
    \amp, 0.1
);
~r1[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~r1.play;
~r1.quant = 4;
[4, 0.25, 0.25, 0.25, 0.5, 0.75, 0.5, 0.5, 0.25, 0.25, 0.5]
(
~r2[0] = Pbind(
    \instrument, \sample,
    \buf, d[\wood],
    \rate, 1,
    \dur, Pseq([1], inf) * 2,
    \amp, 0.3
);
~r2[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~r2.play;
~r2.quant = 1;

(
~s1[0] = Pbind(
    \instrument, \sin,
    \att, 0,
	\sus, 4 / m.tempo,
    \dec, 4 / m.tempo,
	\octave, 3,
	\scale, x[\scale],
	\degree, Pseq([[0, 7], [2, 9], [1, 8], [4, 11]] , inf),
    \dur, Pseq([8], inf),
    \amp, 0
);
~s1[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~s1.play;
~s1.quant = 4;

(
~s2[0] = Pbind(
    \instrument, \sin,
    \att, 0,
	\sus, 0,
    \dec, 0.5,
	\octave, 6,
	\scale, x[\scale],
	\degree, Pseq([0, 4, 0, 3, 4, 0, 6, 1] , inf),
    \dur, Pseq([1], inf),
    \amp, 0
);
~s2[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~s2.play;
~s2.quant = 1;

(
~s3[0] = Pbind(
    \instrument, \vars,
    \att, 0,
	\sus, 0,
    \dec, 0.75,
	\octave, 6,
	\scale, x[\scale],
	\degree, Prand([[0, 2, 4], [4, 6, 8], [5, 7, 9], [4, 6, 8], [6, 8, 10]], inf).stutter(4),
    \dur, Pseq([1], inf),
    \amp, 0
);
~s3[1] = \filter -> {
    |in|
	var sig = FreeVerb.ar(in, room: 3);
	// var sig = CombC.ar(in, 0.25, 0.25, 2);
    sig!2;
}
)
~s3.play;
~s3.quant = 4;

(
~s4[0] = Pbind(
    \instrument, \armoNoiz,
    \att, 0,
	\sus, 0,
	\dec, Pkey(\dur),
	\octave, 6,
	\scale, x[\scale],
	\degree, Pseq([0, 4, 5, 13], inf),
    \dur, Prand([1], inf),
    \amp, 0
);
~s4[1] = \filter -> {
    |in|
	var sig = in;
    sig!2;
}
)
~s4.play;
~s4.quant = 4;

(
~s5[0] = Pbind(
    \instrument, \bouncing,
    \att, 0,
	\sus, 0,
    \dec, 2,
	\octave, 3,
	\scale, x[\scale],
	\degree, Pseq([0, 4, 5, 13], inf),
    \dur, Pseq([2], inf),
    \amp, 0
);
~s5[1] = \filter -> {
    |in|
	var sig = in;
    sig!2;
}
)
~s5.play;
~s5.quant = 1;

r = Recorder(s);
r.record();
r.stopRecording;

(
~s1.stop;
~s2.stop;
~s3.stop;
~s4.stop;
~s5.stop;
)
(
~r1.stop;
~r2.stop;
)

(
~s1.play;
~s2.play;
~s3.play;
~s4.play;
~s5.play;
)







s.meter;