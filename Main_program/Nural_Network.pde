//lav et NN
class NeuralNetwork {
  ArrayList<Layer> layers = new ArrayList<Layer>();  
  FloatList networkInputs = new FloatList(); 
  FloatList networkOutputs = new FloatList();         //outputs of the neural net


  void addLayer(int ConnectionNum, int NeuronNum) {            //Function to add a Layer to the Neural Network
    layers.add(new Layer(ConnectionNum, NeuronNum));
  }


  void setInputs(FloatList newInputs) {                         //Function to set the inputs of the neural network
    networkInputs.clear();
    networkInputs = newInputs;
  }

  void setLayerInputs(FloatList newInputs, int layerIndex) {    //Function to set the inputs of a specific layer
    if (layerIndex > layers.size()-1) {
      println("NN Error: setLayerInputs: layerIndex=" + layerIndex + " exceeded limits= " + (layers.size()-1));
    } else {
      layers.get(layerIndex).setInputs(newInputs);
    }
  }

  void setOutputs(FloatList newOutputs) {                 //Function to set the outputs of the neural network
    networkOutputs = newOutputs;
  }


  void processInputsToOutputs(FloatList inputs) {              //function to process inputs to outputs using all the layers
    setInputs(inputs);

    if (layers.size() > 0) {                                      //make sure that the number ofinputs matches the neuron connections of the first layer
      if (networkInputs.size() != layers.get(0).neurons.get(0).connections.size()) {
        println("NN Error: processInputsToOutputs: The number of inputs do NOT match the NN");
        exit();
      } else {                                                            // number of inputs is fine
        for (int i = 0; i < layers.size(); i++) {                         //set inputs for the layers
          if (i==0) {
            setLayerInputs(networkInputs, i);                             //first layer get inputs from the NN
          } else {
            setLayerInputs(layers.get(i-1).layerOutputs, i);              //other layer get inputs from the previous one
          }
          layers.get(i).processInputsToOutputs();                         //once inputs have been set, convert them to outputs
        }
        setOutputs(layers.get(layers.size()-1).layerOutputs);
      }
    } else {
      println("Error: There are no layers in this Neural Network");
      exit();
    }
  }
  
}
