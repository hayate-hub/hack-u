import ddf.minim.*;
import ddf.minim.effects.*;

// parameters
float DEPTH = 0.002;    // sec
float FREQUENCY = 5.0;  // Hz
float FS = 44100.0;

PImage [] agent = new PImage[81];
int speed = 1;
int ms;
int reset_time = -30000;

//クラス宣言
Sound sound;
Chara chara;
VibratoClass vibrato;

// 再生用
Minim minim;  //Minim型変数であるminimの宣言
AudioPlayer player;  //サウンドデータ格納用の変数


//　録音用
AudioInput in;
AudioRecorder recorder;



 
void setup()
{
  size(600, 800);
  minim = new Minim(this);  //初期化
  //player = minim.loadFile("../sample.mp3"); //mp3ファイルを指定する 
  //player.play();  //再生
  
  in = minim.getLineIn(Minim.STEREO, 512);
  
  recorder = minim.createRecorder(in, "myrecording.wav", true);
  for(int i = 0;  i < agent.length; i++){
  agent[i] = loadImage("motion2_export00"+ i +".png");
  }
}
 
void draw()
{
  background(255);
//  image(agent[51],0,0);
  ms=millis();
  if ( recorder.isRecording() )
    {
       fill(0);
      text("Currently recording...", 5, 15);
  
    }
    else
    {
      fill(0);
      text("Not recording.", 5, 15);
      
    }
  
  if(ms - reset_time<30000){
   int frame =(frameCount/speed) % 81;
  image(agent[frame],0,0);
  }
}

void stop()
{
  in.close();
  player.close();  //サウンドデータを終了
  minim.stop();
  super.stop();
}

void keyReleased()
{
  if(key == 'r')
  {
    if ( recorder.isRecording() )
    {
      recorder.endRecord();
    }
    else
    {
      recorder.beginRecord();
    }
  }
  if ( key == 's' )
  {
    recorder.save();
    println("Done saving.");
  }
  if ( key == 'p' )
  {
    player = minim.loadFile("myrecording.wav"); //wavファイルを指定する 
    //player.play();  //再生
    //player = minim.loadFile("../sample.mp3", 1024);
    vibrato = new VibratoClass(FS, DEPTH, FREQUENCY);
    player.addEffect(vibrato);
    player.play();
    println("Now playing...");
  reset_time = ms;

}
}
