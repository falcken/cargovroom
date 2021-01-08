class Connection {
  float input;  //den værdi der skal ganges på en vægten
  float weight; //den vægt der skal ganges på værdien
  float output; //den værdi der skal returneres

  Connection () {
    randomiseWeight();
  }

  Connection(float specificWeight) {       //funktion til at sætte en connection med en specifik vægt
    setWeight(specificWeight);
  }

  void setWeight(float theNewWeight) { //  funktion til at sætte vægt til en ny vægt.
    weight = theNewWeight;
    weight = constrain(weight, -1, 1); // sikre at væriden ikke overskrider grænserne
  }

  void randomiseWeight() {             //funktion til at sætte en tilfældig vægt
    setWeight(random(-1, 1));
  }

  float getWeight() {                   //funktion til at returnere vægt
    return weight;
  }
  float calcConnOutput(float i) {  //funktion til at returnere et output
    input = i;
    output = input * weight;
    return output;
  }
}
