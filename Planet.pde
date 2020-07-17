class Planet {
 float radius, angle, distance, orbitSpeed;
 Planet[] children;
 PVector initialPos, rotateAxis;
 PShape globe;
 PlanetType type;
 
 Planet(float radius, float distance, PlanetType type) {
   initialPos = PVector.random3D();
   initialPos.mult(distance);
   rotateAxis = initialPos.cross(PVector.random3D());
   
   this.radius = radius;
   this.distance = distance;
   this.type = type;
   angle = random(TWO_PI);
   orbitSpeed = type == PlanetType.SUN ? 0 : random(-0.1, 0.1);
   
   noStroke();
   noFill();
   globe = createShape(SPHERE, radius);
   switch (type) {
     case SUN:
       globe.setTexture(sunImg);
       break;
     case PLANET:
       globe.setTexture(planetImgs[int(random(0, NUM_OF_PLANETS))]);
       break;
     case MOON:
       globe.setTexture(moonImg);
   }
 }
 
 void spawnChildren(int number, int level) {
   if (level >= 3) return;
   
   children = new Planet[number];
   for (int i = 0; i < number; i++) {
     float r = radius / (2 * level);
     
     children[i] = new Planet(r, random(radius + r, 2*(radius + r)), PlanetType.values()[level]);
     
     children[i].spawnChildren(int(random(0, 3)), level + 1);
   }
    
 }
 
 void orbit() {
   angle = angle + orbitSpeed;
   
   rotate(angle, rotateAxis.x, rotateAxis.y, rotateAxis.z);
   //drawLines();
   
   
   translate(initialPos.x, initialPos.y, initialPos.z);
 }
 
 void drawLines() {
   stroke(255);
   line(0, 0, 0, initialPos.x, initialPos.y, initialPos.z);
 }
 
 void show() {
   pushMatrix();
   if (type == PlanetType.SUN) pointLight(255, 202, 87,0,0,0);
   
   // Update position
   orbit();
   
   
   if (children != null) 
     for (int i = 0; i < children.length; i++)
       children[i].show();
   
   
   if (type == PlanetType.SUN) ambientLight(255,255,255);
   noStroke();
   shape(globe);
   
   popMatrix();
 }
 
}