x = m.space;
x[\scale] = Scale.major;
Scale.directory
(
~k1[0] = Pbind(
    \instrument, \sample,
    \buf, d[\kick_zarro],
    \rate, 1.2,
	\dur, Pseq([0.5, 0.25, 0.25, 0.5, 0.25]++[0.125].stutter(4), inf) * 2,
    \amp, Pseq([0.4, 0.3, 0.2, 0.3, 0.2], inf) * 0.4
);
~k1[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~k1.play;
~k1.quant = 4;

(
~s1[0] = Pbind(
    \instrument, \sample,
    \buf, d[\wood],
    \rate, 1,
    \dur, Pseq([1, 2], inf),
    \amp, Pseq([0.6], inf)
);
~s1[1] = \filter -> {
    |in|
    var sig = CombC.ar(in, 2, 0.125, 2);
    sig!2;
}
)
~s1.stop(10);
~s1.quant = 4;

(
~v[0] = Pbind(
    \instrument, \sample,
    \buf, Pseq([d[\inhale_woman], d[\exhale_woman]], inf),
    \rate, 1,
    \dur, Pseq([4], inf),
    \amp, Pseq([0], inf)
);
~v[1] = \filter -> {
    |in|
    var sig = FreeVerb.ar(in, mix: 0.5, room:6, damp:5);
	sig!2;
}
)
~v.play;
~v.quant = 4;


(
~fl[0] = Pbind(
    \instrument, \sample,
    \buf, Prand([d[\page_flip_2], d[\page_flip_3], d[\page_flip_4]], inf),
    \rate, 1,
	\dur, Pwhite(0.5, 2),
    \amp, Pseq([0], inf)
);
~fl[1] = \filter -> {
    |in|
    var sig = FreeVerb.ar(in, mix: 0, room:6, damp:5);
	sig!2;
}
)
~fl.play;
~fl.quant = 0.5;

(
~s[0] = Pbind(
    \instrument, \vars,
    \att, 0,
	\sus, 0,
    \dec, Pseq([4], inf),
	\octave, 4,
	\scale, x[\scale],
	\degree, Pseq([[0, 2, 4], [2, 4, 6], [4, 6, 7], [0, 4, 6], [2, 4, 6], [5,6,7]].pyramid(2) , inf).stutter(2),
    \dur, Pseq([4], inf),
    \amp, 0.20
);
~s[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~s.play;
~s.quant = 4;
Pseq([0.125, 0.5, 0.5, 1], inf).stutter(4),
(
~sy[0] = Pbind(
    \instrument, \vars,
    \att, 0,
	\sus, 0,
    \dec, Pseq([0.125, 0.5, 0.5, 1], inf).stutter(6),
	\octave, 5,
	\scale, x[\scale],
	\degree, Pseq([0, 2, 6, 1].pyramid(2) , inf),
    \dur, Pseq([0.125, 0.5, 0.5, 1], inf).stutter(6),
    \amp, 0.2
);
~sy[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~sy.play;
~sy.quant = 4;

(
~gl1[0] = Pbind(
    \instrument, \gl1,
    \att, 0,
	\sus, 0,
	\dec, Pwhite(0.01, 0.5),
	\start, Pwhite(100, 300),
	\end, Pwhite(1000, 2000),
    \dur, Pwhite(0.5, 1),
    \amp, 0
);
~gl1[1] = \filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~gl1.play;
~gl1.quant = 4;

(
~gl2[0] = Pbind(
    \instrument, \imp,
    \dur, Pseq([0.125], inf),
    \amp, 0
);
~gl2[1] = \filter -> {
    |in|
    var sig = Pan2.ar(in, SinOsc.ar(1));
	sig = FreeVerb.ar(sig, mix:0.7, room:50, damp:2);
    sig;
}
)
~gl2.play;
~gl2.quant = 4;

(
~n[0] = Pbind(
    \instrument, \armoNoiz,
	\att, 0,
    \dec, 16,
	\octave, 6,
	\scale, x[\scale],
	\degree, Pseq([0, 1, 7, 6]++[5,4,5,4], inf),
	\dur, 16,
    \amp, 0.3
);
Pseq([0.5].stutter(4)++[0.125].stutter(8));
~n[1] = \filter -> {
    |in|
    in!2;
}
)
~n.play;
~n.quant = 4;

(
~sy.stop;
// ~gl1.stop;
~s.stop;
~n.stop;
)
// RYTHM
(
~k1.stop(10);
~s1.stop(10);
)

(
~sy.play;
~gl1.play;
~s.play;
// )

// RYTHM
// (
~k1.play;
~s1.play;
)



p;


