#include "ofMain.h"
#include <iostream>

using namespace std;

class Images {
	public:
		// ofMesh tears;
		ofImage myImage;
		float posX;
		float posY;

		Images() {
			posX = 0;
			posY = 0;
		}

		void setup() {
			myImage.load("tokyo_1.jpg");
			// tears.setMode(OF_PRIMITIVE_LINES);
			// for (int x = 0; x < myImage.getWidth(); x++){
			// 	tears.addVertex(ofVec3f(posX, 0,0));
			// 	tears.addColor(ofColor(0,0,0));
			// 	tears.addVertex(ofVec3f(posX, myImage.getHeight(),0));
			// 	tears.addColor(ofColor(0,0,0));
			// }
		}

		void update(int mouseX) {
			ofPixels pxs = myImage.getPixels();
			// cout <<  << endl;
			cout << to_string(pxs[ofGetAppPtr()->mouseX]) << endl;
		}

		void draw() {
			myImage.draw(0, 0);
		}
};