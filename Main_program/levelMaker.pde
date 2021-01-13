class LevelMaker {
  boolean firstRender = true;
  boolean saving = false;
  boolean ready = false;
  
  LevelMaker() {
  }
  
  void render() {
    if (firstRender) {
      background(255);
      firstRender = false;
    }
    fill(0);
    rect(480, 50, 80, 80);
    paint();
    button();
    clickDetect();
  }
  
  void paint() {
    if (mousePressed) {
      fill(0);
      noStroke();
      if (!saving) {
        ellipse(mouseX, mouseY, 75, 75);
      }
    }
  }
  
  void button() {
    fill(0, 255, 0);
    stroke(0);
    rect(900, 25, 100, 50);
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
    mapId = millis();
    save("map-"+mapId+".png");
    println("Saved mapId: "+mapId+"!");
    ready = true;
  }
}
