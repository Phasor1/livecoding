class Text {
  int posX = 10;
  int posY = 10;
  String txt = " "; 
  Text() {
    txt += "(\n" + 
"Pbindef(\\s2,\n" + 
    "\\instrument, \\sin,\n" + 
    "\\octave, 6,\n" + 
  "\\scale, Scale.minor,\n" + 
  "\\degree, Pseq([\n" + 
    "Pseq([0, 2, 3], 4),\n" + 
    "Pseq([6, 4, 5, 1], 1)\n" + 
  "], inf),\n" + 
    "\\dur, Pseq([1], inf),\n" + 
  "\\att, 0.01,\n" + 
  "\\sus, 0,\n" + 
  "\\dec, Pkey(\\dur),\n" + 
    "\\amp, 0.05\n" + 
"/*  \\msg, Pfunc({\n" + 
    "|e|\n" + 
    "var fr = e.use { ~freq.value },\n" + 
    "dur = e.use { ~dur.value};\n" + 
        "n.sendMsg(\"/sound\", 0.5.asFloat*1000, fr.asFloat);\n" + 
  "})*/\n" + 
");\n" + 
"Pbindef(\\s2).stop;\n" + 
"Pbindef(\\s2).quant = 4;\n" + 
"Pbindef(\\s2).play;\n" + 
")\n" + 

"\n" + "  (\n" + 
"SynthDef(\\sample, {\n" + 
  "|\n" + 
  "amp,\n" + 
  "buf,\n" + 
  "out,\n" + 
  "rate=1\n" + 
  "|\n" + 
  "var sig = PlayBuf.ar(2, buf, rate) * amp;\n" + 
  "sig = sig * EnvGen.ar(Env.linen(0.01, 4, 0.01), doneAction: 2);\n" + 
  "sig = sig + CombC.ar(sig, 4, 0.75, 4);\n" + 
  "Out.ar(out, sig!2);\n" + 
"}).add;\n" + 
")\n" + 

"\n" + "(\n" + 
"SynthDef(\\sin, {\n" + 
  "|freq, amp = 0, sus, dec=0.1, att, out|\n" + 
  "var sig = SinOsc.ar(freq);\n" + 
  "sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction: 2) * amp;\n" + 
  "sig = sig + CombC.ar(sig, 0.5, 0.25, 1);\n" + 
  "Out.ar(out, sig!2);\n" + 
"}).add;\n" + 
")\n" + 
"(\n" + 
"SynthDef(\\phsr, {\n" + 
  "|amp=0.5, freq=200, att=0.01, sus=0.5, dec=1, out|\n" + 
  "var sig = Silent.ar(1);\n" + 
  "[freq, freq * 2, freq * 3].do{\n" + 
    "|item, i|\n" + 
    "sig = sig + VarSaw.ar(item,0,1\n" + 
    ") * 1/(i + 1);\n" + 
  "};\n" + 
  "// sig = BLowPass.ar(sig, XLine.ar(10000, freq, att+sus+dec), 3);\n" + 
  "sig = BLowPass.ar(sig, SinOsc.ar(1/(att+sus+dec), 0, 100, 100 + freq), 3);\n" + 
  "sig = sig * EnvGen.ar(Env.linen(att, sus, dec), doneAction:2) * amp;\n" + 
  "Out.ar(out, sig!2);\n" + 
"}).add;\n" + 
")\n" + 

"\n" + "(\n" + 
"Pbindef(\\s3,\n" + 
    "\\instrument, \\phsr,\n" + 
    "\\octave, 3,\n" + 
  "\\scale, Scale.minor,\n" + 
  "\\degree, Pseq([\n" + 
    "Pseq([[0, 2, 4], [2, 4, 5], [4, 6, 8], [6, 8, 10]], inf),\n" + 
  "], inf),\n" + 
    "\\dur, Pseq([8], inf),\n" + 
  "\\att, 4,\n" + 
  "\\sus, 4,\n" + 
  "\\dec, 4,\n" + 
    "\\amp, 0.3\n" + 
"/*  \\msg, Pfunc({\n" + 
    "|e|\n" + 
    "var fr = e.use { ~freq.value },\n" + 
    "dur = e.use { ~dur.value};\n" + 
        "n.sendMsg(\"/sound\", 0.5.asFloat*1000, fr.asFloat);\n" + 
  "})*/\n" + 
");\n" + 
"Pbindef(\\s3).stop;\n" + 
"Pbindef(\\s3).quant = 4;\n" + 
"Pbindef(\\s3).play;\n" + 
")\n";
  }
  void draw() {
    push();
    strokeWeight(2);
    textSize(10);
    stroke(200);
    text(txt, posX, posY);
    pop();
  }
}
