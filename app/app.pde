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

// 再生用
Minim minim;  //Minim型変数であるminimの宣言
AudioPlayer player;  //サウンドデータ格納用の変数

// 変化用
VibratoClass vibrato;

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

class VibratoClass implements AudioEffect
{
  float[] l_buffer;
  float[] r_buffer;
  int buffer_size;  
  int l_total_index, r_total_index;
  float dt;      // dt >= depth
  float depth;
  float freq;
  float fs;
  
  VibratoClass(float f, float dp, float fq)
  {
    fs = f;
    depth = fs * dp;
    dt = depth;
    freq = fq;
    
    buffer_size = (int)(2.0 * dt) + 256;
        
    l_buffer = new float[buffer_size];
    r_buffer = new float[buffer_size];
    
    l_total_index = 0;
    r_total_index = 0;
    
    for (int i = 0; i < buffer_size; i++)
    {
      l_buffer[i] = 0.0;
      r_buffer[i] = 0.0;
    }
  }
  
  int vibrato_process(float[] samp, float[] buffer, int ix)
  {
    float[] out = new float[samp.length];
    int n = ix;
    for ( int i = 0; i < samp.length; i++ )
    {
      int index = n % buffer_size;
      buffer[index] = samp[i];
      float fmod = dt + depth * sin( 2.0 * PI * freq * n / fs );
      float t = (float)index - fmod;
      int m0 = (int)t;
      int m1 = m0 + 1;
      float delta = t - (float)m0;
      if (m0 < 0)
      {
        m0 += buffer_size;
      }
      if (m1 < 0)
      {
        m1 += buffer_size;
      }
      out[i] = delta * buffer[m1] + (1.0 - delta) * buffer[m0];
      n++;
    }    
    arraycopy(out, samp);
    
    return n;
  }
  
  void process(float[] samp)
  {
    l_total_index = vibrato_process(samp, l_buffer, l_total_index);
  }
  
  void process(float[] left, float[] right)
  {
    l_total_index = vibrato_process(left, l_buffer, l_total_index);
    r_total_index = vibrato_process(right, r_buffer, r_total_index);
  }
}
