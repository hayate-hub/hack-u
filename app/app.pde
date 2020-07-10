import ddf.minim.*;
import ddf.minim.effects.*;


PImage [] agent = new PImage[81];
int speed = 1;
int ms;
int reset_time = -30000;

//クラス宣言


// 再生用
Minim minim;  //Minim型変数であるminimの宣言
AudioPlayer player;  //サウンドデータ格納用の変数


 
void setup()
{
  size(600, 800);
  minim = new Minim(this);  //初期化
  player = minim.loadFile("wav/output.wav"); //wavファイルを指定する 
  
  for(int i = 0;  i < agent.length; i++){
  agent[i] = loadImage("motion2_export00"+ i +".png");
  }
}
 
void draw()
{
  background(255);
  ms=millis();
  
  if(ms - reset_time<30000){
    int frame =(frameCount/speed) % 81;
    image(agent[frame],0,0);
  }
}

void stop()
{
  player.close();  //サウンドデータを終了
  minim.stop();
  super.stop();
}

void keyReleased(){
  
  if ( key == 'p' ){
    
    player.play();
    println("Now playing...");
    reset_time = ms;
    
  }
}
