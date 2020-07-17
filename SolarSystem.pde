import peasy.*;

Planet sun;

PeasyCam cam;

PImage sunImg;
PImage moonImg;
PImage[] planetImgs;
static final int NUM_OF_PLANETS = 4;

void setup() {
  // TODO: Spin planets
  
  // TODO: Stars background
  
  // TODO: Multiple solar systems
  size(600, 600, P3D);
  
  sunImg = loadImage("img/2k_sun.jpg");
  moonImg = loadImage("img/2k_moon.jpg");
  planetImgs = new PImage[NUM_OF_PLANETS];
  planetImgs[0] = loadImage("img/2k_earth.jpg");
  planetImgs[1] = loadImage("img/2k_mars.jpg");
  planetImgs[2] = loadImage("img/2k_mercury.jpg");
  planetImgs[3] = loadImage("img/2k_jupiter.jpg");
  
  cam = new PeasyCam(this, 500);
  sun = new Planet(30, 0, PlanetType.SUN);
  sun.spawnChildren(NUM_OF_PLANETS, 1);
}

void draw() {
  background(0);
  ambientLight(100,100,100,0,0,0);
  //translate(width / 2, height / 2);
  sun.show();
}
