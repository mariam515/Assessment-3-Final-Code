
import processing.video.*;

Capture video;

void setup(){
   fullScreen();
 //size( 640, 400);
video = new Capture (this, width, height);
video.start();
background(0);

}

void captureEvent(Capture video){
video.read();

} 

void draw(){
 for (int i = 0; i <50; i++){
float x =random(width);
float y =random(height);
color c = video.get(int(x),int(y));
//fill(c, 25);
fill(c, 25);
noStroke();
ellipse(x,y,16,16);
 
}
}
