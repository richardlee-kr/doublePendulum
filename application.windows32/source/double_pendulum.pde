float l1 = 200;
float l2 = 200;
float m1 = 40;
float m2 = 40;

float size = 40;

float x1, y1;
float x2, y2;

float a1 = PI/2;
float a2 = PI/2;
float a1_v = 0;
float a2_v = 0;

float g = 1;

float px2 = -1;
float py2 = -1;

int cx, cy;

PGraphics canvas;

boolean isPlay = false;

import controlP5.*;

ControlP5 cp5;

controlP5.Slider s1,s2,s3;
controlP5.Button b1;

int angle1 = 90;
int angle2 = 90;
int duration = 60;

float time = 0;

int c = 0;

void setup()
{
  size(900,900);
  smooth();
  
  cx = width/2;
  cy = 400;
  
  cp5 = new ControlP5(this);
  s1 = cp5.addSlider("angle1")
    .setPosition(0,0)
    .setRange(-120,120)
    .setSize(360,32);
  s2 = cp5.addSlider("angle2")
    .setPosition(0,32)
    .setRange(-120,120)
    .setSize(360,32);
  s3 = cp5.addSlider("duration")
    .setPosition(0,64)
    .setRange(10,300)
    .setSize(360,32);
  b1 = cp5.addButton("clear")
    .setValue(100)
    .setSize(50,50)
    .setPosition(width-50,0);
  
  canvas = createGraphics(width,height);
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();
}

void draw()
{
  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1-2*a2);
  float num3 = -2*sin(a1-a2)*m2;
  float num4 = a2_v*a2_v*l2+a1_v*a1_v*l1*cos(a1-a2);
  float den = l1 * (2*m1+m2-m2*cos(2*a1-2*a2));
  
  float a1_a = (num1 + num2 + num3*num4) / den;
  
  num1 = 2 * sin(a1-a2);
  num2 = (a1_v*a1_v*l1*(m1+m2));
  num3 = g * (m1 + m2) * cos(a1);
  num4 = a2_v*a2_v*l2*m2*cos(a1-a2);
  den = l2 * (2*m1+m2-m2*cos(2*a1-2*a2));
  
  float a2_a = (num1*(num2+num3+num4)) / den;

  
  image(canvas,0,0);
  strokeWeight(2);
  
  translate(cx,cy);
      
  stroke(120);
  line(0,0,x1,y1);
  line(x1,y1,x2,y2);
  
  noStroke();
  fill(0,0,255);
  ellipse(x1,y1,size,size);
  ellipse(x2,y2,size,size);
  
  x1 = l1 * sin(a1);
  y1 = l1 * cos(a1);
  
  x2 = x1 + l2 * sin(a2);
  y2 = y1 + l2 * cos(a2);
  
  translate(-cx,-cy);
   

  if(isPlay)
  {
    while(c < 1)
    {
      clearLines();
      c += 1;
    }
    
    String _time = nf(time, 0,2);
    
    fill(255);
    textSize(16);
    text("time: " + _time,16,32);
    
    time -= 0.016;
    

    a1_v += a1_a;
    a2_v += a2_a;
    a1 += a1_v;
    a2 += a2_v;
    
    canvas.beginDraw();
    canvas.translate(cx,cy);
    canvas.strokeWeight(2);
    canvas.stroke(255);
    //canvas.point(x2,y2);
    if(frameCount > 1)
    {
      canvas.line(px2,py2, x2,y2);
    }
    canvas.endDraw();
    
    s1.hide();
    s2.hide();
    s3.hide();
    
    if(frameCount > duration*60)
    {
      isPlay = false;
    }
  }
  else
  {
    frameCount = 0;
    time = duration;
    
    s1.show();
    s2.show();
    s3.show();
    
    c = 0;
    a1_v = 0;
    a2_v = 0;
    
    a1 = radians(angle1);
    a2 = radians(angle2);
    
    a1 *= 0.99;
    a2 *= 0.99;
  }
      
  px2 = x2;
  py2 = y2;
  
  if(b1.isPressed())
  {
    clearLines();
  }
}

void mousePressed()
{
  if(mouseButton == RIGHT)
  {
    if(isPlay)
    {
      isPlay = false;
    }
    else
    {
      isPlay = true;
    }
  }
}

void clearLines()
{
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();
}
