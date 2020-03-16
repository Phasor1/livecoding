s.boot

(
{
	var sig = VarSaw.ar(400);
	// sig = CombC.ar(sig, 1, (SinOsc.ar(0.5)* MouseY.kr(0, 0.5)) + (0.006), 1);
	sig = CombC.ar(sig, 1, (SinOsc.ar(0.5)* MouseY.kr(0, 0.5)) + (0.006), 1);
	Out.ar(0, sig!2 * 0.08);
}.play
)
s.scope
s.meter;
{((SinOsc.ar(0.5)) * 0.25) + 0.25}.plot(3)