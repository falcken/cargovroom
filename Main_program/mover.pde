class mover {

  PVector loc = new PVector(0, 0);
  PVector acc =  new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector mid = new PVector(475, 80);
  PVector midmov = new PVector();
  PVector xaxes = new PVector(1, 0);

  float heading = 0;
  float size;

  float turnForce = 5;
  float speed = 4;
  float lowSpeed = 0.5;
  float visionLength = 50;
  float angle, angle2, diff;
  float difftotal = 0;
  float timer;
  float wait;
  float speedtimer;
  float lasttime = 0;
  float timearound = 0;
  float besttime = 3600000;
  float count = 0;
  float stoptimer = 0;
  float wrongtimer;
  float totalright;
  float calfitness;
  FloatList moverInputs = new FloatList();

  boolean dead = false;
  boolean passed = false;
  boolean selected = false;
  float fitness = 1;
  float dist1, dist2, dist3;
  
  

  NeuralNetwork NN = new NeuralNetwork();
  mover(NeuralNetwork network, PVector pos, float s) {
    NN = network;
    NN.addLayer(4, 8);
    NN.addLayer(8, 4);
    NN.addLayer(4, 2);

    loc.set(pos);
    size=s;
  }

  void show() {
    
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(radians(heading));
    if (selected){
      fill(0,255,0);
    }else{
      fill(255,0,0);
    }
    
    stroke(255);
    strokeWeight(4);
    rectMode(CENTER);
    rect(0, 0, size*2, size);
    this.eyes();
    popMatrix();
    fill(0);
    stroke(0);
    line(width/2, height/2, midmov.x+475, midmov.y+80);
    line(width/2, height/2, xaxes.x+width/2, xaxes.y+height/2);
    line(width/2, height/2, loc.x, loc.y);
  }
  void update() {
    drive();
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    vel.mult(0.983);
    vel.limit(2);
  }
  void applyforce(PVector f, boolean a) {
    if (a){
    f.setMag(speed);
    } else{
      f.setMag(lowSpeed);
    }
    acc.set(f);
  }
  void turn(int i) {
    heading += turnForce*i;
  }


  void eyes() {
    strokeWeight(1);
    PVector e1 = new PVector(1.5, 0);
    e1.mult(visionLength);
    line(0, 0, e1.x, e1.y);
    fill(0, 255, 0);

    // check walls
    for (int i = 0; i < visionLength; i++) {
      color buffer;
      PVector e = new PVector(1.5, 0);
      float x = e.x*i;
      float y = e.y*i;
      int realX = int(screenX(x, y));
      int realY = int(screenY(x, y));
      if (realX < width && realY < height && realY > 0) {
        buffer = track.pixels[realY*width+realX];
      } else {
        buffer = color(255, 255, 255);
      }

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
      color buffer;
      PVector e = new PVector(1, 0.75);
      float x = e.x*i;
      float y = e.y*i;
      int realX = int(screenX(x, y));
      int realY = int(screenY(x, y));
      if (realX < width && realY < height && realY > 0) {
        buffer = track.pixels[realY*width+realX];
      } else {
        buffer = color(255, 255, 255);
      }
      
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
      color buffer;
      PVector e = new PVector(1, -0.75);
      float x = e.x*i;
      float y = e.y*i;
      int realX = int(screenX(x, y));
      int realY = int(screenY(x, y));
      if (realX < width && realY < height && realY > 0) {
        buffer = track.pixels[realY*width+realX];
      } else {
        buffer = color(255, 255, 255);
      }
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
  }

  void getAngleMiddle() {
    midmov = PVector.sub(loc, mid);
    angle2 = angle;
    angle = atan2(xaxes.y-midmov.y, xaxes.x-midmov.x)+PI;
    diff = angle - angle2;

    if (diff > 1 || diff < -1) {
      //println(angle, angle2, diff);
    }
  }
  void speedLap(){
    speedtimer = millis();
    
    if(angle2 != 0){
    difftotal += diff;
    //println("difftotal: "+difftotal+" diff: "+ diff);
    //println(angle);
    }
    
    if (angle > 2.7 && angle < 3.0){
      if (wait + 2000 < speedtimer){
      
      timearound = speedtimer - lasttime;
      lasttime = speedtimer;
      wait = millis();
      
      if (timearound < besttime){
        besttime = timearound;
        
        }
        count++;
        
        if (count > 2){
          passed = true;
      }
      
      println("tid :"+timearound+"timer :"+ speedtimer+"lasttime :"+lasttime+ "   "+ count);
      }
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
      if (diff < 1 && diff > -1) {
        stoptimer = totalright;
        wrongtimer = timer - stoptimer;
      }
    } else {
      stoptimer = wrongtimer;
    }
    if (diff > 0) {
      if (diff < 1 && diff > -1) {
        totalright = timer-stoptimer;
        calfitness = pow(totalright, 2);
        if (dead) {
          fitness = calfitness * (1/besttime) * 0.9;
        } else {
          fitness = calfitness * (1/besttime);
        }
      }
    }
    //println(timer, wrongtimer, stoptimer, totalright);
  }

  void drive() {
    moverInputs.clear();
    moverInputs.append(dist2);
    moverInputs.append(dist1);
    moverInputs.append(dist3);
    moverInputs.append(vel.mag());

    NN.processInputsToOutputs(moverInputs);                                          
    if (NN.networkOutputs.get(0) > 0.5) {
      turn(-1);
    } else if (NN.networkOutputs.get(0) < -0.5) {
      turn(1);
    } 
    if (NN.networkOutputs.get(1) > 0) {
      PVector forward;
      forward = PVector.fromAngle(radians(heading));
      applyforce(forward, true);
    } else if (NN.networkOutputs.get(1) <= 0) {
      PVector forward;
      forward = PVector.fromAngle(radians(heading));
      applyforce(forward, false);
    }
  }
}
