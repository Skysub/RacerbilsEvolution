class Car {  
  //Bil - indeholder position & hastighed & "tegning"
  PVector pos;
  PVector vel;

  Car() {
    pos  = new PVector(60, 232);
    vel  = new PVector(0, 5);
  }

  void turnCar(float turnAngle) {
    vel.rotate(turnAngle);
  }

  PVector getPos() {
    return pos;
  }

  void displayCar() {
    stroke(100);
    fill(100);
    ellipse(pos.x, pos.y, 10, 10);
  }

  void update() {
    pos.add(vel);
  }
}
