 
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

Wave ws;
// Wave ws2;
Text t = new Text();
void setup(){
	frameRate(50);
	size(1000, 1000, P3D);
	ws = new Wave(50, 50, 100); 
	oscP5 = new OscP5(this,1337);
}
void draw(){
	background(0);
	ws.draw();
	// ws2.draw();
	t.draw();
}

void mousePressed(){
	// ws.sounds = (Sound[])append(ws.sounds, new Sound(10, 200));
	ws.sounds.add(new Sound(30, 500));
}
void oscEvent(OscMessage theOscMessage) {
  println(theOscMessage.addrPattern());
  if(theOscMessage.checkAddrPattern("/sound")==true) {
      float dur = theOscMessage.get(0).floatValue();
      float freq = theOscMessage.get(1).floatValue();
      println(dur, freq);
      ws.sounds.add(new Sound(freq, dur));
  }
  /* print the address pattern and the typetag of the received OscMessage */
}
