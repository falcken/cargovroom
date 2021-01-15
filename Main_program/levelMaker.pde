class LevelMaker {
  boolean firstRender = true;
  boolean saving = false;
  boolean ready = false;
  
  LevelMaker() {
  }
  
  void render() {
    if (firstRender) {
      background(255);
      fill(255, 0, 0);
      rect(460, 270, 150, 150);
      fill(0);
      textAlign(CENTER);
      textSize(24);
      text("SAFEZONE", 535, 350);
      firstRender = false;
    }
    fill(0);
    rect(480, 50, 80, 80);
    fill(0, 255, 0);
    rect(518, 50, 4, 80);
    paint();
    button();
    clickDetect();
  }
  
  void paint() {
    if (mousePressed) {
      fill(0);
      noStroke();
      if (mouseX > 460-37 && mouseX < 610+37 && mouseY > 280-37 && mouseY < 430+37) {
        println("safezone");
      } else if (!saving) {
        ellipse(mouseX, mouseY, 75, 75);
      }
    }
  }
  
  void button() {
    fill(0, 255, 0);
    stroke(0);
    rect(900, 25, 100, 50);
    pushMatrix();
      fill(0);
      translate(900+50, 25+25);
      textAlign(CENTER);
      textSize(32);
      text("Start!", 0, 10);
      popMatrix();
  }
  
  void clickDetect() {
    if (mousePressed) {
      if (mouseX > 900 && mouseX < 1000 && mouseY > 25 && mouseY < 75) {
        saving = true;
        saveMap();
      }
    }
  }
  
  void saveMap() {
    fill(255);
    noStroke();
    rect(900, 0, 120, 100);
    rect(460, 270, 151, 151);
    mapId = millis();
    newtime = mapId;
    save("map-"+mapId+".png");
    println("Saved mapId: "+mapId+"!");
    ready = true;
  }
}
