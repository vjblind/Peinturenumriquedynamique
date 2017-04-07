//Peinture numérique dynamique .
import de.looksgood.ani.*;
import processing.video.*;
// DECLARE A SPOUT OBJECT HERE
Spout spout;


Capture cam;
PGraphics[] pg =new PGraphics[3];PImage[] photo=new PImage[2];PImage imgMask;
float x, y,xx,yy, tmx=xx,tmy=yy;
import controlP5.*;

ControlP5 cp5;
int myColor = color(0,0,0);

int lay = 0;

void setup() {
  size(640, 480,P3D);
  Ani.init(this);
  
    cp5 = new ControlP5(this);
  
  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  cp5.addSlider("lay")
     .setPosition(100,50)
     .setRange(0,2)
     ; 
  
    photo[0]  = loadImage("a (3).jpg");
    photo[1]  = loadImage("moonwalk.jpg");

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
  
  for(int i=0;i<2;i++)photo[i].resize(640,480);
  
  
  
  for(int i=0;i<3;i++){
    pg[i] = createGraphics(640, 480);
      pg[i].beginDraw();
      fill(250);
      ellipse (200,200,5,5);
      pg[i].endDraw();

  }
  
  
  
}
void captureEvent(Capture c) {
  c.read();
}

// Light tracking
void draw() {
frameRate(10);
 /*if(cam.available())*/  
  

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
// xx = lerp(xx, (int)x, 0.05);
// yy = lerp(yy, (int)y, 0.05);
  

    
  hint(DISABLE_DEPTH_TEST);
  
//   
   Ani.to(this, 2.0, "xx", mouseX, Ani.CIRC_OUT);
   Ani.to(this, 2.0, "yy", mouseY, Ani.CIRC_OUT); 

//image(cam, 0,0);
//set(0, height - cam.height, cam);
 if(lay<=1){
  pg[lay].beginDraw(); 
  //pg.fill(#FF0000);
  pg[lay].noStroke();
  
        PVector dir = PVector.sub(mx(), pmx());
      float magnitude = dir.mag();
 
  for(int i=0; i<10; i++)
  { 
   Ani.to(this, 2.0, "xx", mouseX, Ani.CIRC_OUT);
   Ani.to(this, 2.0, "yy", mouseY, Ani.CIRC_OUT); 
  
    pg[lay].ellipse(xx+random(2), yy+random(2), 30+(20-magnitude), 30+(20-magnitude));

}
 
  
 
 if(millis()%1000>900)
 {  
 tmx=xx;  tmy=yy;}  
 
 float squizz=random(10);
 for(int i=0; i<5; i++) pg[lay].ellipse(tmx,tmy+random(10)+(frameCount*10)%100, squizz,squizz);
 pg[lay].textSize(32);

 if(random(100) >70)  for(int i=0; i<2; i++) pg[lay].ellipse(xx+random(-40,10),yy+random(-40,10)+(frameCount*40)%random(200), 5, 5);
 if(random(700) >670)  for(int i=0; i<2; i++) pg[lay].text("°", xx+random(-100,100), yy+random(10), 30);  // Specify a z-axis value


  pg[lay].endDraw();}
  // println(x+" "+y);

 //photo.mask(imgMask);






 if(lay==2){
 pg[lay].beginDraw(); 

  
    pg[lay].fill(250-(frameCount)%250,250,250-(frameCount)%250);

  pg[lay].noStroke();
  
PVector dir = PVector.sub(mx(), pmx());
float magnitude = dir.mag();
 
  for(int i=0; i<5; i++)pg[lay].ellipse(xx+random(10), yy+random(10), 30+(20-magnitude), 30+(20-magnitude));
 
  
 
 if(millis()%1000>900)
 {  
 tmx=xx;  tmy=yy;} 
 for(int i=0; i<5; i++) pg[lay].ellipse(tmx,tmy+random(10)+(frameCount*10)%100, random(10), random(10));
 
 
 if(random(100) >70)  for(int i=0; i<2; i++) pg[lay].ellipse(xx+random(-40,10),yy+random(-40,10)+(frameCount*10)%100, 5, 5);

  pg[lay].endDraw();


 }




 
 photo[0].mask(pg[0]);
 photo[1].mask(pg[1]);
   image(photo[0],0,0);
   image(photo[1],0,0);
    image(pg[2], 0, 0);
}

int e =01;
void mouseWheel(MouseEvent event) {
    e += event.getCount();
    lay=abs(e)%3;
  println(e);}


     
    PVector mx() {
      return new PVector(mouseX, mouseY);
    }
     
    PVector pmx() {
      return new PVector(pmouseX, pmouseY);
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