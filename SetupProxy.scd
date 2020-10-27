/*******************************/
/************ SETUP ************/
/*******************************/


s.options.memSize = 8192 * 128;
s.boot;
s.latency = 0;

m = MandelHub.start("gigino");

x = m.space;
x[\scale] = Scale.minor;
m.gui;
m.changeTempo(90/60);
p = ProxySpace.push(s);
p.fadeTime = 2;
(
// SAMPLES
Task({
	var beatsPath = PathName(thisProcess.nowExecutingPath.dirname ++ '\\samples').files;
	d = Dictionary.new;
	d.postln;
	s.sync;
	1.wait;
	beatsPath = PathName(thisProcess.nowExecutingPath.dirname ++ '\\samples').files;
	beatsPath.do({
		|el|
		var sampleFullp, sample, sampleSymbol;
		sampleFullp= el.asAbsolutePath;
		sample = sampleFullp.split($\\);
		sample = sample[sample.size - 1];
		sampleSymbol = sample.replace(".wav", "").asSymbol;
		("loaded" + sample).postln;
		d.add(sampleSymbol -> Buffer.read(s, sampleFullp).bufnum);
	});
	d.postln;
	("snippets.scd").loadRelative;
	("Synths.scd").loadRelative;
	("ground6.scd").loadRelative;
	3.wait;
}).start;
)

{SinOsc.ar(200)!2}.play;
s.scope