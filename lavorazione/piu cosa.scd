s.boot;
s.freeAll;
(
p = ProxySpace.push(s);
p.fadeTime = 2
)
~send = Bus.audio(s, 2);
~send.scope
{SinOsc.ar(440)!2}.play

// REVERB
(
SynthDef(\rev, {
	|in|
	var sig = In.ar(in, 2);
	sig = FreeVerb.ar(sig, mix:1, room: 0.9);
	Out.ar(0, sig!2);
}).add;
)

(
SynthDef(\carlo,  {
	|out|
	var sig = EnvGen.ar(Env.perc(0, 0.5), doneAction: 2) * SinOsc.ar(200);
	Out.ar(out, sig!2 * 0.2);
	Out.ar(0, sig!2);
}).add;
)
~carlo = Synth(\carlo, [\out, ~send]);
~figlio = Synth(\rev, [\in, ~send]);
~figlio.free
s.plotTree
{{ Decay.ar(Impulse.ar(0), 0.1) } * SinOsc.ar(1000)!2}.play