s.boot
s.freeAll;
f = ServerOptions
f.memSize = 6565
(
p = ProxySpace.push(s);
p.fadeTime = 7;
p.clock = TempoClock.default;
p.clock.tempo = 1;
)

// BEAT
(
SynthDef(\beat, {
	|
	amp
	|
	var sig = PlayBuf.ar(2, Buffer.read(s, 'C:\\Users\\-Davide-\\Desktop\\livecoding\\beats\\clanksingle.wav'), doneAction: 2) * 0.2 * amp;
	Out.ar(0, sig!2);
}).add;
)
Env.perc(0.5, 0, 0.5, 0).plot()
c = [1/8, 1/8, 1/4, 1/4, 1/16, 1/6]
(
~pippo = Pbind(
	\instrument, \beat,
	\amp, 0,
	\dur, Pseq(c * 1.5, inf)
)
)

(
~sine1 = {SinOsc.ar(740,0,0.2)!2};
~sine3 = {SinOsc.ar(440,0,0.2)!2};
~modulation = {Saw.ar(10,0,1)!2};
~sine2 = {~sine1 * ~modulation * 0};
~sine2.play;
)


// DELAY EXAMPLE
(
{
	var sig = EnvGen.ar(Env.perc(0, 0.5, 0.5)) * VarSaw.ar(200),
	sig2 = EnvGen.ar(Env.perc(0, 0.5, 0.5).delay(0.02)) * VarSaw.ar(200);
	sig = CombN.ar(sig, 5, 0.2, 4);
	sig2 = CombN.ar(sig, 5, 0.2, 4);
	[sig, sig2] * EnvGen.kr(Env.linen(0, 5, 0), doneAction: Done.freeSelf);
}.play
)
s.plotTree;