// (
// Pbindef(\k,
// 	\instrument, \sample,
// 	\buf, d[\Kick12],
// 	\dur, Pseq([
// 		Pseq([4], 3),
// 		// Pseq([0.75].stutter(6), 1)
// 		// Pseq([0.75].stutter(4), 1),
// 		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
// 	], inf),
// 	\amp, 0,
// );
// Pbindef(\k).stop;
// Pbindef(\k).quant = 4;
// Pbindef(\k).play;
// )
// (
// Pbindef(\sn1,
// 	\instument, \sample,
// 	\buf, d[\Snare12],
// 	\dur, Pseq([
// 		Pseq([1], 1),
// 		// Pseq([1, 1, 0.25, 0.25, 0.5, 0.25, 0.25, 0.5], 2),
// 	], inf),
// 	\amp, 0,
// );
// Pbindef(\sn1).stop;
// Pbindef(\sn1).quant = 2;
// Pbindef(\sn1).play;
// )
// (
// Pbindef(\s1,
// 	\instrument, \bouncing,
// 	\octave, 4,
// 	\scale, Scale.minor,
// 	\root, 4,
// 	\degree, Pseq([
// 		/*Pseq([0,2,3,1,6].stutter(8), 1),*/
// 		Pseq([[0, 4],[2, 6],[3, 7],[1, 5],[6, 10]], 1)
// 	], inf),
// 	\ind, 4,
// 	\dur, Prand([8], inf),
// 	\att, 0.01,
// 	\sus, 0,
// 	\pan, Pwhite(-1, 1),
// 	\dec, Pkey(\dur),
// 	\amp, 0
// );
// Pbindef(\s1).stop;
// Pbindef(\s1).quant = 4;
// Pbindef(\s1).play;
// )
// (
// Pbindef(\s2,
// 	\instrument, \distortion,
// 	\octave, 5,
// 	\dist, 1,
// 	\scale, Scale.major,
// 	\root, 0,
// 	\degree, Pseq([
// 		Pseq([4,3,4,2,1], 2),
// 		// Pseq([[5,7,9], [6,8,10]], 2),
// 	], inf),
// 	\dur, Pseq([2], inf),
// 	\att, 0.01,
// 	\sus, 0,
// 	\dec, 2,
// 	\amp, 0
// );
// Pbindef(\s2).stop;
// Pbindef(\s2).quant = 4;
// Pbindef(\s2).play;
// )
//
// (
// Pbindef(\s3,
// 	\instrument, \vars,
// 	\octave, 5,
// 	\scale, Scale.major,
// 	\root, 0,
// 	\degree, Pseq([
// 		Pseq((4..11).stutter(1), 1)
// 	], inf),
// 	\ind, 7,
// 	\dur, Pseq([4], inf),
// 	\att, 0.01,
// 	\sus, 0,
// 	\dec, Pkey(\dur)*l.beatDur,
// 	\amp, 0.1
// );
// Pbindef(\s3).stop;
// Pbindef(\s3).quant = 4;
// Pbindef(\s3).play(l);
// )
// l.beatDur
// (
// Pbindef(\s4,
// 	\instrument, \ethereal,
// 	\octave,4,
// 	\scale, Scale.major,
// 	\root, 0,
// 	\degree, Pseq([
// 		Prand(([0,1,2,4,1,3]), 1).stutter(4),
// 	], inf),
// 	\dur, Prand([1], inf),
// 	\att, 0.01,
// 	\sus, 0,
// 	\dec, 16,
// 	\pan, Pwhite(-1, 1),
// 	\amp, 0
// );
// Pbindef(\s4).stop;
// Pbindef(\s4).quant = 4;
// Pbindef(\s4).play;
// )
// (
// Pbindef(\s5,
// 	\instrument, \flanger,
// 	\octave,4,
// 	\scale, Scale.major,
// 	\root, 0,
// 	\degree, Pseq([
// 		Pseq(([0, 7, 6, 7, 4, 6]), 1).stutter(4),
// 	], inf),
// 	\dur, 1,
// 	\amp, 0
// );
// Pbindef(\s5).stop;
// Pbindef(\s5).quant = 4;
// Pbindef(\s5).play;
// )
// (
// SynthDef(\noisee, {
// 	|dur, amp, freq|
// 	var sig = VarSaw.ar(freq, width: SinOsc.ar(1/3));
// 	sig = sig * EnvGen.ar(Env.linen(0.001, dur, 0.001), doneAction: 2)*amp;
// 	// sig = BLowPass4.ar(sig, SinOsc.ar(1/20, mul: freq, add: freq));
// 	Out.ar(Pan2.ar(SinOsc.ar(1)), sig!2);
// }).add;
// )
//
// (
// Pbindef(\k).stop;
// Pbindef(\s1).stop;
// Pbindef(\s2).stop;
// Pbindef(\s3).stop;
// )
//
// (
// Pbindef(\k).play;
// Pbindef(\s1).play;
// Pbindef(\s2).play;
// Pbindef(\s3).play;
// Pbindef(\s4).play;
// )