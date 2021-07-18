//
// IF YOU WANT TO SYNC SOME STUFF WITH THE TEMPO, USE l.beatDur and multiples or divider
//


(
	Pbindef(\s1,
		\instrument, \varsLfo,
		\octave, 4,
	\ind, 10,
		\scale, Pfunc({~scale}),
	\root, Pfunc({~root}),
	\degree, Pseq([[4,6,8], [5,7,9]], inf).stutter(1),
	// \dur, Pseq([1, 1, 0.5, 0.5, 0.75, 0.25], inf),
	\dur, Pseq([16], inf),
		\att, 1,
		\sus, 0,
		\dec, Pkey(\dur)*l.beatDur - 1,
		\amp, 0.3
	);
Pbindef(\s1).stop.quant_([4, 0]).play(l);
)

//
// IF YOU WANT TO SEND SOME PARAMETER AT TRIGGER OF THE SOUND EVENT: \msg
//

Pbindef(\sn,
    \instrument, \sample,
    \buf, d[\Snare15],
    \dur, Pseq([4], inf),
    \amp, 0.1,
	\msg, Pfunc({
		|e|
		var fr = 2.asFloat,
		dur = e.use { ~dur.value};
        n.sendMsg("/sound", 0.5.asFloat*1000, 20.asFloat);
	})
);


