/*
File that "exports" the sketch into an mp4 because to be honest I'm tired trying to manually save frames and THEN 
 join them as an image sequence.
 
 From: "Video-Export - Processing Tutorial" by 'tim rodenbröker creative coding' on YouTube (https://www.youtube.com/watch?v=T_pmYgWz1ow) 
 */

final String sketchName = getClass().getName() + hour() + "-" + minute() + "-" + second();

import com.hamoid.*;
VideoExport videoExport30;
//VideoExport videoExport60;

void record() {
  if (frameCount == 1) {
    videoExport30 = new VideoExport(this, sketchName + "-30" + ".mp4");
    videoExport30.setFrameRate(30);
    videoExport30.startMovie();
    
    //videoExport60 = new VideoExport(this, sketchName + "-60" + ".mp4");
    //videoExport60.setFrameRate(60);
    //videoExport60.startMovie();
  }
  videoExport30.saveFrame();
  //videoExport60.saveFrame();
}
