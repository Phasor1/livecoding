class Text {
  int posX = 10;
  int posY = 10;
  String txt; 
  Text() {
    txt = "";
  }
  void draw() {
    txt = txt.replace("\t", "     ");
    push();
    strokeWeight(2);
    textSize(10);
    stroke(200);
    text(txt, posX, posY);
    pop();
  }
}
