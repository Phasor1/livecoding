#include "ofMain.h"
#include <iostream>

using namespace std;

class Gradients {
	public:
		ofMesh rect;
		float widthG;
		int startX = 0;
		int endX = 0;
		
		Gradients(int stx=0, int ex=10) {
			startX = stx;
			endX = ex;
			widthG = endX-startX;
		}

		void setup() {
			rect.setMode(OF_PRIMITIVE_LINES);
			for (int x = 0; x < widthG; ++x){
				rect.addVertex(ofVec3f(startX+x, 0,0));
				rect.addColor(ofColor(ofMap(x, 0, widthG, 255, 100), 100, ofMap(x, 0, widthG, 255, 100)));
				rect.addVertex(ofVec3f(startX+x, ofGetHeight(),0));
				rect.addColor(ofColor(ofMap(x, 0, widthG, 255, 100), 100, ofMap(x, 0, widthG, 255, 100)));
			}
		}

		void draw() {
			rect.draw();
		}
};