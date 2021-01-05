class Neuron {
  ArrayList<Connection> connections;
  FloatList connectionWeights = new FloatList();
  
  float bias = 1;
  
  Neuron(int connNumber){
  connections = new ArrayList<Connection>();
  
  for(int i; i < connNumber; i++){
    Connection conn = new Connection();
    addConnection(conn);
    float tempweight = conn.getWeight();
    
    connectionWeights.append(tempweight); 
  }
  connectionWeights.append(bias);
  
  }
  
  void addConnection(Connection c){
    connections.add(c);
  }
  /*void setBias(float tempBias){
    bias = tempBias;
  }*/
  
}
