World w;

int numE;
PImage track;

boolean dead = false;

void setup() {
  size(1084, 684);
  numE = 2;
  w = new World(numE);
  track = loadImage("track.png");
}


void draw() {
  background(track);

  showBestNetwork();
  if (w.moverClones.size() < numE) {
    w.runSimulation();
  } else {
    w.moverSelection();
    w.moverMating();
  }
}

//void keyPressed() {
//  if (key == 'w') {
//    for (int i = 0; i < movers.size(); i++) {
//      mover m = movers.get(i);
//      PVector forward;
//      forward = PVector.fromAngle(radians(m.heading));
//      m.applyforce(forward);
//    }
//  } else if (key == 'a') {
//    for (int i = 0; i < movers.size(); i++) {
//      mover m = movers.get(i);
//      m.turn(-1);
//    }
//  } else if (key == 'd') {
//    for (int i = 0; i < movers.size(); i++) {
//      mover m = movers.get(i);
//      m.turn(1);
//    }
//  }
//}

void showBestNetwork() {

  pushMatrix();
  translate(width-301, 1);
  fill(0, 40);
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  rect(0, 0, 300, 150);

  NeuralNetwork NN = champions.get(champions.size()-1).NN;
  int numIn = 3;
  int numO = 1;
  int numL = NN.layers.size();
  for (int i = -1; i < numL+1; i++) { //for hvert lag
    int numN;
    if (i == -1) {
      numN = numIn;
    } else if (i == numL) {
      numN = numO;
    } else {
      Layer l = NN.layers.get(i);
      numN = l.neurons.size();
    }
    for (int j = 0; j < numN; j++) { // for hver neuron i laget
      fill(255, 0, 0);
      float y = map((30+30*j), 0, (30+30*(numN)), 0, 150);
      float x = map((50+50*i), 0, (50+50*(numL+1)), 30, 300);
      int numN2;
      if (i+1 >= 0 && i+1 < numL) {
        Layer l2 = NN.layers.get(i+1);
        numN2 = l2.neurons.size();
      } else if (i+1 == numL) {
        numN2 = numO;
      } else {
        numN2 = 0;
      }
      for (int k = 0; k < numN2; k++) { //for hver neuron i det næste lag
        float Cy = map((30+30*k), 0, (30+30*(numN2)), 0, 150);
        float Cx = map((50+50*(i+1)), 0, (50+50*(numL+1)), 30, 300);
        line(x, y, Cx, Cy);
      }
      ellipse(x, y, 20, 20); // tegn en neuron
    }
  }

  popMatrix();
}
