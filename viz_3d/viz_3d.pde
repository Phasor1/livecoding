import processing.opengl.*; 
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

ArrayList<Wave> ws;
// Wave ws2;
Text t = new Text();
float num = 1;
void setup(){
	frameRate(50);
  ws = new ArrayList<Wave>();
	size(1200, 1200, P3D);
  for(int x = 0; x < num; x++){
      ws.add(new Wave(0, 0, map(x, 0, num, 10, 200)));
  }
	oscP5 = new OscP5(this,1337);
}
void draw(){
	background(0);
	for(int x = 0; x < num; x++){
      ws.get(x).draw();
  }
	t.draw();
}

void mousePressed(){
	// ws.sounds = (Sound[])append(ws.sounds, new Sound(10, 200));
    for(int x = 0; x < num; x++){
        ws.get(x).sounds.add(new Sound(3, 500));
    }
	//ws.sounds.add(new Sound(3, 500));
}
void oscEvent(OscMessage theOscMessage) {
  println(theOscMessage.addrPattern());
  if(theOscMessage.checkAddrPattern("/sound")==true) {
      float dur = theOscMessage.get(0).floatValue();
      float freq = theOscMessage.get(1).floatValue();
      println(dur, freq);
      //ws.sounds.add(new Sound(freq, dur));
  }
  if(theOscMessage.checkAddrPattern("/text")==true) {
      String s = theOscMessage.get(0).stringValue();
      println();
      t.txt = s;
      //ws.sounds.add(new Sound(freq, dur));
  }
  /* print the address pattern and the typetag of the received OscMessage */
}
