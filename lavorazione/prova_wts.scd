m = 10;
(
t = Task({
	inf.do{
		m = m + 1;
		m.postln;
		1.wait;
	}
});
)
t.start;

b = Buffer.alloc(s, 2048);
(
e = Env(
	[0, 0.2, 0.3, -0.8, 0.5, -0.2, 0],
	[1],
	\sine
);
b.loadCollection((e.asSignal(1024)).asWavetable);
b.plot;
)

// FIRST VERSION OF WAVETABLE SYNTH
(
{
	var nPts = 10,
	sig = {},
	b = Buffer.alloc(s, 2048);
	e = Env(
		(({rrand(-1, 1)}!nPts) * [-1, 1]).scramble,
		exprand(1, 20)!nPts,
		rrand(-40, 40)!nPts
	);
	b.loadCollection((e.asSignal(1024)).asWavetable);
	b.plot;
	sig = Osc.ar(b, MouseX.kr(20, 1000))!2 * 0.5;
	// sig.plot;
	sig!2;
}.play;
)

(
{
	var sig = Signal.newClear(1024),
	bf = Buffer.alloc(s, 2048), wt;
	sig.waveFill({
		|x, old, i|
		var out;
		if(abs(sin(x)) < 0.2,{
			out = sin(x) + sin(20 * x)
		},{
			out = sin(x) + sin(5 * x);
		});
	}, 0, 2pi);
	wt = sig.asWavetable;
	bf.loadCollection(wt);
	Osc.ar(bf, 100)!2;
}.play;
)

(~mario = Pbind(
	\instrument, \waveTable2,
	\scale, Scale.major,
	\octave, 3,
	\degree, Pseq([0,1,2,3], inf),
	\dur, Pwhite(0.125, 1),
	\att, 0,
	\sus, 0,
	\dec, 1,
	\amp, 0.2,
	\out, 0
).play;)
~mario.stop;

var out = 0.9;
if(rrand(0, 100) > 90,{
	out = out.fold(-0.8, 0.8);
}, {});
out;
s.scope;