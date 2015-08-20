import ddf.minim.*;

Minim minim;
AudioSample kick;

void setup()
{
  size(512, 200, P3D);
  minim = new Minim(this);

  // load BD.wav from the data folder
  kick = minim.loadSample( "BD.mp3", // filename
                            512      // buffer size
                         );
  
  if ( kick == null ) println("Didn't get kick!");
  
}

void draw()
{
  background(0);
  stroke(255);
  
  // use the mix buffer to draw the waveforms.
  for (int i = 0; i < kick.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, kick.bufferSize(), 0, width);
    float x2 = map(i+1, 0, kick.bufferSize(), 0, width);
    line(x1, 50 - kick.mix.get(i)*50, x2, 50 - kick.mix.get(i+1)*50);
  }
}

void keyPressed() 
{
  if ( key == 'k' ) kick.trigger();
}

