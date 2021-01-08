class mover {

  PVector loc = new PVector(0, 0);
  PVector acc =  new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector mid = new PVector(width/2, height/2);
  PVector midmov = new PVector();
  PVector xaxes = new PVector(1, 0);

  float heading = 0;
  float size;
  float turnForce = 10;
  float speed = 0.4;
  float visionLength = 100;
  float angle, angle2, diff;
  float timer;
  float stoptimer;
  float totalright;
  float calfitness;


  float fitness;

  float dist1, dist2, dist3;

  boolean dead = false;

  NeuralNetwork NN = new NeuralNetwork();
  mover(NeuralNetwork network, PVector pos, float s) {
    NN = network;
    NN.addLayer(2, 2);
    NN.addLayer(2, 4);
    NN.addLayer(4, 2);

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
    this.eyes();
    popMatrix();
    fill(0);
    stroke(0);
    line(width/2, height/2, midmov.x+width/2, midmov.y+height/2);
    line(width/2, height/2, xaxes.x+width/2, xaxes.y+height/2);
    line(width/2, height/2, loc.x, loc.y);
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


  void eyes() {
    strokeWeight(1);
    PVector e1 = new PVector(1, 0);
    e1.mult(visionLength);
    line(0, 0, e1.x, e1.y);
    fill(0, 255, 0);

    // check walls
    for (int i = 0; i < visionLength; i++) {
      PVector e = new PVector(1, 0);
      float x = e.x*i;
      float y = e.y*i;
      int realX = int(screenX(x, y));
      int realY = int(screenY(x, y));
      color buffer = track.pixels[realY*width+realX];

      if (red(buffer) == red(color(255))) {
        fill(255, 0, 0);
        dist1 = i;
        break;
      } else {
        fill(0, 255, 0);
        dist1 = visionLength;
      }
      //println(realX, realY);
    }

    ellipse(e1.x, e1.y, 8, 8);
    fill(255);

    PVector e2 = new PVector(1, 0.75);
    e2.mult(visionLength);
    line(0, 0, e2.x, e2.y);
    fill(0, 255, 0);

    // check walls
    for (int i = 0; i < visionLength; i++) {
      PVector e = new PVector(1, 0.75);
      float x = e.x*i;
      float y = e.y*i;
      int realX = int(screenX(x, y));
      int realY = int(screenY(x, y));
      color buffer = track.pixels[realY*width+realX];

      if (red(buffer) == red(color(255))) {
        fill(255, 0, 0);
        dist2 = i;
        break;
      } else {
        fill(0, 255, 0);
        dist2 = visionLength;
      }
      //println(realX, realY);
    }

    ellipse(e2.x, e2.y, 8, 8);
    fill(255);

    PVector e3 = new PVector(1, -0.75);
    e3.mult(visionLength);
    line(0, 0, e3.x, e3.y);
    fill(0, 255, 0);

    for (int i = 0; i < visionLength; i++) {
      PVector e = new PVector(1, -0.75);
      float x = e.x*i;
      float y = e.y*i;
      int realX = int(screenX(x, y));
      int realY = int(screenY(x, y));
      color buffer = track.pixels[realY*width+realX];

      if (red(buffer) == red(color(255))) {
        fill(255, 0, 0);
        dist3 = i;
        break;
      } else {
        fill(0, 255, 0);
        dist3 = visionLength;
      }
      //println(realX, realY);
    }

    ellipse(e3.x, e3.y, 8, 8);
    fill(255);
     
    //println(dist1, dist2, dist3);
  }

  void getAngleMiddle() {
    midmov = PVector.sub(loc, mid);
    angle2 = angle;
    angle = atan2(xaxes.y-midmov.y, xaxes.x-midmov.x)+PI;
    diff = angle - angle2;
    if (diff > 5 || diff < -5) {
      //println(angle, angle2, diff);
    }
  }
  void dead() {
    if (dist1 == 0 || dist2 == 0 || dist3 == 0) {
      dead = true;
    }
  }
  void fitness() {
    timer = millis();
    if (diff < 0) {
      if (diff < 5 || diff > -5) {
        stoptimer = millis();
      }
    }
    if (diff > 0) {
      if (diff < 5 || diff > -5) {
        totalright = timer-stoptimer;
        calfitness = pow(totalright, 2);
        if (dead) {
          fitness = calfitness * 0.9;
        } else {
          fitness = calfitness;
        }
      }
    }
  }
}
