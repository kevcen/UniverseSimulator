class Planet {
 float radius, startAngle, angle, distance, orbitSpeed, spinSpeed, spinAngle, xMax, yMax, zMax;
 Planet[] children;
 PVector initialPos, rotateAxis;
 PShape globe;
 PlanetType type;
 
 
 Planet(float radius, float distance, PlanetType type) {
   // Initialise variables required for orbit
   initialPos = PVector.random3D();
   initialPos.mult(distance);
   rotateAxis = initialPos.cross(PVector.random3D());
   orbitSpeed = type == PlanetType.SUN ? 0 : random(-0.1, 0.1);
   spinSpeed = random(-0.05, 0.05);
   xMax = 1;
   yMax = 1;
   
   // Stats of the planet
   this.radius = radius;
   this.distance = distance;
   this.type = type;
   startAngle = random(TWO_PI);
   angle = startAngle;
   spinAngle = random(TWO_PI);
   
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
   if (level >= 2) return;
   
   children = new Planet[number];
   for (int i = 0; i < number; i++) {
     float r = radius / (2 * level);
     
     children[i] = new Planet(r, random(radius + r, 7*(radius + r)), PlanetType.values()[level]);
     
     children[i].spawnChildren(int(random(0, 3)), level + 1);
   }
    
 }
 
 void orbit() {
   angle += orbitSpeed;
   spinAngle += spinSpeed;
 }
 
 void transformScreen() {
   rotate(angle, rotateAxis.x, rotateAxis.y, rotateAxis.z);
   if (type != PlanetType.SUN && lines) drawLines();
   
   // Translate screen for children
   float distanceMultipler = sqrt(sq(yMax * cos(angle-startAngle)) + sq(xMax * sin(angle-startAngle)));
   initialPos.mult(distanceMultipler);
   translate(initialPos.x, initialPos.y, initialPos.z);
   initialPos.div(distanceMultipler);
   
   rotate(spinAngle, rotateAxis.x, rotateAxis.y, rotateAxis.z);
 }
 
 void drawLines() {
   pushMatrix();
   rotate(-angle, rotateAxis.x, rotateAxis.y, rotateAxis.z);
   
   PVector faceYou = new PVector(0,0,2000);
   PVector perp = faceYou.cross(rotateAxis);
   float rotAngle = PVector.angleBetween(rotateAxis, faceYou);
   
   //stroke(255,0,0); //red is facing you
   //line(0,0,0, faceYou.x, faceYou.y, faceYou.z);
   //stroke(255,0,255); // purple is rotation axis
   //line(0,0,0, rotateAxis.x * 100, rotateAxis.y * 100, rotateAxis.z * 100);
   //stroke(0,255,0); // green is perpendicular to face you and rot axis
   //line(0,0,0, perp.x * 100, perp.y * 100, perp.z * 100);
   
   stroke(255);
   rotate(rotAngle, perp.x, perp.y, perp.z);
   
   float radius = initialPos.mag();
   radius *= 2;
   println(startAngle + ", " + (angle % TWO_PI));
   dash.ellipse(0,0, xMax * radius, yMax * radius);
   popMatrix();
 }
 
 void drawPlanet() {
     noStroke();
     noFill();
     shape(globe);
 }
 
 void show() {
   pushMatrix();
   
   // Update position
   orbit();
   transformScreen();
   
   if (type == PlanetType.SUN) pointLight(255, 224, 145, 0,0,0);
   
   if (children != null) 
     for (int i = 0; i < children.length; i++)
       children[i].show();
   
   if (type != PlanetType.SUN) drawPlanet();
   
   popMatrix();
 }
 
}
