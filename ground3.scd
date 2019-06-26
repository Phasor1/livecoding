x = m.space;
x[\scale] = Scale.major;
(
~kz[0] = Pbind(
    \instrument, \sample,
    \buf, d[\kick_zarro],
    \dur, Pseq([0.5, 0.25, 0.75, 0.5], inf),
    \amp, 0.1
);
~kz[1] = \filter -> {
    |in|
	in!2;
	// CombN.ar(in, 0.5, 0.125, 0.5)!2;
}
)
~kz.play;
~kz.quant = 4;
~kz.stop;

x[\scale] = Scale.major;
(
~sn[0] = Pbind(
    \instrument, \sample,
    \buf, d[\wood],
	\rate, 0.3,
    \dur, Pseq([1], inf),
    \amp, 0.1
);
~sn[1] = \filter -> {
    |in|
	in!2;
	// CombN.ar(in, 0.5, 0.125, 0.5)!2;
}
)
~sn.play;
~sn.quant = 4;
~sn.stop;


(
~flip[0] = Pbind(
    \instrument, \sample,
    \buf, Prand([d[\page_flip_2],d[\page_flip_3], d[\page_flip_4] ], inf),
    \dur, Prand([2, 4, 1], inf),
    \amp, 0.4
);
~flip[1] = \filter -> {
    |in|
    in!2;
}
)
~flip.play;
~flip.quant = 4;
~flip.stop;

(
~breathe[0] = Pbind(
    \instrument, \sample,
	\rate, 0.1,
    \buf, Pseq([d[\inhale_woman],d[\exhale_woman]], inf),
    \dur, Prand([4], inf),
    \amp, 0.1
);
~breathe[1] = \filter -> {
    |in|
	var sig = FreeVerb.ar(in, 0.8, room:20, damp: 20);
    sig!2;
}
)
~breathe.play;
~breathe.quant = 4;
~breathe.stop;
i = 0;

(
~s[0] = Pbind(
    \instrument, \sinPan,
    \att, 0,
	\sus, 0,
    \dec, 0.5,
	\octave, 7,
	\scale, x[\scale],
	\degree, Prand([0, 2, 3, 6, 5] + 4, inf),
    \dur, Prand([0.25], inf),
	\pan, Pseq(((-10..0) / 10) ++ ((0..10) / 10), inf),
    \amp, 0
);
~s[1] = \filter -> {
    |in|
	var sig = in;
	sig = CombC.ar(sig, 4, 0.125, 4);
	sig = FreeVerb.ar(in, 0.4, 4, 1);
	sig!2;
}
)
~s.play;
~s.quant = 4;
~s.stop


(
~chord[0] = Pbind(
    \instrument, \vars,
    \att, 0.5,
	\sus, 4,
    \dec, 8,
	\octave, 1,
	\scale, x[\scale],
	\degree, Pseq([[0, 4], [2, 4], [4, 6]] + 0 , inf),
    \dur, Pseq([8], inf),
    \amp, 0
);
~chord[1] = \filter -> {
    |in|
	CombC.ar(in, 8, 0.75, 8)!2;
}
)
~chord.play;
~chord.quant = 4;
~chord.stop;

(
~gl1[0] = Pbind(
    \instrument, \gl1,
    \att, 0,
	\sus, 0,
    \dec, 8,
	\start, Pwhite(1000, 1500),
	\end, Pwhite(5, 100),
    \dur, Prand([0.25], inf),
    \amp, 0.1
);
~gl1[1] = \filter -> {
    |in|
    in!2;
}
)
~gl1.play;
~gl1.quant = 4;
~gl1.stop;


(
~sawFM[0] = Pbind(
    \instrument, \sawFMSynth,
    \att, 2,
	\sus, 4,
    \dec, 2,
	\octave, 3,
	\scale, x[\scale],
	\degree, Prand((0..7) + 3 , inf),
    \dur, Prand([8], inf),
    \amp, 0.1
);
~sawFM[1] = \filter -> {
    |in|
    in!2;
}
)
~sawFM.play;
~sawFM.quant = 4;
~sawFM.stop;

(
~kz.stop;
~sn.stop;
~flip.stop;
~breathe.stop;
)
// PLAY RHYTMIC
(
~kz.play;
~sn.play;
~flip.play;
~breathe.play
)
// STOP HARMONICS
(
~gl.play;
~chord.play;
~s.play;
// ~saw.stop;
)

// PLAY HARMONICS

(
~gl.stop;
~chord.stop;
~s.stop;
// ~saw.stop;
)

s.meter;
s.scope;