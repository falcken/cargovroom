ArrayList<mover> movers = new ArrayList<mover>();
class World {
  int NumEntity;

  ArrayList<mover> moverClones;
  ArrayList<mover> matingPool;
  float mutationRate = 0.01;
  float moverSize = 20;
  PVector startPos = new PVector(width/2,height/2);
  FloatList newWeights = new FloatList(); // skal indeholde de nye vægte man vil havde sat i et nyt netværk
  
  
  World(int nE) {
    for (int i = 0; i < nE; i++) {
      movers.add(new mover(new NeuralNetwork(), startPos, moverSize));
    }
  }
  
    void runSimulation() {
    for (int j = 0; j < movers.size(); j++) {
      mover m = movers.get(j);
      m.show();
      m.update();
    }
  }
  
   void moverSelection() {                             //function to prepare the mating pool for reproduction
    matingPool.clear();                         //first we clear the old mating pool
    float maxFitness = getMoverMaxFitness();         //we determine who's the best creature of the generation

    for (int i = 0; i < moverClones.size(); i++) {                               //for every dead creature
      float fitnessNormal = map(moverClones.get(i).fitness, 0, maxFitness, 0, 1);    //we normalize the fitness score between 0 and 1
      int n = (int) (fitnessNormal*100);                                          //multiply it by 100
      for (int j = 0; j < n; j++) {                                               //and add the clone to the pool as many times as it deserves.
         matingPool.add(moverClones.get(i));                                //the better you are, the more chances you get to reproduce
      }
    }
  }
  
  float getMoverMaxFitness(){
    
    return 10;
  }

}
