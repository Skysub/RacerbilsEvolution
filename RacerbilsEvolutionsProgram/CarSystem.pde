class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser

  ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();

  CarSystem(int populationSize) {
    for (int i=0; i<populationSize; i++) { 
      CarController controller = new CarController();
      CarControllerList.add(controller);
    }
  }

  void updateAndDisplay(boolean showSensors) {
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
    //println(left);
  }

  void EliminateCar(int x) {
    CarControllerList.remove(x);
  }
}
