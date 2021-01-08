class Layer {
  ArrayList<Neuron> neurons = new ArrayList<Neuron>();    //indeholder hvilke neuroner der er i lag
  FloatList layerWeights = new FloatList();               //Vægt og bias for et helt lag
  FloatList layerInputs = new FloatList(); 
  FloatList layerOutputs = new FloatList(); 

  Layer(int ConnectionNum, int NeuronNum) {
    for (int i = 0; i < NeuronNum; i++) {
      Neuron tempNeuron = new Neuron(ConnectionNum);                        //lav en neuron
      addNeuron(tempNeuron);                                                //gem den
      for (int j = 0; j < tempNeuron.connectionWeights.size(); j++) {        //for hver neuron hent dens vægte og bias
        layerWeights.append(tempNeuron.connectionWeights.get(j));
      }
    }
  }

  void addNeuron(Neuron n) {           //funktion til at tilføje en neuron
    neurons.add(n);
  }


  void setWeights(FloatList nW) {    //funktion til at sætte vægt og bias for et helt lag
    layerWeights.clear();            //først fjerner vi de gamle vægte


    for (int i= 0; i < nW.size(); i++) {     //for hver af de nye vægte 

      for (int j = 0; j < neurons.size(); j++) {    //for hver neuron i et lag   
        Neuron n = neurons.get(j);                 //fjerner vi dets vægt
        n.connectionWeights.clear();

        for (int k = 0; k < n.connections.size(); k++) { 
          Connection c = n.connections.get(k);        //for hver connection
          c.setWeight(nW.get(i));                     //sætter vi en ny vægt
          layerWeights.append(nW.get(i));             //og gemmer det i de to lister
          n.connectionWeights.append(nW.get(i));       
          i++;     // vi vokser intentionelt i her således vi kan logge en bias i samme for loop
        }
        n.setBias(nW.get(i));   // når alle vægte er gemt sætter vi en bias     
        layerWeights.append(nW.get(i));         //og gemmer den i listerne
        n.connectionWeights.append(nW.get(i));                                                    
        i++;
      }
    }
  }

  void setInputs(FloatList inputs) {
    layerInputs.clear();              //sæt inputs i et lag
    layerInputs = inputs.copy();
    println("layerinputs" + layerInputs);
  }
  void processInputsToOutputs() {       //lav inputs til outputs i et lag
    int neuronCount = neurons.size();

    if (neuronCount > 0) {                //check at der er en neuron til at tage input
      if (layerInputs.size() != neurons.get(0).connections.size()) {   // check at der er nok
        println("Error in Layer: processInputsToOutputs: The number of inputs do NOT match the number of Neuron connections in this layer " + neurons.get(0).connections.size()+ " " + layerInputs.size());
        exit();
      } else {
        layerOutputs.clear();
        for (int i=0; i<neuronCount; i++) {  // regn et output
          layerOutputs.append(neurons.get(i).getNeuronOutput(layerInputs));
        }
      }
    } else {
      println("Error in Layer: processInputsToOutputs: There are no Neurons in this layer");
      exit();
    }
  }
}
