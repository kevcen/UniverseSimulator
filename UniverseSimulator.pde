import garciadelcastillo.dashedlines.*;

import peasy.*;

Planet[] suns;
PeasyCam cam;
DashedLines dash;

PImage sunImg, moonImg, starsBg;
PShape bgSphere;
PImage[] planetImgs;
static final int NUM_OF_PLANETS = 4;
static final int NUM_OF_SUNS = 3;
boolean lines = false;

void setup() {
  dash = new DashedLines(this);
  dash.pattern(5, 30);
  size(1000, 1000, P3D);
  
  starsBg = loadImage("img/2k_stars.jpg");
  bgSphere = createShape(SPHERE, 3000);
  bgSphere.setTexture(starsBg);
  sunImg = loadImage("img/2k_sun.jpg");
  moonImg = loadImage("img/2k_moon.jpg");
  planetImgs = new PImage[NUM_OF_PLANETS];
  planetImgs[0] = loadImage("img/2k_earth.jpg");
  planetImgs[1] = loadImage("img/2k_mars.jpg");
  planetImgs[2] = loadImage("img/2k_mercury.jpg");
  planetImgs[3] = loadImage("img/2k_jupiter.jpg");
  
  cam = new PeasyCam(this, 500); //3000

  suns = new Planet[NUM_OF_SUNS];
  
  for (int i = 0; i < suns.length; i++) {
    suns[i] = new Planet(30, 1000, PlanetType.SUN); //1500
    suns[i].spawnChildren(3, 1);
  }
  
  lightFalloff(2000, 2000, 2000);
}

void draw() {
  background(0);
  shape(bgSphere);
  ambientLight(50, 50, 50);
  for(Planet sun: suns)
    sun.show();
    
    
  // Draw the suns in bright light 
  ambientLight(255, 224, 171);
  for (Planet sun: suns) {
    pushMatrix();
    sun.transformScreen();
    sun.drawPlanet();
    popMatrix();
  }
}


void keyPressed() {
  if (key == CODED && keyCode == UP) {
      lines = !lines;
  }
}
