class mover{
  PVector loc = new PVector(0,0);
  PVector acc =  new PVector(0,0);
  PVector vel = new PVector(0,0);
  
  float heading = 0;
  float size;
  float turnForce = 10;
  float speed = 0.05;
  
  mover(float x, float y, float s){
    loc.set(x,y);
    size=s;
  }
  
  void show(){
    pushMatrix();
    translate(loc.x,loc.y);
    rotate(radians(heading));
    fill(255,0,0);
    stroke(255);
    strokeWeight(4);
    rectMode(CENTER);
    rect(0,0,size*2,size);
    popMatrix();
    
  }
  void update(){
    vel.add(acc);
    loc.add(vel);
    vel.mult(0.983);
    vel.limit(2);
    
  }
  void applyforce(PVector f){
    f.setMag(speed);;
    acc.set(f);
  }
  void turn(int i){
    heading += turnForce*i;
  }
}
