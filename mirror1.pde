
 
import processing.video.*;

int cellSize = 20;

int cols, rows;

Capture video;


void setup() {
  fullScreen();
  //size(640, 480);
  frameRate(30);
  cols = width / cellSize;
  rows = height / cellSize;
  colorMode(RGB, 255, 255, 255, 100);

  video = new Capture(this, width, height);
  
  video.start();  
  
  background(0);
}


void draw() { 
  if (video.available()) {
    video.read();
    video.loadPixels();
  
   
    for (int i = 0; i < cols; i++) {
    
      for (int j = 0; j < rows; j++) {
      
    
        int x = i*cellSize;
        int y = j*cellSize;
        int loc = (video.width - x - 1) + y*video.width; 
      
        float r = red(video.pixels[loc]);
        float g = green(video.pixels[loc]);
        float b = blue(video.pixels[loc]);
       
        color c = color(r, g, b, 600);
      
        pushMatrix();
        translate(x+cellSize/3, y+cellSize/2);

        rotate((2 * PI * brightness(c) / 255.0));
        rectMode(RIGHT);
        fill(c);
        //noStroke(0);
        ellipse(0,0,cellSize+10,cellSize+10);
        rectMode(LEFT);
        rect(0, 0, cellSize+10, cellSize+10);
        popMatrix();
      }
    }
  }
}
