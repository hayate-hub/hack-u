import ddf.minim.*;
import ddf.minim.effects.*;


String pattern = "nomal"; //初期設定
//nomal：通常モード
//recode：音声読み取りモード
//move：応援モード
String pattern_log = "nomal";

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
  
  //pattern_out.txtの初期設定 0
  String[] pattern_txt = {pattern};
  saveStrings("./pattern_out.txt", pattern_txt);
  
  for(int i = 0;  i < agent.length; i++){
    //agent[i] = loadImage("motion_draft/motion2_export00" + i + ".png");
    
    String num = nf(i, 3);
    agent[i] = loadImage("shinro_motion/remotion_shinro0" + num + ".png");
    
  }
}
 
void draw(){
  
  image(bg, 0, 0, 1200, 900);
  
  
  if(pattern_log != pattern){
    println("doing");
    String[] pattern_txt = {pattern};
    saveStrings("./pattern_out.txt", pattern_txt);
    pattern_log = pattern;
  }
  
  move(pattern);
  
  
}

void move(String _pattern){
  
  if(_pattern == "nomal"){
    image(agent[0],300,50);
  }
  
  if(_pattern == "recode"){
    fill(0, 0, 100, 50);
    rect(0, 0, 1200, 900);
    image(agent[0],300,50);
  }
  
  if(_pattern == "move"){
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
  
  if(pattern == "nomal"){
     pattern = "recode";
  }else
  if(pattern == "recode"){
     player.play();
     pattern = "move";
  }else
  if(pattern == "move"){
     
  }
  
}

void keyReleased(){
  
}
