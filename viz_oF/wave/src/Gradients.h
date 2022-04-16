#include "ofMain.h"
#include <iostream>

using namespace std;

class Gradients {
	public:
		ofMesh rect;
		float widthG;
		int startX = 0;
		int startY = 0;
		
		Gradients(float wg=40) {
			widthG = wg;
		}

		void setup() {
			rect.setMode(OF_PRIMITIVE_LINE_LOOP);
			rect.addVertex(ofVec3f(startX, startY, 0));
			rect.addColor(ofColor(255, 255, 0));
			rect.addVertex(ofVec3f(startX, startY+ofGetHeight(), 0));
			rect.addColor(ofColor(255, 255, 0));
			rect.addVertex(ofVec3f(startX+widthG, startY+ofGetHeight(), 0));
			rect.addColor(ofColor(0, 255, 255));
			rect.addVertex(ofVec3f(startX+widthG, startY, 0));
			rect.addColor(ofColor(0, 255, 255));
		}

		void draw() {
			rect.draw(OF_MESH_FILL);
		}
};