/*******************************/
/************ SETUP ************/
/*******************************/

(
s.options.memSize = 8192 * 128;
s.waitForBoot({
	n = NetAddr("192.168.1.5", 1337);
	m = MandelHub.start("gigino");
	x = m.space;
	x[\scale] = Scale.minor;
	m.gui;
	s.meter;
	s.scope;
	(
		// SAMPLES
		Task({
			var beatsPath = PathName(thisProcess.nowExecutingPath.dirname ++ '\\samples').files;
			d = Dictionary.new;
			d.postln;
			3.wait;
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
			// ("RVVV_analysis.scd").loadRelative;
			("ground5.scd").loadRelative;
			1.wait;
			// a = Synth(\features_and_onset_analyzer, [\inBus, s.outputBus]);
		}).start;
	)
})
)