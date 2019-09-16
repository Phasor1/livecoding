x = m.space;
x[\scale] = Scale.minor;
(
~m1[0] = Pbind(
    \instrument, \sample,
    \buf, d[\kick_zarro],
    \rate, 1,
	\dur, Pseq([1], inf),
	\amp, 0
);
~m1[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~m1.play;
~m1.quant = 4;


(
~m2[0] = Pbind(
    \instrument, \sample,
    \buf, d[\wood],
    \rate, 1,
	\dur, Pseq([1], inf),
	\amp, 0
);
~m2[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~m2.play;
~m2.quant = 1;




(
~m3[0] = Pbind(
    \instrument, \sample,
    \buf, d[\clanksingle],
    \rate, 1,
	\dur, Pseq([4], inf),
	\amp, 0
);
~m3[1] = \filter -> {
    |in|
    var sig = in;
	sig = CombL.ar(sig, 4, 0.25, 4);
    sig!2;
}
)
~m3.play;
~m3.quant = 2;

(
~m4[0] = Pbind(
    \instrument, \sample,
    \buf, Prand([d[\page_flip_2], d[\page_flip_3], d[\page_flip_4]], inf),
    \rate, Pwhite(0.75, 1.7),
	\dur, 1,
	\amp, 0.15
);
~m4[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~m4 = nil;
~m4.quant = 2;

(
~m5[0] = Pbind(
    \instrument, \sample,
    \buf, d[\paper],
    \rate, Pwhite(2, 5),
	\dur, Pwhite(0.5, 4),
	\amp, 0.2
);
~m5[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~m5 = nil;
~m5.quant = 4;

(
~s1[0] = Pbind(
    \instrument, \sin,
    \att, 0,
    \dec, 8,
	\octave, 4,
	\scale, x[\scale],
	\degree, Pseq([[0, 2, 4], [1, 3, 6], [4, 6, 7], [5, 6, 7]], inf),
    \dur, Pseq([8], inf),
    \amp, 0
);
~s1[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
[0, 2, 3, 6, 5]

[0, 2, 4], [1, 3, 6], [4, 6, 7], [5, 6, 7]

(
~s2[0] = Pbind(
    \instrument, \bouncingBall,
	\sus, 0,
    \dec, 1,
	\octave, 7,
	\scale, x[\scale],
	\degree, Prand([0, 3, 6, 5, 4], inf),
    \dur, Pseq([4], inf),
    \amp, 0.1
);
~s2[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
[0, 2, 3, 6, 5]
~s2.play;
~s2.quant = 4;

(
~s3[0] = Pbind(
    \instrument, \armoNoiz,
    \att, 0,
	\sus, 0,
    \dec, 0.25,
	\octave, 8,
	\scale, x[\scale],
	\degree, Pseq([0, 2, 3, 0, 6, 5, 0, 2, 3, 5, 6, 7], inf),
    \dur, Pseq([0.25], inf),
    \amp, 0
);
~s3[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~s3.play;
~s3.quant = 4;
p
(
~s4[0] = Pbind(
    \instrument, \vars,
	\att, 0,
	\sus, 0,
	\dec, Pseq([0.5], inf),
	\octave, 6,
	\scale, x[\scale],
	\degree, Pseq([0, 3, 4, 5].stutter(2).pyramid(2), inf),
    \dur, Pkey(\dec, inf),
    \amp, 0
);
~s4[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~s4.play;
~s4.quant = 0.25;

(
~s5[0] = Pbind(
    \instrument, \sin,
    \att, 0,
	\sus, 0,
    \dec, 8,
	\octave, 6,
	\scale, x[\scale],
	\degree, Pseq([0, 3, 5, 6, 5,6, 7], inf),
    \dur, 4,
    \amp, 0
);
~s5[1] = \filter -> {
    |in|
    var sig = in;
	sig = CombC.ar(sig, 4, 0.75, 8);
	sig = FreeVerb.ar(sig, damp:2);
    sig!2;
}
)
~s5.play;
~s5.quant = 4;

(
~s1.stop;
~s2.stop;
~s3.stop;
~s4.stop;
~s5.stop;
)

(
~s1.play;
~s2.play;
~s3.play;
~s4.play;
~s5.play;
)

(
~m1.stop;
~m2.stop;
~m3.stop;
~m4.stop;
~m5.stop;
)

(
~m1.play;
~m2.play;
~m3.play;
~m4.play;
~m5.play;
)


p.gui
s.meter
s.scope