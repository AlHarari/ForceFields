class Particle {
  PVector pos, vel;
  PVector previousPos;

  Particle (PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    this.previousPos = pos;
  }

  void show() {
    stroke(0, 5);
    line(this.previousPos.x, this.previousPos.y, this.pos.x, this.pos.y);
    // used this to check if the code was working (it does work!)
    //stroke(255, 0, 0);
    //noFill();
    //circle(this.pos.x, this.pos.y, 10);
    //stroke(0, 255, 0);
    //circle(this.previousPos.x, this.previousPos.y, 10);
  }

  int findVectorInRegion() {
    int col = floor(this.pos.x / spacing);
    int row = floor(this.pos.y / spacing);
    return col * numOfRows + row;
  }

  void update(PVector vector) {
    this.vel.add(vector);
    this.vel.limit(20); // arbitrary amount
    this.previousPos = pos.copy();
    this.pos.add(vel);
  }
}
