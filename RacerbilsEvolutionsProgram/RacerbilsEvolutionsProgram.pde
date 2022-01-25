//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int populationSize  = 100;     

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(500, 600);
  trackImage = loadImage("track.png");
  frameRate(10);
}

void draw() {
  clear();
  fill(255);
  rect(0, 50, 1000, 1000);
  image(trackImage, 0, 80);  

  carSystem.updateAndDisplay();

  if (frameCount%5==0) {

    for (int i = carSystem.CarControllerList.size()-1; i >= 0; i--) {
      SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
      if (s.whiteSensorFrameCount > 0) carSystem.EliminateCar(i);
    }
  }
}
