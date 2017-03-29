//Peinture numérique dynamique .

import processing.video.*;
// DECLARE A SPOUT OBJECT HERE
Spout spout;


Capture cam;
PGraphics pg;PImage photo;PImage imgMask;
float x, y,xx,yy;

void setup() {
  size(640, 480,P3D);
    photo  = loadImage("a (3).jpg");
    imgMask = loadImage("mask.jpg");
  frameRate(30);
  background(0);
  printArray(Capture.list());
 //   cam = new Capture(this, 160, 120);
cam = new Capture(this, 640, 480, Capture.list()[118], 30);
  cam.start();
  
  
    // CREATE A NEW SPOUT OBJECT HERE
 // spout = new Spout();

  // INITIALIZE A SPOUT SENDER HERE
 // spout.initSender("Spout Processing", width, height);
  colorMode(HSB, 100);
  
  photo.resize(640,480);
  pg = createGraphics(640, 480);
}
void captureEvent(Capture c) {
  c.read();
}

// Light tracking
void draw() {
frameRate(10);
 /*if(cam.available())*/ {
  

   cam.read();
    cam.loadPixels();
    float maxBri = 0;
    int theBrightPixel = 0;
    for(int i=0; i<cam.pixels.length; i++) {
      if(brightness(cam.pixels[i]) > maxBri && ( green(cam.pixels[i])<10 && blue(cam.pixels[i])<10  )) {
        maxBri = brightness(cam.pixels[i]);
        theBrightPixel = i;
      }
    }
    x = theBrightPixel % cam.width;
    y = theBrightPixel / cam.width;
      // Here we are moving 5% of the way to the mouse location each frame
  xx = lerp(xx, (int)x, 0.05);
  yy = lerp(yy, (int)y, 0.05);
   }
  hint(DISABLE_DEPTH_TEST);
  
//   


//image(cam, 0,0);
//set(0, height - cam.height, cam);
 
  pg.beginDraw(); 
  //pg.fill(#FF0000);
  pg.noStroke();
  pg.ellipse(xx+random(10), yy+random(10), 20, 20);
 pg.ellipse(xx+random(-10), yy+random(10), 5, 5);
pg.ellipse(xx+random(-10), yy+random(-110), 10, 10);
  pg.rect(xx,yy, 40, 20);
  pg.endDraw();
      
  // println(x+" "+y);

 //photo.mask(imgMask);

 photo.mask(pg);
   image(photo,0,0);
}

// Air draw
/*
void draw() {
  if(cam.available()) {
    cam.read();
    cam.loadPixels();
    loadPixels();
    for(int i=0; i<cam.pixels.length; i++) {
      if(brightness(cam.pixels[i]) > 200) {
        pixels[i] = color(255);
      }
    }
    updatePixels();
  }
}*/