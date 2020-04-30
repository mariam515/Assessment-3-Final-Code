//import java.util.Calendar;
import processing.sound.*;
import processing.video.*;

Capture video;   // camera
AudioIn input;   // sound 
Amplitude loudness;  // sound 

int cellsize = 3; 
int columns, rows,cols; 
//int cols, rows;

final float MAX_MIX = 2;
//final float TRESH = 0.5;


void setup() {
  
  //size(1280, 720,P3D);
  size(700,600);
  video = new Capture (this,640,480);
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

    for ( int j = 0; j < rows; j++) {
      int x = cellsize + cellsize/4;  
      int y = j*cellsize + cellsize/4;  
      //int loc = x + y*video.width;  
      int loc = (video.width + x - 200) + y*video.width; 
      
      color c = video.pixels[loc];  
    
      
      //fill(255);
      noStroke();
      //rect(x + cellsize/2, y + cellsize/2, sz, sz);
      float sz = (size_ / float(width)) * brightness(video.pixels[loc] - 10); // this also change pixel size
      pushMatrix();
       translate(x + 0.5, y + 1);
       fill(c, 204);
       noStroke();
      // rectMode(CENTER);
       //rect(x + cellsize/2, y + cellsize/2, sz, sz); // this is where the changes from above are rendered into the window
      popMatrix();
  
      
        pushMatrix();
        translate(x+cellsize + cellsize/2, j*cellsize + cellsize/2);

        rotate((2 * PI * brightness(c) / 255.0));
    
        //noStroke(0);
        rectMode(CENTER);
        ellipse(200,0,cellsize + cellsize/2+1,j*cellsize + cellsize/2);
        rectMode(CENTER);
        rect(0,100,cellsize + cellsize/5+10,j*cellsize + cellsize/2);
        popMatrix();
      }
    }
  //}
 // }


  
  
  
  

  //int transparency = int(map(volume, 0, 1, 40, 100)); // these also have significant change of image

  
 // noise
  //loadPixels();
  //for (int i = 0; i < pixels.length; i++) {
   // color n = color(random(100), transparency);
   // color c = pixels[i];
   // color result = lerpColor(c, n, random(MAX_MIX));
   // pixels[i] = transparency <= TRESH? result:c;
  //}
 
 
 // updatePixels();
 
//} 
