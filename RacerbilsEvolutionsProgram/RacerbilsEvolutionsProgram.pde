//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer //<>// //<>// //<>//
int populationSize  = 500;
float varians = 2;
int iterationTime = 10; //sekunder
Keyboard kb;
int iteration = 0, bestFit = 0;
float mutationRate = 0.05, mutA = 0.05;
ArrayList<CarController> matingPool;
int timer = 0, maxFit = 0;

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize, varians);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(500, 600);
  trackImage = loadImage("track.png");
  frameRate(60);
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
  text("Max Fitness: "+bestFit, 170, 20); //ændrede variabelnavnet ret sent
  text("Time: "+int(millis()/1000f), 5, 20);
  text("Best Fitness: "+maxFit, 170, 45);
}



void RunIteration() {
  CarController[] pop = carSystem.getPop();
  for (CarController x : pop) {
    x.Fitness();
  }
  for (CarController x : pop) {
    if (x.getFitness() > bestFit) { 
      bestFit = x.getFitness();
    }
  }
  carSystem.updateAndDisplay(kb.getToggle(88));
  if (millis() > timer+iterationTime*1000) {
    timer = millis();
    if (bestFit > maxFit) maxFit = bestFit;
    
    //Build mating pool
    matingPool = new ArrayList<CarController>();
    bestFit = 1;



    for (CarController x : pop) {
      int n = int((x.getFitness() / bestFit) * 100);
      for (int j = 0; j < n; j++) {
        matingPool.add(x);
      }
    }

    //Reproduce
    for (int i = 0; i < pop.length; i++) {
      /*int a = int(random(matingPool.size()));
       int b = int(random(matingPool.size()));
       CarController partnerA = matingPool.get(a);
       CarController partnerB = matingPool.get(b);
       CarController child = partnerA.Crossover(partnerB);
       child.Mutate(mutationRate, varians);
       x = child;*/
      CarController child = matingPool.get(int(random(matingPool.size()))).newMe();
      child.Mutate(mutationRate, mutA);
      pop[i] = child;
    }
    carSystem.newIteration();
    iteration++;
  }
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
