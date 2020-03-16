f = 2048;
j = NetAddr("192.168.1.1", 15200);
n = "/davide";


SynthDef(\features_and_onset_analyzer, {
	| inBus, rate=1 |
	var sig, fft;
	var freq, hasFreq, chroma, loud, flat;
	var onset;

	sig = In.ar(inBus);
	// sig.poll;

	fft = FFT(LocalBuf(f), sig);
	loud = Loudness.kr(fft);
	# freq, hasFreq = Pitch.kr(sig);
	flat = SpecFlatness.kr(fft);
	// chroma = Chromagram.kr(fft, ~fftWidth, tuningbase:55.0, integrationflag:0, perframenormalize:1);
	//amp = Amplitude.kr(sig);
	//centroid = SpecCentroid.kr(fft);

	SendReply.kr(Impulse.kr(rate),'/tr',
		[
			loud, freq, hasFreq, flat
			/*chroma[0], chroma[1], chroma[2],  chroma[3],
			chroma[4], chroma[5], chroma[6],  chroma[7],
			chroma[8], chroma[9], chroma[10], chroma[11]*/
		],
	replyID:0);

	onset = Onsets.kr(fft, threshold:0.3, odftype:'magsum');
	SendTrig.kr(onset, id:1, value:1);
}).add;

o = OSCFunc({
	|msg, time, addr, recvPort|
	var data, timestamp;

	switch( msg[2],
		0, {
			data = msg[3..];
			j.sendMsg( n ++ "/loud",    data[0]);
			j.sendMsg( n ++ "/freq",    data[1]);
			j.sendMsg( n ++ "/hasFreq", data[2]);
			j.sendMsg( n ++ "/flat",    data[3]);
/*			~jibPc.sendMsg(n ++"/A",  data[4] );
			~jibPc.sendMsg(n ++"/A#", data[5] );
			~jibPc.sendMsg(n ++"/B",  data[6] );
			~jibPc.sendMsg(n ++"/C",  data[7] );
			~jibPc.sendMsg(n ++"/C#", data[8] );
			~jibPc.sendMsg(n ++"/D",  data[9] );
			~jibPc.sendMsg(n ++"/D#", data[10]);
			~jibPc.sendMsg(n ++"/E",  data[11]);
			~jibPc.sendMsg(n ++"/F",  data[12]);
			~jibPc.sendMsg(n ++"/F#", data[13]);
			~jibPc.sendMsg(n ++"/G",  data[14]);
			~jibPc.sendMsg(n ++"/G#", data[15]);*/
			},
		1, {
			j.sendMsg(n ++ "/onset", 1);
			// ~jibPc.sendMsg(n ++"/onset", 0);
		},
		{
			"default".postln;
		}
	);
},'/tr', s.addr);
