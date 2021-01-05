ArrayList<mover> movers = new ArrayList<mover>();

void setup() {
  size(600, 600);

  movers.add(new mover(width/2, height/2, 20));
}

void draw() {
  background(0);
  for (int i = 0; i < movers.size(); i++) {
    mover m = movers.get(i);
    m.show();
    m.update();
  }
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
  } else if(key == 'd'){
       for (int i = 0; i < movers.size(); i++) {
      mover m = movers.get(i);
      m.turn(1);
    }
  }
}
