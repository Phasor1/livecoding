Document.current.string

(
Pbindef(\k,
    \instrument, \sample,
    \buf, d[\Kick10],
    \dur, Pseq([4], inf),
    \amp, 0.1,
	\msg, Pfunc({
		|e|
		var fr = 2.asFloat,
		dur = e.use { ~dur.value};
        n.sendMsg("/sound", 0.5.asFloat*1000, fr);
	})
);
Pbindef(\k).stop;
Pbindef(\k).quant = 4;
Pbindef(\k).play;
)
(
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
Pbindef(\sn).stop;
Pbindef(\sn).quant = 2;
Pbindef(\sn).play;
)
(
Pbindef(\s2,
    \instrument, \sin,
    \octave, 6,
	\scale, Scale.minor,
	\degree, Pseq([
		Pseq([0, 2, 3], 4),
		Pseq([6, 4, 5, 1], 1)
	], inf),
    \dur, Pseq([1], inf),
	\att, 0.01,
	\sus, 0,
	\dec, Pkey(\dur),
    \amp, 0.05
/*	\msg, Pfunc({
		|e|
		var fr = e.use { ~freq.value },
		dur = e.use { ~dur.value};
        n.sendMsg("/sound", 0.5.asFloat*1000, fr.asFloat);
	})*/
);
Pbindef(\s2).stop;
Pbindef(\s2).quant = 4;
Pbindef(\s2).play;
)

(
SynthDef(\sample, {
	|
	amp,
	buf,
	out,
	rate=1
	|
	var sig = PlayBuf.ar(2, buf, rate) * amp;
	sig = sig * EnvGen.ar(Env.linen(0.01, 4, 0.01), doneAction: 2);
	sig = sig + CombC.ar(sig, 4, 0.75, 4);
	Out.ar(out, sig!2);
}).add;
)

(
SynthDef(\sin, {
	|freq, amp = 0, sus, dec=0.1, att, out|
	var sig = SinOsc.ar(freq);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	sig = sig + CombC.ar(sig, 0.5, 0.25, 1);
	Out.ar(out, sig!2);
}).add;
)
(
SynthDef(\phsr, {
	|amp=0.5, freq=200, att=0.01, sus=0.5, dec=1, out|
	var sig = Silent.ar(1);
	[freq, freq * 2, freq * 3].do{
		|item, i|
		sig = sig + VarSaw.ar(item,0,1
		) * 1/(i + 1);
	};
	// sig = BLowPass.ar(sig, XLine.ar(10000, freq, att+sus+dec), 3);
	sig = BLowPass.ar(sig, SinOsc.ar(1/(att+sus+dec), 0, 100, 100 + freq), 3);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction:2) * amp;
	Out.ar(out, sig!2);
}).add;
)

(
Pbindef(\s3,
    \instrument, \phsr,
    \octave, 3,
	\scale, Scale.minor,
	\degree, Pseq([
		Pseq([[0, 2, 4], [2, 4, 5], [4, 6, 8], [6, 8, 10]], inf),
	], inf),
    \dur, Pseq([8], inf),
	\att, 4,
	\sus, 4,
	\dec, 4,
    \amp, 0.3
/*	\msg, Pfunc({
		|e|
		var fr = e.use { ~freq.value },
		dur = e.use { ~dur.value};
        n.sendMsg("/sound", 0.5.asFloat*1000, fr.asFloat);
	})*/
);
Pbindef(\s3).stop;
Pbindef(\s3).quant = 4;
Pbindef(\s3).play;
)
(
Pbindef(\s4,
    \instrument, \bouncing,
    \octave, 6,
	\scale, Scale.minor,
	\degree, Pseq([
		Pseq([1, 3, 4], inf),
	], inf),
    \dur, Pseq([4], inf),
	\att, 0.01,
	\sus, 0,
	\dec, 4,
    \amp, 0.1,
	\msg, Pfunc({
		|e|
		var fr = e.use { ~freq.value },
		dur = e.use { ~dur.value};
        n.sendMsg("/sound", dur.asFloat*1000, 3.asFloat);
	})
);
Pbindef(\s4).stop;
Pbindef(\s4).quant = 4;
Pbindef(\s4).play;
)
