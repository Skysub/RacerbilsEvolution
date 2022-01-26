class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser

  CarController[] CarControllerList;

  CarSystem(int populationSize, float varians) {
    CarControllerList = new CarController[populationSize];
    for (int i=0; i<populationSize; i++) { 
      CarController controller = new CarController(varians);
      CarControllerList[i] = controller;
    }
  }

  void updateAndDisplay(boolean showSensors) {
    println(CarControllerList[0].getPos());
    //1.) Opdaterer sensorer og bilpositioner
    for (CarController x : CarControllerList) {
      if (!x.getFailure()) x.update();
    }

    //2.) Tegner tilsidst - så sensorer kun ser banen og ikke andre biler!
    for (CarController x : CarControllerList) {
      if (!x.getFailure()) x.display(showSensors);
    }

    // hvor mange er der tilbage på banen?
    int left = 0;
    for (CarController x : CarControllerList) {
      if (!x.getFailure()) left++;
    }
    textSize(20);
    fill(255);
    text("Tilbage: "+left, 250, 20);

    //println(CarControllerList.get(10).getFitness());
  }


  CarController[] getPop() {
    return CarControllerList;
  }

  void newIteration() {
    for (CarController x : CarControllerList) {
      x.reset();
    }
  }
}
