s.boot;
(
{
	var sig = SinOsc.ar(200 + (SinOsc.ar(MouseX.kr(20, 10000)) * MouseY.kr(1, 400)).poll) * 0.5;
	sig!2
}.play;
)
s.meter;

(
b = Buffer.alloc(s, 2048);
e = Env(Array.rand(5, -0.9, 0.9), (5..1), {rrand(-30, 30)}!5);
~sig = e.asSignal(1024);
~sig.plot;
~wt = ~sig.asWavetable;
b.loadCollection(~wt);
)
s.scope

(
~sinwt = {
	|freq=70|
	var sig = Osc.ar(b, freq);
	sig!2;
}.play
)
~sinwt.stop;

(
~sig = Signal.newClear(1024);
~sig.waveFill({
	|x, old, i|
	var out;
	out = sin(x);
	out = out.cubed();
	// out;
}, 0, 2pi);
~sig.plot;
b.loadCollection(~sig.asWavetable);
// b.plot;
)
{(((Osc.ar(b, 200) * 2).fold(-1, 1) * (abs(SinOsc.ar(3, mul: 5)) + 1)) * 0.2)!2}.play;
{Osc.ar(b, 200)!2}.play;