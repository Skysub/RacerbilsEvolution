class CarController {
  //Forbinder - Sensorer & Hjerne & Bil
  float varians; //hvor stor er variansen på de tilfældige vægte og bias
  boolean failure = false;
  int fitness = 0;
  Car bil;                    
  NeuralNetwork hjerne;       
  SensorSystem  sensorSystem;

  CarController(float v) {
    varians = v;
    bil = new Car();
    hjerne = new NeuralNetwork(varians); 
    sensorSystem = new SensorSystem();
  }

  void update() {
    //1.)opdtarer bil 
    bil.update();
    //2.)opdaterer sensorer    
    sensorSystem.updateSensorsignals(bil.pos, bil.vel);
    //3.)hjernen beregner hvor meget der skal drejes
    float turnAngle = 0;
    float x1 = int(sensorSystem.leftSensorSignal);
    float x2 = int(sensorSystem.frontSensorSignal);
    float x3 = int(sensorSystem.rightSensorSignal);    
    turnAngle = hjerne.getOutput(x1, x2, x3);    
    //4.)bilen drejes
    bil.turnCar(turnAngle);
    checkOutside();
    //if (fitness > 1)println(fitness);
  }

  void Fitness() {
    fitness = 0;
    if (failure) {
      fitness -= 100;
    }
    fitness += int(sensorSystem.getGreen());
    if (fitness < 0) fitness = 0;
  }

  CarController Crossover(CarController partner) {
    CarController child = new CarController(varians);
    child.SetNewBrain(hjerne.Crossover(partner.getHjerne()));
    return child;
  }

  void Mutate(float mutationRate, float mutA) {
    hjerne.Mutate(mutationRate, mutA);
  }

  void reset() {
    //bil = new Car();
    //sensorSystem = new SensorSystem();
    failure = false;
  }

  void display(boolean showSensors) {
    bil.displayCar();
    if (showSensors)sensorSystem.displaySensors();
  }

  boolean getFailure() {
    return failure;
  }

  int getFitness() {
    return fitness;
  }

  NeuralNetwork getHjerne() {
    return hjerne;
  }

  PVector getPos() {
    return bil.getPos();
  }

  void SetNewBrain(NeuralNetwork x) {
    hjerne = x;
  }

  void checkOutside() {
    if (frameCount%5==0) {
      if (sensorSystem.whiteSensorFrameCount > 0) failure = true;
    }
  }
}
