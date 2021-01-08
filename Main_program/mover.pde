class mover {

  PVector loc = new PVector(0, 0);
  PVector acc =  new PVector(0, 0);
  PVector vel = new PVector(0, 0);

  float heading = 0;
  float size;
  float turnForce = 10;
  float speed = 0.1;
  
  float fitness = 1;

  NeuralNetwork NN = new NeuralNetwork();
  mover(NeuralNetwork network, PVector pos, float s) {
    NN = network; 
    NN.addLayer(3, 6);
    NN.addLayer(6, 2); 

    loc.set(pos);
    size=s;
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(radians(heading));
    fill(255, 0, 0);
    stroke(255);
    strokeWeight(4);
    rectMode(CENTER);
    rect(0, 0, size*2, size);
    popMatrix();
  }
  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    vel.mult(0.983);
    vel.limit(2);
  }
  void applyforce(PVector f) {
    f.setMag(speed);
    acc.set(f);
    
  }
  void turn(int i) {
    heading += turnForce*i;
  }
}
