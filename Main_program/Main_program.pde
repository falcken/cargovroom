World world;

int numE = 2;

void setup() {
  size(600, 600);

  world = new World(numE);
}


void draw() {
  background(0);
  world.runSimulation();
  
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
