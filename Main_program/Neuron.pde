class Neuron {
  ArrayList<Connection> connections= new ArrayList<Connection>();;
  FloatList connectionWeights = new FloatList();

  float bias = 1;
  float neuronInput;
  float neuronOutput;

  Neuron(int connNumber) {
  

    for (int i = 0; i < connNumber; i++) {
      Connection conn = new Connection();
      addConnection(conn);
      float tempweight = conn.getWeight();

      connectionWeights.append(tempweight);
    }
    connectionWeights.append(bias);
  }

  void addConnection(Connection c) {
    connections.add(c);
  }
  void setBias(float tempBias) {
    bias = tempBias;
  }

  float getNeuronOutput(FloatList LI) {
    if (LI.size() != connections.size()) {
      exit();
    }
    neuronInput = 0;

    for (int i = 0; i < connections.size(); i++) {
      neuronInput += connections.get(i).calcConnOutput(LI.get(i));
    }
    neuronInput += bias;
    neuronOutput = ActivateValue(neuronInput);
    return neuronOutput;
  }

  float ActivateValue(float input) {
    float value = (2 / (1 + exp(-1 * (input * 2)))) -1;
    return value;
  }
}
