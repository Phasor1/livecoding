/*******************************/
/************ SETUP ************/
/*******************************/

(
s.options.memSize = 8192 * 64;
s.boot;

p = ProxySpace.push(s);
p.fadeTime = 2;
p.clock = TempoClock.default;
// SAMPLES
Task({
	var beatsPath = PathName(thisProcess.nowExecutingPath.dirname ++ '\\beats').files;
	d = Dictionary.new;
	d.postln;
	3.wait;
	beatsPath = PathName(thisProcess.nowExecutingPath.dirname ++ '\\beats').files;
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
	("Synths.scd").loadRelative;
	("Ground.scd").loadRelative;
	3.wait;
}).start;
)
PathName("./").entries;
s.plotTree