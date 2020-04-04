import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class viz_3d extends PApplet {

Wave ws;
// Wave ws2;
Text t = new Text();
public void setup(){
	frameRate(50);
	
	ws = new Wave(50, 50, 100); 
	// ws2 = new Wave(50, 50, 50); 
}
public void draw(){
	background(0);
	ws.draw();
	// ws2.draw();
	t.draw();
}

public void mousePressed(){
	// ws.sounds = (Sound[])append(ws.sounds, new Sound(10, 200));
	ws.sounds.add(new Sound(30, 500));
}
class Sound{
	float freq;
	float dur;
	float amp = 30;
	float currAmp = 30;
	Sound(float f, float d){
		freq = f;
		dur = d;
	}
}
class Text{
	int posX = 10;
	int posY = 10;
	String txt = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, \n" + 
	"sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n" +
	"Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi \n" +
	"ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit \n" +
	"in voluptate velit esse cillum dolore eu fugiat nulla pariatur. \n" +
	"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui \n" +
	"officia deserunt mollit anim id est laborum.";
	public void draw(){
		push();
		strokeWeight(2);
		textSize(10);
		stroke(200);
		text(txt, posX, posY);
		pop();
	}
}
class Wave{
	int w = 700;
	int h = 700;
	int n_els = 70;
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
		sinInd = sinInd > 2*PI ? sinInd%(2*PI) : sinInd + 44100;
		translate(width/2, height/2);
		rotateX(1);
		rotateZ(rotInd);
		translate(-width/2, -height/2);
		noFill();
		strokeWeight(1);
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
				vertex(x*spX + wPosX, y*spX + wPosY, offz + wPosZ);
				// vertex(x*spX + wPosX, y*spX + wPosY, localSin1 + localSin2 + localSin3 + localSin4 + wPosZ);
			}
			endShape();
		}
		rotateZ(0);
		rotateX(-1);
		pop();
	}
}
  public void settings() { 	size(800, 800, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "viz_3d" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
