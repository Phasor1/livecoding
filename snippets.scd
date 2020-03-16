// SYNTH DEFINITION
DDWSnippets.put("synthdef", "SynthDef(\##name##, {
	|freq, amp=0.5, att=0.01, sus=1, dec=0.1, out,|
    var sig = SinOsc.ar(freq);
	sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;
	Out.ar(out, sig!2);
}).add;");
// TASK
DDWSnippets.put("task", "m = 10;
(
~t = Task({
	inf.do{
        \"task\".postln;
		1.wait;
	}
});
)
~t.start;");
// SAMPLE PATTERN DEFINITION
DDWSnippets.put("sampleP", "
(
~s[0] = Pbind(
    \\instrument, \\sample,
    \\buf, d[\\##name##],
    \\rate, 1,
    \\dur, Pseq([1], inf),
    \\amp, 0
);
~s[1] = \\filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~s.play;
~s.quant = 4;");

// SYNTH PATTERN DEFINITION
DDWSnippets.put("synthP", "
(
~s[0] = Pbind(
    \\instrument, \\##name##,
    \\att, 0,
	\\sus, 0,
    \\dec, 1,
	\\octave, 2,
	\\scale, x[\\scale],
	\\degree, Pseq([1] , inf),
    \\dur, Pseq([1], inf),
    \\amp, 0
);
~s[1] = \\filter -> {
    |in|
    var sig = in;
    sig!2;
}
)
~s.play;
~s.quant = 4;");