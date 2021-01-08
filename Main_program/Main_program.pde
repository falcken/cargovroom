World w;

int numE;
PImage track;

void setup() {
  size(1084, 684);
  numE = 2;
  w = new World(numE);
  track = loadImage("track.png");
}


void draw() {
  background(track);
  w.runSimulation();
  showBestNetwork();
}
void keyPressed() {
  if (key == 'w') {
    for (int i = 0; i < movers.size(); i++) {
      mover m = movers.get(i);
      PVector forward;
      forward = PVector.fromAngle(radians(m.heading));
      m.applyforce(forward);
    }
  } else if (key == 'a') {
    for (int i = 0; i < movers.size(); i++) {
      mover m = movers.get(i);
      m.turn(-1);
    }
  } else if (key == 'd') {
    for (int i = 0; i < movers.size(); i++) {
      mover m = movers.get(i);
      m.turn(1);
    }
  }
}

void showBestNetwork() {
  fill(0, 40);
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  rect(width-301, 1, 300, 150);
}
