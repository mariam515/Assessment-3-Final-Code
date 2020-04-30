
//import java.util.Calendar;
import processing.sound.*;
import processing.video.*;

Capture video;   // camera
AudioIn input;   // sound 
Amplitude loudness;  // sound 

int cellsize = 3; 
int columns, rows; 


final float MAX_MIX = 1;
final float TRESH = 0.5;


void setup() {
  //fullScreen();
  //size(1280, 720,P3D);
 size(640,800);
  video = new Capture (this, width, height);
  video.start();
  background(0);
  
  columns = video.width / cellsize;
  rows = video.height / cellsize;
  background(0);
  input = new AudioIn(this, 1);
  input.start();
  loudness = new Amplitude(this);
  loudness.input(input);
    
  
}
 
void captureEvent(Capture video){
  video.read();
} 
 
 
void draw() {

  background(0);
  float volume = loudness.analyze();
  float size_ = map(volume, 0, 0.5, 1, width); // these ratio and very powerful in change to input
  println(size_);
 //volume, 0, 0.5, 1, width
 //0, 0.5, 1, 350
 //height*0.75
 // explode 
  for ( int i = 0; i < columns; i++) {
  
    for ( int j = 0; j < rows; j++) {
      int x = i*cellsize + cellsize/2;  
      int y = j*cellsize + cellsize/2;  
      int loc = x + y*video.width;  
      color c = video.pixels[loc];  
      // Calculate a z position as a function of mouseX and pixel brightness
      //float sz = (brightness(c) / 255.0) * cellsize;
      
      fill(255);
      noStroke();
      //rect(x + cellsize/2, y + cellsize/2, sz, sz);
      float sz = (size_ / float(width)) * brightness(video.pixels[loc] - 100); // this also change pixel size
      pushMatrix();
       //translate(x + 0, y + 0);
       fill(c, 204);
       noStroke();
       rectMode(CENTER);
       rect(x + cellsize/2, y + cellsize/2, sz, sz); // this is where the changes from above are rendered into the window
      popMatrix();
    }
  }
 


  int transparency = int(map(volume, 0, 100, 50, 100)); // these also have significant change of image

  
 // noise
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    color n = color(random(100), transparency);
    color c = pixels[i];
    color result = lerpColor(c, n, random(MAX_MIX));
    pixels[i] = transparency <= TRESH? result:c;
  }
 
 
  updatePixels();
 
} 
