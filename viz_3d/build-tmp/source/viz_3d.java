import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class viz_3d extends PApplet {

 



OscP5 oscP5;
NetAddress myRemoteLocation;

ArrayList<Wave> ws;
// Wave ws2;
Text t = new Text();
float num = 1;
public void setup(){
	frameRate(50);
  ws = new ArrayList<Wave>();
	
  for(int x = 0; x < num; x++){
      ws.add(new Wave(0, 0, map(x, 0, num, 10, 200)));
  }
	oscP5 = new OscP5(this,1337);
}
public void draw(){
	background(0);
	for(int x = 0; x < num; x++){
      ws.get(x).draw();
  }
	t.draw();
}

public void mousePressed(){
	// ws.sounds = (Sound[])append(ws.sounds, new Sound(10, 200));
    for(int x = 0; x < num; x++){
        ws.get(x).sounds.add(new Sound(3, 500));
    }
	//ws.sounds.add(new Sound(3, 500));
}
public void oscEvent(OscMessage theOscMessage) {
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
class Sound{
	float freq;
	float dur;
	float amp = 10;
	float currAmp = 10;
	Sound(float f, float d){
		freq = f;
		dur = d;
	}
}
class Text {
  int posX = 10;
  int posY = 10;
  String txt; 
  Text() {
    txt = "";
  }
  public void draw() {
    txt = txt.replace("\t", "     ");
    push();
    strokeWeight(2);
    textSize(10);
    stroke(200);
    text(txt, posX, posY);
    pop();
  }
}
class Wave{
  int offT = 100;
	int w = width - offT;
	int h = width - offT;
	int n_els = 40;
	float spX = w / n_els;
	float wPosX;
	float wPosY;
	float wPosZ;
	float rotInd = 0;
	float sinInd = 0;
	float amp = 0;
	ArrayList<Sound> sounds;
	Wave(float x, float y, float z){
		wPosX = x;
		wPosY = y;
		wPosZ = z;
		sounds = new ArrayList<Sound>();
	}
	public void draw(){
		push();
		rotInd = rotInd > 2*PI ? rotInd%(2*PI) : rotInd + 0.005f;
		sinInd = sinInd > 2*PI ? sinInd%(2*PI) : sinInd + 405;
		translate((width/2), (height/2));
		rotateX(1);
		rotateZ(rotInd);
		translate((-width/2), (-height/2));
		noFill();
		strokeWeight(2);
		stroke(255);
		// amp = amp != 0 ? (amp < 0 ? 0 : amp - (amp / (200 / 50))) : 0;
		for(int s = 0; s < sounds.size(); s++){
  			Sound snd = sounds.get(s);
  			if(snd.currAmp <= 0){
				sounds.remove(s);
			}else{
				snd.currAmp -= snd.amp / (snd.dur/(1000 / 50));
			}
		}
		for(int x = 0; x < n_els; x++){
			beginShape(POINTS);
			for(int y = 0; y < n_els; y++){
				float offz = 0;
				for(int s = 0; s < sounds.size(); s++){
          			Sound snd = sounds.get(s);
					offz += snd.currAmp*sin(sinInd + map(y, 0, n_els, 0, (2*PI)*snd.freq)) + 
					snd.currAmp*sin(sinInd + map(x, 0, n_els, 0, (2*PI)*snd.freq));
				}
				// float localSin1 = amp*sin(sinInd + map(y, 0, n_els, 0, (2*PI)*30));
				// float localSin2 = amp*sin(sinInd + map(y, 0, n_els, 0, (2*PI)*2));
				// float localSin3 = amp*sin(sinInd + map(x, 0, n_els, 0, (2*PI)*30));
				// float localSin4 = amp*sin(sinInd + map(x, 0, n_els, 0, (2*PI)*2));
				vertex(x*spX + wPosX + (offT/2), y*spX + wPosY + (offT/2), offz + wPosZ);
				// vertex(x*spX + wPosX, y*spX + wPosY, localSin1 + localSin2 + localSin3 + localSin4 + wPosZ);
			}
			endShape();
		}
		//rotateZ(0);
		//rotateX(-1);
		pop();
	}
}
  public void settings() { 	size(1200, 1200, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "viz_3d" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
