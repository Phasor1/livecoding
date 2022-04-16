#include "ofApp.h"
#include <iostream>

using namespace std;

//--------------------------------------------------------------
void ofApp::setup(){
	waves.setup();
	gr.setup();
	gr1.setup();
	gr2.setup();
	myFont.load("GzaRegular-Desktop.ttf", 32);
	images.setup();
}

//--------------------------------------------------------------
void ofApp::update(){
	waves.update();
	images.update(mouseX);
}

//--------------------------------------------------------------
void ofApp::draw(){
	ofBackground(0,0,0);
	gr.draw();
	gr1.draw();
	gr2.draw();
	waves.draw();
	images.draw();
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
