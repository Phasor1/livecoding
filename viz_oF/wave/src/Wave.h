#include "ofMain.h"
#include <iostream>
#include <math.h> 

using namespace std;

class Wave {
	public:
		int numWaves;
		int numPoints;
		float marginLeft;
		float marginTop;
		float tick;
		vector <ofMesh> meshes;
		float rotationIndex = 0;
		float pi = 3.14159265358979323846;

		float sinMaxA = 40;
		// int wave;

		// Wave(){}

		Wave(int nw, int np, float ml, float mt) {
			// wave = 0;
			numWaves = nw; 
			numPoints = np;
			marginLeft = ml;
			marginTop = mt;
			tick = (ofGetWidth() - (marginTop*2))/numPoints;
			cout << numWaves << " " << numPoints << " " << marginLeft << " " << marginTop << endl;
		}

		void setup() {
			for(int i = 0; i < numWaves; i++) {
				ofMesh currentMesh;
				currentMesh.setMode(OF_PRIMITIVE_POINTS);
				for(int x = 0; x < numPoints; x++) {
					for (int y = 0; y < numPoints; y++){
						currentMesh.addVertex(ofVec3f(marginLeft + (x*tick), marginTop + (y*tick), 4*i));
					}
				}
				meshes.push_back(currentMesh);
			}
		}

		void update() {
			float time = ofGetElapsedTimef();
			// rotationIndex = rotationIndex > pi ? rotationIndex/pi : rotationIndex + 0.002;
			rotationIndex = pi/2;
			for (int i = 0; i < numWaves; i++) {
				for (int ind = 0; ind < numPoints *numPoints; ind++){
					ofVec3f currV = meshes[i].getVertex(ind);
					// int currX = (int)(ind % numPoints);
					// int currY = (int)(ind / numPoints);
					currV.set(currV.x, currV.y, sin(((time*15) + (ind % numPoints))/4) * sinMaxA);
					meshes[i].setVertex(ind, currV);
				}
			}
		}

		void draw() {
			ofPushMatrix();
			ofTranslate(ofGetWidth()/2, ofGetHeight()/2, 0);
			ofRotateXRad(1);
			ofRotateZRad(rotationIndex);
			ofTranslate(-ofGetWidth()/2, -ofGetHeight()/2, 0);
			ofPushStyle();
			ofSetLineWidth(1);
			ofSetColor(255, 255, 255);
			ofFill();
			for(int i = 0; i < numWaves; i++) {
				meshes[i].draw();
			}
			ofPopStyle();
			ofPopMatrix();
		}
};