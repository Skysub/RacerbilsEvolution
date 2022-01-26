//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer //<>//
int populationSize  = 300;
int iterationTime = 25; //sekunder
Keyboard kb;
int iteration = 0, bestFit = 1;
boolean once = false;
int mutationRate = 20;
float mutationAmount = 0.2f;
ArrayList<CarController> matingPool;

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(500, 600);
  trackImage = loadImage("track.png");
  frameRate(30);
  kb = new Keyboard();
}

void draw() {
  clear();
  fill(255);
  rect(-5, 50, 1000, 1000);
  image(trackImage, 0, 100);  

  RunIteration();

  textSize(20);
  fill(255);
  text("Iteration: "+iteration, 5, 45);
  text("Best Fitness: "+bestFit, 250, 45);
  text("Time: "+int(millis()/1000f), 5, 20);
}



void RunIteration() {
  ArrayList<CarController> pop = carSystem.getPop();
  for (CarController x : pop) {
    x.Fitness();
  }
  if (millis() % 25000 == 0 && !once) {
    once = true;

    //Build mating pool
    matingPool = new ArrayList<CarController>();
    bestFit = 1;

    for (CarController x : pop) {
      if (x.getFitness() > bestFit) { 
        bestFit = x.getFitness();
      }
    }

    for (CarController x : pop) {
      int n = int((x.getFitness() / bestFit) * 100);
      for (int j = 0; j < n; j++) {
        matingPool.add(x);
      }
    }

    //Reproduce
    for (CarController x : pop) {
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      CarController partnerA = matingPool.get(a);
      CarController partnerB = matingPool.get(b);
      CarController child = partnerA.Crossover(partnerB);
      child.Mutate(mutationRate/1000f);
      population[i] = child;
    }
    carSystem.newIteration();
    iteration++;
  }
  if (millis() % 25000 != 0 && once)once = false;
  carSystem.updateAndDisplay(kb.getToggle(88));
}


void keyPressed() {
  HandleInput(keyCode, true);
}

void keyReleased() {
  HandleInput(keyCode, false);
} 

void HandleInput(int x, boolean y) {
  kb.setKey(x, y);

  //println(x);
  if (x==88) kb.Toggle(88);
}
