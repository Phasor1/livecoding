/*******************************/
/************ SETUP ************/
/*******************************/
s.boot
s.latency = 0.221;
(
s.options.memSize = 8192 * 256;
// s.options.inDevice_("MME : Microphone (Realtek(R) Audio)");
// s.options.outDevice_("MME : Speakers (Realtek(R) Audio");
s.waitForBoot({

/*	m = MandelHub.start("gigino");
	x = m.space;
	x[\scale] = Scale.minor;
	m.gui;*/
	s.meter;
	s.scope;
	s.sync;
	(
		// SAMPLES
		Task({
			var beatsPath = PathName(thisProcess.nowExecutingPath.dirname ++ '/samples').files;
			d = Dictionary.new;
			d.postln;
			3.wait;
			beatsPath = PathName(thisProcess.nowExecutingPath.dirname ++ '/samples').files;
			beatsPath.do({
				|el|
				var sampleFullp, sample, sampleSymbol;
				sampleFullp= el.asAbsolutePath;
				sample = sampleFullp.split($/);
				sample = sample[sample.size - 1];
				sampleSymbol = sample.replace(".wav", "").asSymbol;
				("loaded" + sample).postln;
				d.add(sampleSymbol -> Buffer.read(s, sampleFullp).bufnum);
			});
			d.postln;
			// ("snippets.scd").loadRelative;
			s.sync;
			("Synths.scd").loadRelative;
			s.sync;
			// ("RVVV_analysis.scd").loadRelative;
			// ("ground8.scd").loadRelative;
			// s.sync;
			// 1.wait;
			/*~src = Group.new;
			~fx = Group.after(~src);
			~fxBus = Bus.audio(s);
			Synth(\fx, [\in, ~fxBus.index], ~fx);*/
			// Synth(\rev, [\in, ~fxBus], ~fx);
			// a = Synth(\features_and_onset_analyzer, [\inBus, s.outputBus]);
		}).start;
	)
})
)

(
Pbindef(\k,
	\instrument, \metronome,
	\freq, Pseq([58, 50,50, 50]+0, inf).midicps,
	// \buf, Pseq([d[\Kick08]], inf),
	\dur, Pseq([
		// Pseq([1], 6),
		Pseq([1, 1, 1, 1], 8),
	], inf),
	\rate, Pseq([1], inf),
	\pan, 0,
	\amp, 0,
);
Pbindef(\k).stop.quant_([4, 0]).play();
)