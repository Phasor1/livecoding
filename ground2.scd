x = m.space
x[\scale] = Scale.minor;
(
~k[0] = Pbind(
	\instrument, \sample,
	\dur, Pseq([1, 0.5, 0.5, 1], inf),
	\buf, Prand([d[\kick_zarro]], inf),
	\amp, Prand([0.3, 0.3, 0.1, 0.4], inf) * 0.6
);
[1, 0.5, 0.5, 1] ++ [0.125].stutter(4) ++ [0.25].stutter(2)
)
~k.play;
~k.quant = 4;

(
~woman[0] = Pbind(
	\instrument, \sample,
	\dur, Pseq([4], inf),
	\buf, Pseq([d[\exhale_woman], d[\inhale_woman]], inf),
	\amp, 0.3
);
[1, 0.5, 0.5, 1] ++ [0.125].stutter(4) ++ [0.25].stutter(2)
)
~woman.play;
~woman.stop;
~woman.quant = 4;


(
~w[0] = Pbind(
	\instrument, \sample,
	\dur, Pseq([2], inf),
	\buf, d[\wood],
	\amp, 0.5
)
)
~w.play;
~w.quant = 1;
(
~flip[0] = Pbind(
	\instrument, \sample,
	\dur, Pseq([1, 3, 0.5, 2, 1], inf),
	\buf, Pseq([d[\page_flip_2], d[\page_flip_3], d[\page_flip_4] ],inf),
	\amp, Prand([0.5], inf) * 0.6
)
)
~flip.play
~flip.quant = 4;


(
~chordh[0] = Pbind(
	\instrument, \vars,
	\att, 0,
	\dur, Prand([8], inf),
	\duration, 10,
	\octave, 4,
	\scale, x[\scale],
	\degree, Pseq([[0, 4], [2, 4], [4, 6]] , inf),
	\amp, 0.2
)
)
~chordh.play;
~chordh.quant = 4;

(
~chordl[0] = Pbind(
	\instrument, \vars,
	\att, 0,
	\dur, Prand([8], inf),
	\duration, 10,
	\octave, 3,
	\scale, x[\scale],
	\degree, Pseq([[0, 4], [2, 4], [4, 6]] + 1 , inf),
	\amp, 0.2
)
)
~chordl.play;
~chordl.quant = 4;
~s = nil;
~n = nil;
(
~saw[0] = Pbind(
	\instrument, \sawSynth,
	\att, 0,
	\dur, Prand([8], inf),
	\duration, 10,
	\octave, 2,
	\scale, x[\scale],
	\degree, Prand([0, 1, 2, 3], inf),
	\amp, 0.02
)
)
~saw.play;
~saw.quant = 4;


(
~g[0] = Pbind(
	\instrument, \glitch,
	\att, 0,
	\dur, Prand([0.5], inf),
	// \rest, 0.5,
	\duration, 0.5,
	\octave, 6,
	\scale, x[\scale],
	\degree, Prand((0..7) , inf),
	\amp, 0.3
);
~g[1] = \filter->{
	|in|
	// var sig = CombL.ar(in, 8, 0.125 ,8);
	FreeVerb.ar(in, 0.3, damp: 3)
}
)
~g.play;
~g.quant = 4;

~v = nil;
(
~ab[0] = Pbind(
	\instrument, \waveTable1,
	\att, 3,
	\dur, Prand([4], inf),
	\duration, 1,
	\octave, 3,
	\scale, x[\scale],
	\degree, Pseq((0..7).stutter(1).pyramid(2), inf),
	\amp, 0.2
);
/*~v[1] = \filter->{
	|in|
	var sig = CombL.ar(in, 8, 0.25 ,8);
	sig = FreeVerb.ar(sig, 0.3, damp: 3)
}*/
)
~ab.stop;
~ab.quant = 4;

(
~glitch[0] = Pbind(
	\instrument, \gl1,
	\dur, Pseq([1], inf),
	\start, Pseq([Pwhite(500, 600)], inf),
	\end, Pseq([Pwhite(100, 2000)], inf),
	\amp, 0.2
);
~glitch[1] = \filter ->{
	|in|
	CombC.ar(in, 3, 0.125, 3)!2;
}
)
~glitch.play;
~glitch.quant = 4;

// STOP RHYTMIC
(
~k.stop;
~w.stop;
~flip.stop;
)
// PLAY RHYTMIC
(
~k.play;
~w.play;
~flip.play;
)
// STOP HARMONICS
(
~g.stop;
~chordh.stop;
~chordl.stop;
~saw.stop;
)

// PLAY HARMONICS

(
~g.play;
~chordh.play;
~chordl.play;
~saw.play;
)
s.meter
