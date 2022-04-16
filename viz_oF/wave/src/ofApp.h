#pragma once

#include "ofMain.h"
#include "Wave.h"
#include "Gradients.h"
#include "Images.h"

class ofApp : public ofBaseApp{

	public:
		void setup();
		void update();
		void draw();

		void keyPressed(int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);
		void mouseEntered(int x, int y);
		void mouseExited(int x, int y);
		void windowResized(int w, int h);
		void dragEvent(ofDragInfo dragInfo);
		void gotMessage(ofMessage msg);

		int mouseX;

		Wave waves = Wave(1, 300, 30, 30);

		Gradients gr = Gradients(0, ofGetWidth());
		Gradients gr1 = Gradients(30, 50);
		Gradients gr2 = Gradients(50, 100);

		Images images = Images();

		ofTrueTypeFont myFont;
};
