s.boot
p = ProxySpace.push(s);

(
SynthDef(\m, {
	|out|
	var sig = EnvGen.ar(Env.perc(0, 1), doneAction: 2) * SinOsc.ar(200) * 0.5;
	Out.ar(out, sig!2);
}).add;
)
(
~p[0] = Pbind(
	\instrument, \m,
	\dur, 1,
)
)
~p.quant = 4;
~p[1] = \filter ->{|in| CombC.ar(in, 0.125, 0.25, 3)}
~p = nil
