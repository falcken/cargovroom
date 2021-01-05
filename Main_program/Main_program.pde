World w;

int numE;

void setup() {
  size(600, 600);
  numE = 2;
  w = new World(numE);
  
}


void draw() {
  background(0);
  w.runSimulation();
  
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
