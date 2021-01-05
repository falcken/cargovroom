ArrayList<mover> movers = new ArrayList<mover>();

class World {
 int NumEntity;
  World(int n){
   NumEntity = n ; 
  }

void initializeWorld(){
  for (int i = 0; i < NumEntity; i++){
    movers.add(new mover(0, 0, 20));
  }
}

void runSimulation(){
    for (int i = 0; i < movers.size(); i++) {
    mover m = movers.get(i);
    m.show();
    m.update();
  }
}



}
