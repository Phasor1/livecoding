// PROXY PBIND CREATION
(
i = PbindProxy();
i.set(\instrument, \sin);
// r = PbindProxy();
// r.set(\instrument, \rhythm);
)

(
i.set(\dur, Pseq([0.5, 0.7, 1], inf));
i.set(\freq, Pseq([70, 73, 80]), inf);
i.play;
)

// PROXY SPACE CREATION
(
p = ProxySpace(s);
p.fadeTime = 2;
p.play;
)
p.clear;

(
p[\mine] = Pbind(
	\instrument, \sin,
	\freq, Prand([70, 73, 77, 80, 83, 86, 89], inf),
	\dur, Prand([1, 2, 0.2], inf)
)
)
p[\mine2] = nil;
~notes = [70, 73, 77, 80, 83, 86, 89]
~notes = [80, 84, 87]
(
p[\mine2] = Pbind(
	\instrument, \saw,
	\freq, Pseq([70, 74, 77, 82], inf),
	\dur, Prand([0.2], inf)
);
)
p.clear()
d = Synth(\saw);
d.set(\sustain, 1)
p[\another] = Pbind(

)




// NEW PROXY SPACE
s.boot;s.options.memSize = 65536 * 10;
s.reboot;
s.freeAll;
(
p = ProxySpace.push(s);
p.clock = TempoClock.default;
p.clock.tempo = 2.0;
p.clock.tempo = 1;
p.fadeTime = 2;
)
s.meter;
(
SynthDef(\warsaw, {
	|freq, dur|
	var sig = VarSaw.ar(freq.midicps,width: 0.5, mul:0.3),
	env = EnvGen.ar(Env.linen(0.01, dur, 1.01, 0.7, 3),doneAction:2);
	env.postln;
	sig = sig * env;
	sig = BLowPass.ar(sig, env * 18000);
	Out.ar(0, sig!2);
}).add;


SynthDef(\sino, {
	|freq, dur|
	var sig = SinOsc.ar(freq.midicps, mul: 0.5),
	env = Env.linen(0.5, 1, 0.5);
	sig = sig * EnvGen.ar(env, doneAction: Done.freeSelf);
	Out.ar(0, sig!2);
}).add;


SynthDef(\pulse, {
	|freq, dur|
	var sig = Pulse.ar(freq.midicps, mul:0.5),
	env = Env.perc(0.001, 2, 0.5, -8);
	sig = sig * EnvGen.ar(env, doneAction: Done.freeSelf);
	sig = CombN.ar(sig, 4, 0.3, 4);
	sig = FreeVerb.ar(sig, room: 1,damp:1, mul: 1);
	Out.ar(0, sig!2);
}).add;
)
// NEW PBIND
Synth(\warsaw, [\freq,50,\dur, 0.2]);
Synth(\pulse, [\freq, 300, \duration, 2]);
(
~sound = Pbind(
	\instrument, \warsaw,
	\freq, Pseq(Scale.major.degrees.reverse + 36, inf),
	\dur, Pseq([10], inf)
);

~sound2 = Pbind(
	\instrument, \warsaw,
	\freq, Pseq(Scale.major.degrees.reverse + 48, inf),
	\dur, Pseq([3], inf)
);
~sound3 = Pbind(
	\instrument, \sino,
	\freq, Pseq(Scale.major.degrees.reverse + 40, inf),
	\dur, Pseq([0.2], inf)
);
)
// RHYTHM
(
// ~scale = Scale.major;
~mario = Pbind(
	\instrument, \pulse,
	\freq,Prand(Scale.major.degrees + 60, inf),
	\dur, Pseq([1], inf)
)
)
~giulio = Pbind(
	\instrument, \pulse,
	\freq,Prand(Scale.minor.degrees + 60, inf),
	\dur, Pseq([1], inf)
)
~mario.play;
p.clear();
~sound.stop;
~sound.clear();

[Scale.minor.degrees];

[Scale.minor.degrees] + 50


c = 0.1!8;
size(c);
c







































