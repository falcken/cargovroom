ArrayList<mover> movers = new ArrayList<mover>();
FloatList newWeights = new FloatList(); // skal indeholde de nye vægte man vil havde sat i et nyt netværk

class World {
  int NumEntity;

  World(int n) {
    NumEntity = n ; 
    for (int i = 0; i < NumEntity; i++) {
      movers.add(new mover(width/2, height/2, 20));
    }
  }



  void runSimulation() {
    for (int j = 0; j < movers.size(); j++) {
      mover m = movers.get(j);
      m.show();
      m.update();
    }
  }
}
