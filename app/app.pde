import ddf.minim.*;
import ddf.minim.effects.*;


String pattern = "nomal"; //初期設定
//nomal：通常モード
//recode：音声読み取りモード
//move：応援モード
String pattern_log = "nomal";

//shinroくん画像path
String shinro_nomal_path = "shinro_remotion/remotion_shinro";
String shinro_up_path = "shinro_remotion_up/remotion_shinro_up";
String shinro_down_path = "shinro_remotion_down/remotion_shinro_down";


int frame_num = 121; //ピクチャー数+1に設定する
int speed = 1; //フレームスピード

int effect_alf = 11;
boolean effect_alf_bool = true;

String input_wav_path = "./dist/vc_out/output.wav";
String up_preset_wav_path = "preset_voice/up_state.wav";
String up_env_wav_path = "preset_voice/up_env.wav";
String down_preset_wav_path = "preset_voice/down_state.wav";
String down_env_wav_path = "preset_voice/down_env.wav";

PImage nomal_state_shinro;
PImage bg;
PImage[] agent = new PImage[frame_num];

//クラス宣言


// 再生用
Minim minim;  //Minim型変数であるminimの宣言
AudioPlayer recoded_voice;  //録音された音声
AudioPlayer up_preset;
AudioPlayer up_env;
AudioPlayer down_preset;
AudioPlayer down_env;


 
void setup(){
  
  size(1200, 900);
  minim = new Minim(this);  //初期化
  recoded_voice = minim.loadFile(input_wav_path); //wavファイルを指定する 
  up_preset = minim.loadFile(up_preset_wav_path);
  down_preset = minim.loadFile(down_preset_wav_path);
  
  up_env = minim.loadFile(up_env_wav_path);
  float up_env_gain = up_env.getGain();
  up_env.setGain(up_env_gain - 15); //gainを下げてenvのボリュームを調整
  
  down_env = minim.loadFile(down_env_wav_path);
  float gain = down_env.getGain();
  down_env.setGain(gain - 25); //gainを下げてenvのボリュームを調整
  
  bg = loadImage("background/bg_baseball_ground.jpg");
  nomal_state_shinro = loadImage("shinro_remotion/remotion_shinro0000.png");
  
  //pattern_out.txtの初期設定 0
  String[] pattern_txt = {pattern};
  saveStrings("./pattern_out.txt", pattern_txt);
  
  shinroSetup(shinro_nomal_path);
  println("Setup is finished");
}
 
void draw(){
  
  image(bg, 0, 0, 1200, 900);
  
  
  if(pattern_log != pattern){
    String[] pattern_txt = {pattern};
    saveStrings("./pattern_out.txt", pattern_txt);
    pattern_log = pattern;
  }
  
  move(pattern);
  recodeEffect();
  
  
}

void recodeEffect(){
  
  if(effect_alf > 90){
    effect_alf_bool = false;
  }else
  if(effect_alf < 10){
    effect_alf_bool = true;
  }
  if(effect_alf_bool){
    effect_alf += 8;
  }else{
    effect_alf -= 8;
  }

}

void shinroSetup(String _path){
  for(int i = 0;  i < agent.length; i++){
    //agent[i] = loadImage("motion_draft/motion2_export00" + i + ".png");
    
    String num = nf(i, 4);
    agent[i] = loadImage(_path + num + ".png");
    
  }
  
}

void move(String _pattern){
  
  if(_pattern == "nomal"){
    image(nomal_state_shinro,300,50);
  }
  
  if(_pattern == "recode"){
    fill(0, 0, 100, effect_alf);
    rect(0, 0, 1200, 900);
    image(agent[0],300,50);
  }
  
  if(_pattern == "move" || _pattern == "up" || _pattern == "down"){
    int frame =(frameCount/speed) % frame_num;
    image(agent[frame],300,50);
  }
  
}

void stop()
{
  recoded_voice.close();  //サウンドデータを終了
  up_preset.close();
  up_env.close();
  down_preset.close();
  minim.stop();
  super.stop();
}

void mouseReleased(){
  
  if(pattern == "nomal"){
    pattern = "recode";
  }else
  if(pattern == "recode"){
    recoded_voice = minim.loadFile(input_wav_path);
    recoded_voice.play();
    pattern = "move";
  }else
  if(pattern == "up"){
    
  }else
  if(pattern == "down"){
    
  }else
  if(pattern == "move"){
     
  }
  
}

void keyReleased(){
  if(keyCode == ENTER){
    PImage[] agent = new PImage[frame_num]; //agentの状態を初期化
    shinroSetup(shinro_nomal_path); //画像のセットアップ
    pattern = "nomal"; //状態遷移
  }
  if(key == '1'){
    PImage[] agent = new PImage[frame_num];
    shinroSetup(shinro_up_path);
    pattern = "up";
    up_env.play();
    up_preset.play();
    println("Loading is finished");
    
  }
  if(key == '2'){
    PImage[] agent = new PImage[frame_num];
    shinroSetup(shinro_down_path);
    pattern = "down";
    down_env.play();
    down_preset.play();
    println("Loading is finished");
  }
}
