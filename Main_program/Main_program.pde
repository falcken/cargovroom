World w;
LevelMaker levelMaker;
int generations = 0;

int numE;
int timer = 50;
float time;
int mapId;
float countstop = 0;
boolean firstLaunch = true;
int showingNum = 0;
PVector yaxes = new PVector(0, -10);
PVector yaxes2 = new PVector(0, -10);
  
PImage track;

void setup() {
  size(1084, 684);
  numE = 25;
  w = new World(numE);
  levelMaker = new LevelMaker();
  track = loadImage("track.png");
  yaxes.rotate(map(2.5, 0, PI, 0, 2*PI));
  yaxes2.rotate(map(PI, 0, PI, 0, 2*PI));
}


void draw() {
  time ++;
  if (firstLaunch) {
    levelMaker.render();
    if (levelMaker.ready) {
      loadMap();
    }
  } else {
    background(track);
    showInfo();

    if (w.moverClones.size() < numE) {
      w.runSimulation();
      if (w.movers.size() > 0) {
        if (w.movers.size() > showingNum) {
          mover m =   w.movers.get(showingNum);
          showNetwork(m);
        } else {
          showingNum = 0;
          mover m =   w.movers.get(showingNum);
          showNetwork(m);
        }
      }
    } else {
      background(track); 
      w.moverSelection();
      w.moverMating();
    }
  }
}

//void keyPressed() {
//  if (key == 'w') {
//    for (int i = 0; i < champions.size(); i++) {
//      mover m = champions.get(i);
//      PVector forward;
//      forward = PVector.fromAngle(radians(m.heading));

//      m.applyforce(forward, false);

//    }
//  } else if (key == 'a') {
//    for (int i = 0; i < champions.size(); i++) {
//      mover m = champions.get(i);
//      m.turn(-1);
//    }
//  } else if (key == 'd') {
//    for (int i = 0; i < champions.size(); i++) {
//      mover m = champions.get(i);
//      m.turn(1);
//    }
//  }
//}
void mousePressed() {
  float mX = mouseX;
  float mY = mouseY;
  if (w.movers.size() > 0) {
    for (int i = 0; i < w.movers.size(); i++) {
      mover m =   w.movers.get(i);
      if (mX >= m.loc.x-5 && mY >= m.loc.y-5 && mX <= m.loc.x + m.size*2+5 && mY <= m.loc.y + m.size+5) {
        showingNum = i;
      }
    }
  }
}

void showNetwork(mover m) {
  pushMatrix();
  translate(width-301, 1);
  fill(0, 40);
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  rect(0, 0, 300, 150);
  fill(255, 0, 0);
  rect(150, 170, 150, 50);
  fill(255);
  stroke(255);
  textSize(16);
  text("Kill Selected Car", 160, 200);





  NeuralNetwork NN = m.NN;
  int numIn = NN.networkInputs.size();
  int numL = NN.layers.size();
  for (int i = -1; i < numL; i++) { //for hvert lag
    int numN;
    if (i == -1) {
      numN = numIn;
    } else {
      Layer l = NN.layers.get(i);
      numN = l.neurons.size();
    }
    for (int j = 0; j < numN; j++) { // for hver neuron i laget
      fill(255, 0, 0);
      float y = map((30+30*j), 0, (30+30*(numN)), 0, 150);
      float x = map((50+50*i), 0, (50+50*(numL-1)), 30, 270);
      int numN2;
      if (i+1 >= 0 && i+1 < numL) {
        Layer l2 = NN.layers.get(i+1);
        numN2 = l2.neurons.size();
      } else {
        numN2 = 0;
      }
      for (int k = 0; k < numN2; k++) { //for hver neuron i det næste lag
        float Cy = map((30+30*k), 0, (30+30*(numN2)), 0, 150);
        float Cx = map((50+50*(i+1)), 0, (50+50*(numL-1)), 30, 270);
        float Weight;
        if (i == -1) {
          Weight = NN.layers.get(0).layerWeights.get(k);
        } else {
          Layer l = NN.layers.get(i);
          Neuron n = l.neurons.get(j);
          Weight = n.connectionWeights.get(k);
        }
        strokeWeight((map(Weight, -1, 1, 1, 4)));
        stroke(int(map(Weight, -1, 1, 59, 200)), 0, 0, int(map(Weight, -1, 1, 100, 500)));
        line(x, y, Cx, Cy);
      }

      fill(0, 255, 0);
      if (i == -1) {
        if (m.moverInputs.get(j) < m.visionLength) {
          fill(255, 0, 0);
        }
      } else {
        Layer l = NN.layers.get(i);
        Neuron n = l.neurons.get(j);
        if (n.neuronOutput < 0) {
          fill(255, 0, 0);
        }
      }
      strokeWeight(1);
      stroke(0);
      ellipse(x, y, 20, 20); // tegn en neuron
    }
  }
  popMatrix();
  stroke(0, 255, 0);
  m.selected = true;
  line(m.loc.x, m.loc.y, width-301, 150);

  for (int  i = 0; i < w.movers.size(); i++) {
    if ( i != showingNum) {
      w.movers.get(i).selected = false;
    }
  }
  if (mousePressed && mouseX >= (width-301+150) && mouseY >= 170 && mouseX <= (width-301+300) && mouseY <= 220) {
    if (time >= timer) {
      m.dead = true;
      time = 0;
    }
  }
}

void loadMap() {
  track = loadImage("map-"+mapId+".png");
  firstLaunch = false;
}

void showInfo() {
  noStroke();
  fill(255);
  rect(40, 40, 100, 50);
  fill(0);
  textAlign(LEFT);
  textSize(24);
  text("Generation: "+generations, 35, 50);
}
