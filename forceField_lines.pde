/**
 * Program name: Force Field
 * Purpose: To program a bunch of particles being affect by a "Perlin Noise force field".
 * Author: Ahmed Addous
 * Started on (DD/MM/YY): 4/6/22 at 8:05 PM
 * Credits to:
 Daniel Shiffman for his video on force fields, entitled 'Coding Challenge #24: Perlin Noise Flow Field' (YouTube).
 The code in this program is based on his, and its idea is pretty much similar to his program's idea. Also, the 
 examples provided by the Processing Foundation (with credit also going to whoever wrote them) were a helpful
 guideline on how writing Processing-related things work in Java.
 
 One idea that I think is cool is the ability to let the user "pour" the particles. 
 */

// Note: I'm stuck in Java because I'm an idiot...

int WIDTH = 1920, HEIGHT = 1080;
int spacing = 10;
int numOfCols = floor(WIDTH / spacing);
int numOfRows = floor(HEIGHT / spacing);

PVector[] vectors = new PVector[numOfRows * numOfCols]; 
int index; // used for indexing vectors array
Particle[] particles = new Particle[500];
Particle p;

float angle, xOffset, yOffset, zOffset;
float increment = 0.1; // directly taken from Daniel Shiffman's example at https://processing.org/examples/noise2d.html 
float zIncrement = 0.0003;

// apparently *size()* doesn't take variables as arguments in *setup()*?? 
void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {  
  background(255);
  PVector initialPos, initialVel;
  // setting up the *particles* array
  for (int i = 0; i < particles.length; i++) {
    initialPos = new PVector(random(0, width), random(0, height));
    initialVel = PVector.random2D();
    particles[i] = new Particle(initialPos, initialVel);
  }
}

void draw() {
  xOffset = 0; // reset xOffset dummy, dumb dum-dum
  // setting up and drawing the *vectors* array
  for (int i = 0; i < numOfCols; i++) {
    xOffset += increment;
    yOffset = 0;
    for (int j = 0; j < numOfRows; j++) {
      index = i * numOfRows + j;
      angle = noise(xOffset, yOffset, zOffset) * TWO_PI;
      pushMatrix();
      translate(i * spacing, j * spacing);
      vectors[index] = PVector.fromAngle(angle); 
      vectors[index].mult(10); // arbitrary value
      popMatrix();
      yOffset += increment;
    }
  }
  for (int i = 0; i < particles.length; i++) {
    p = particles[i];   
    // we're saying that if we repositioned the particles, the previous position must also be reset 
    if (p.pos.x > width) {
    // using *width*, or *height*, and 0 leads to a problem, so I offsetted it by 1 (pls don't come at me)
      p.pos.x = p.previousPos.x = 1;
    } else if (p.pos.x < 0) {
      p.pos.x = p.previousPos.x = width - 1;
    }
    if (p.pos.y > height) {
      p.pos.y = p.previousPos.y = 1;
    } else if (p.pos.y < 0) {
      p.pos.y = p.previousPos.y = height - 1;
    }
    // everytime a vector is passed through, multiply its strength by a factor of 10
    // p.update(vectors[p.findVectorInRegion()].mult(10));
    p.update(vectors[p.findVectorInRegion()]);
    p.show();
  }
  zOffset += zIncrement;
  record();
}
