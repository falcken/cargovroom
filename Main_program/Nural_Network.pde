//lav et NN
class NeuralNetwork {
  ArrayList<Layer> layers = new ArrayList<Layer>();  
  FloatList networkInputs = new FloatList(); 
  FloatList networkOutputs = new FloatList();         //Det neurale netværks output


  void addLayer(int ConnectionNum, int NeuronNum) {            //fuktion til at lave et nyt lag i netværket
    layers.add(new Layer(ConnectionNum, NeuronNum));
  }


  void setInputs(FloatList newInputs) {                         //funktion til at sætte inputs i et netværk
    networkInputs.clear();
    networkInputs = newInputs;
  }

  void setLayerInputs(FloatList newInputs, int layerIndex) {    //funktion til at sætte inputs i et netværk, i et specifikt lag
    if (layerIndex > layers.size()-1) {
      println("NN Error: setLayerInputs: layerIndex=" + layerIndex + " exceeded limits= " + (layers.size()-1));
    } else {
      layers.get(layerIndex).setInputs(newInputs);
    }
  }

  void setOutputs(FloatList newOutputs) {                 //funktion til at sætte outputs i et netværk
    networkOutputs = newOutputs;
  }


  void processInputsToOutputs(FloatList inputs) {              //funktion til at regne inputs til outputs i alle lag
    setInputs(inputs);

    if (layers.size() > 0) {                                      //tjek at nummeret af inputs passer til det neurale netværk
      if (networkInputs.size() != layers.get(0).neurons.get(0).connections.size()) {
        println("NN Error: processInputsToOutputs: The number of inputs do NOT match the NN");
        exit();
      } else {                                                            //nu hvor det passer
        for (int i = 0; i < layers.size(); i++) {                         //sætter vi inputs for hvert af lagene
          if (i==0) {
            setLayerInputs(networkInputs, i);                             //det første lag får sit input fra det input der kom til det neurale netværk fra moveren
          } else {
            setLayerInputs(layers.get(i-1).layerOutputs, i);              //de andre får fra de tidligere lag
          }
          layers.get(i).processInputsToOutputs();                         //når at et lag har fået sit input, regner vi et output
        }
        setOutputs(layers.get(layers.size()-1).layerOutputs);
      }
    } else {
      println("Error: There are no layers in this Neural Network");
      exit();
    }
  }
  
}
