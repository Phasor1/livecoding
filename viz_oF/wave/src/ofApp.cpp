#include "ofApp.h"
#include <iostream>

using namespace std;

//--------------------------------------------------------------
void ofApp::setup(){
	waves.setup();
	// gr.setup();
	myFont.load("GzaRegular-Desktop.ttf", 32);
}

//--------------------------------------------------------------
void ofApp::update(){
	waves.update();
}

//--------------------------------------------------------------
void ofApp::draw(){
	ofBackground(0,0,0);
	// gr.draw();
	waves.draw();
	myFont.drawString(to_string(ofGetFrameRate()), 10, 50);
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
