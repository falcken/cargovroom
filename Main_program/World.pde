ArrayList<mover> movers = new ArrayList<mover>();
class World {
  int NumEntity;

  ArrayList<mover> moverClones;
  ArrayList<mover> matingPool;
  float mutationRate = 0.01;
  float moverSize = 15;
  PVector startPos = new PVector(width/2,height/2);

  
  
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
      m.getAngleMiddle();
    }
  }
  
   void moverSelection() {                             //Gør klar til reproduktion
    matingPool.clear();                               //fjern de gamle
    float maxFitness = getMoverMaxFitness();         //find den bedste

    for (int i = 0; i < moverClones.size(); i++) {                                   //for alle døde 
      float fitnessNormal = map(moverClones.get(i).fitness, 0, maxFitness, 0, 1);    //normaliser fitness
      int n = (int) (fitnessNormal*100);                                             
      for (int j = 0; j < n; j++) {                                                  //således vi kan havde en vægtet matingPool
         matingPool.add(moverClones.get(i));                                         //simulerer survival of the fittest
      }
    }
  }
    void moverMating() {                        //Fuktion til at finde en mor og en far og krydse deres værider samt muterer
    float tempWeight;

    for (int i = 0; i < numE; i++) {                 
      movers.add(new mover(new NeuralNetwork(), startPos, moverSize)); //først laver vi en tilfældig

      int m = int(random(matingPool.size()));          //finder forældre
      int d = int(random(matingPool.size()));

      mover mom = matingPool.get(m);                  
      mover dad = matingPool.get(d);

      for (int k = 0; k < mom.NN.layers.size(); k++) {     //for hvert lag
        FloatList momWeights = new FloatList();            //hent lav tre lister som vi kan gemme værdierne i
        FloatList dadWeights = new FloatList();   
        FloatList childWeights = new FloatList(); 


        momWeights = mom.NN.layers.get(k).layerWeights;          //hent mor og fars vægte
        dadWeights = dad.NN.layers.get(k).layerWeights;

        for (int j = 0; j < momWeights.size(); j++) {                          //for hver vægt i laget
          if (random(1) > 0.5)  tempWeight = momWeights.get(j);                //vælg enten en mor eller far vægt
          else                  tempWeight = dadWeights.get(j);
          if (random(1) < mutationRate) tempWeight += random(-0.1, 0.1);       //evt. muter den
          tempWeight = constrain(tempWeight, -1, 1);                           //Sørg for vi holder retningslinjerne
          childWeights.append(tempWeight);;                                    //gem den nye vægt i barnet
        }
          mover mov = movers.get(i);                                           //sæt den tidligere tilfældige movers lag til barnets vægte
        mov.NN.layers.get(k).setWeights(childWeights);                         
      }
    }
    moverClones.clear();                                                  //gør klar til næste omgang
  }
  
  float getMoverMaxFitness(){
    return 10;
  }

}
