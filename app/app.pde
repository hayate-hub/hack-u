import ddf.minim.*;
import ddf.minim.effects.*;


int pattern = 0; //初期設定
//0：通常モード
//1：音声読み取りモード
//2：応援モード
int pattern_log = 0;

int frame_num = 61; //ピクチャー数+1に設定する
int speed = 1; //フレームスピード

String input_file = "./dist/vc_out/output.wav";




PImage bg;
PImage[] agent = new PImage[frame_num];

//クラス宣言


// 再生用
Minim minim;  //Minim型変数であるminimの宣言
AudioPlayer player;  //サウンドデータ格納用の変数



 
void setup(){
  
  size(1200, 900);
  minim = new Minim(this);  //初期化
  player = minim.loadFile(input_file); //wavファイルを指定する 
  
  bg = loadImage("background/bg_baseball_ground.jpg");
  
  for(int i = 0;  i < agent.length; i++){
    //agent[i] = loadImage("motion_draft/motion2_export00" + i + ".png");
    
    String num = nf(i, 3);
    agent[i] = loadImage("shinro_motion/remotion_shinro0" + num + ".png");
    
  }
}
 
void draw(){
  
  image(bg, 0, 0, 1200, 900);
  
  
  if(pattern_log == pattern){
    String[] pattern_txt = {str(pattern)};
    saveStrings("./pattern_out.txt", pattern_txt);
    pattern_log = pattern;
  }
  
  move(pattern);
  
  
}

void move(int _pattern){
  
  if(_pattern == 0){
    image(agent[0],300,50);
  }
  
  if(_pattern == 1){
    int frame =(frameCount/speed) % frame_num;
    image(agent[frame],300,50);
  }
  
}

void stop()
{
  player.close();  //サウンドデータを終了
  minim.stop();
  super.stop();
}

void mouseReleased(){
  
  player.play();
  println("Now playing...");
  pattern = 1;
  
}
