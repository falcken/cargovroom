class Layer {
  ArrayList<Neuron> neurons = new ArrayList<Neuron>();                                                   //indeholder hvilke neuroner der er i lag
  FloatList layerWeights = new FloatList();                                                             //Vægt og bias for et helt lag
  FloatList layerInputs = new FloatList(); 
  FloatList layerOutputs = new FloatList(); 

  void addNeuron(Neuron) {                                                                               //Function to add an input or output Neuron to this Layer
    neurons.append(Neuron);
  }


  void setWeights() {                                                                                    //function to set weights and bias for every neuron of the layer
    layerWeights.clear();                                                                                //first we clear the layerWeights array


    for (int i= 0; i < newWeights.length; i++) {                                                         //for every value of the temporary array...

      for (int j = 0; j < neurons.size(); j++) {                                                        //for every neuron of the layer...   
        Neuron n = neurons.get(j);                                                                            //we clear the neuron Weights array
        n.connectionWeights.clear();

        for (int k = 0; k < n.connections.size(); k++) { 
          Connection c = connections.get(k);                                                                       //for every connection of the neuron...
          n.c.setWeight(newWeights.get(i));                                                              //set the connection weights
          layerWeights.append(newWeights.get(i));                                                          //move the value into the layer weights array
          n.connectionWeights.append(newWeights.get(i));                                                  //move the value into the neuron weights array
          i++;                                                                                            // "i" must advance since the value has been already set
        }
        n.setBias(newWeights.get(i));                                                                     //once we've finished with the connection we set the neuron bias      
        layerWeights.append(newWeights.get(i));                                                              //and move value to the layer weights array
        n.connectionWeights.append(newWeights.get(i));                                                    //aswell to the neuron weights array
        i++;                                                                                              //once again "i" must advance to avoid reusing values
      }
    }
  }
  
    void setInputs(FloatList inputs) {
    layerInputs.clear();                                     //set inputs for this layer
    layerInputs = inputs;
  }
  void processInputsToOutputs() {                                                                       //process all the inputs to output for the neurons in this layer    
    int neuronCount = neurons.size();

    if (neuronCount > 0) {                                                                                //check if there are neurons to process inputs
      if (layerInputs.size() != neurons.get(0).getConnectionCount()) {                                      //check if num of inputs match num of neurons
        println("Error in Layer: processInputsToOutputs: The number of inputs do NOT match the number of Neuron connections in this layer");
        exit();
      } else {
        for (int i=0; i<neuronCount; i++) {                                                              //calculate layer outputs
          layerOutputs.append(neurons.get(i).getNeuronOutput(layerInputs);
        }
      }
    } else {
      println("Error in Layer: processInputsToOutputs: There are no Neurons in this layer");
      exit();
    }
  }
}
