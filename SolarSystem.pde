import peasy.*;

Planet[] suns;
PeasyCam cam;

PImage sunImg, moonImg, starsBg;
PShape bgSphere;
PImage[] planetImgs;
static final int NUM_OF_PLANETS = 4;
static final int NUM_OF_SUNS = 7;

void setup() {
  // TODO: Spin planets
  
 
  size(1000, 1000, P3D);
  
  starsBg = loadImage("img/2k_stars_2.jpg");
  bgSphere = createShape(SPHERE, 3000);
  bgSphere.setTexture(starsBg);
  sunImg = loadImage("img/2k_sun.jpg");
  moonImg = loadImage("img/2k_moon.jpg");
  planetImgs = new PImage[NUM_OF_PLANETS];
  planetImgs[0] = loadImage("img/2k_earth.jpg");
  planetImgs[1] = loadImage("img/2k_mars.jpg");
  planetImgs[2] = loadImage("img/2k_mercury.jpg");
  planetImgs[3] = loadImage("img/2k_jupiter.jpg");
  
  cam = new PeasyCam(this, 3000);
  
  suns = new Planet[NUM_OF_SUNS];
  
  for (int i = 0; i < suns.length; i++) {
    suns[i] = new Planet(30, 2000, PlanetType.SUN);
    suns[i].spawnChildren(7, 1);
  }
  
  lightFalloff(300, 300, 300);
}

void draw() {
  background(0);
  
  shape(bgSphere);
  //translate(width / 2, height / 2);
  
  for(Planet sun: suns)
    sun.show();
    
    
  // Draw the suns in bright light 
  ambientLight(255,255,255);
  for (Planet sun: suns) {
    pushMatrix();
    sun.transformScreen();
    sun.drawPlanet();
    popMatrix();
  }
    
}
