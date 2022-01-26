class CarController {
  //Forbinder - Sensorer & Hjerne & Bil
  float varians             = 2; //hvor stor er variansen på de tilfældige vægte og bias
  boolean failure = false;
  int fitness = 1;
  Car bil                    = new Car();
  NeuralNetwork hjerne       = new NeuralNetwork(varians); 
  SensorSystem  sensorSystem = new SensorSystem();

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
    if (failure) {
      fitness = 1;
      return;
    }
    fitness = int(sensorSystem.getGreen());
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

  void checkOutside() {
    if (frameCount%5==0) {
      if (sensorSystem.whiteSensorFrameCount > 0) failure = true;
    }
  }
}
