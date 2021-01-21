import java.awt.Robot;

color black = #000000, white = #FFFFFF, blue = #7092BE;

float eyex, eyey, eyez; // 
float focusx, focusy, focusz; //pointing to
float upx, upy, upz;

float leftRightAngle, upDownAngle;

boolean akey, wkey, skey, dkey;
int thres = 0;

Robot d;
//textures
PImage mossyStone, ground, wood;

//initialize map
PImage map;
int gridSize;


void setup() {
  try {
    d = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  size(displayWidth, displayHeight, P3D);

  eyex = width/2;
  eyey = 0.8*height;
  eyez = height/2;

  focusx = width/2;
  focusy = height/2;
  focusz = height/2-100;

  upx = 0;
  upy = 1;
  upz = 0;

  leftRightAngle = 0;
  upDownAngle = 0;

  map = loadImage("map.png");
  mossyStone = loadImage("mossyStone.png");
  ground = loadImage("netherrack.png");
  wood = loadImage("oakPlank.png");
  textureMode(NORMAL);
  gridSize = 100;
}

void draw() {
  background(0);
  camera(eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz);
  pointLight(255, 255, 255, eyex, eyey, eyez);
  drawAxes();
  //drawFloor(-2000, 2000, height - gridSize*3, 200);
  //drawFloor(-2000, 2000, height, 200);
  move();
  drawMap();
}



void drawAxes() {
  //line(x1,y1,z1,x2,y2,z2)
}

void drawFloor(int start, int end, int level, int gap) {
  stroke(255);
  strokeWeight(1);

  int x = start;
  while ((x+=gap) <= end) {
    line(x, level, end, x, level, start);
    line(end, level, x, start, level, x);
  }
}

void keyPressed() {
  if (key == 'W' || key == 'w') {
    wkey = true;
  }
  if (key == 'S' || key == 's') {
    skey = true;
  }
  if (key == 'A' || key == 'a') {
    akey = true;
  }
  if (key == 'D' || key == 'd') {
    dkey = true;
  }
}

void keyReleased() {
  if (key == 'W' || key == 'w') {
    wkey = false;
  }
  if (key == 'S' || key == 's') {
    skey = false;
  }
  if (key == 'A' || key == 'a') {
    akey = false;
  }
  if (key == 'D' || key == 'd') {
    dkey = false;
  }
}

void move() {
  pushMatrix();

  translate(focusx, focusy, focusz);
  sphere(1);

  popMatrix();

  if (wkey && canMoveF()) {
    eyex+=cos(leftRightAngle)*20;
    eyez+=sin(leftRightAngle)*20;
  }
  if (akey && canMoveL()) {
    eyex+=cos(leftRightAngle-(PI/2))*20;
    eyez+=sin(leftRightAngle-(PI/2))*20;
  }
  if (skey && canMoveB()) {
    eyex-=cos(leftRightAngle)*20;
    eyez-=sin(leftRightAngle)*20;
  }
  if (dkey&& canMoveR()) {
    eyex+=cos(leftRightAngle+(PI/2))*20;
    eyez+=sin(leftRightAngle+(PI/2))*20;
  }

  focusx = eyex + cos(leftRightAngle)*100;
  focusy = eyey + tan(upDownAngle)*100;
  focusz = eyez + sin(leftRightAngle)*100;

  if (upDownAngle > PI/(2.5)) {
    upDownAngle = PI/2.5;
  }

  if (upDownAngle < -PI/(2.5)) {
    upDownAngle = -PI/2.5;
  }


  thres = Math.min(thres, 100);
  thres++;

  if (mouseX >= width-1 && thres > 20) {
    d.mouseMove(2, mouseY);
    pmouseY = mouseY;
    pmouseX = mouseX;
    thres = 0;
  } else if (mouseX <= 1 && thres > 20) {
    d.mouseMove(width-2, mouseY);
    pmouseY = mouseY;
    pmouseX = mouseX;
    thres = 0;
  } else if (thres > 2) {
    leftRightAngle+=(mouseX - pmouseX)*0.0015;
    upDownAngle+=(mouseY - pmouseY)*0.0015;
  }
}


void drawMap() {

  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      color c = map.get(x, y);
      if (c != white) {
        if (c == blue) {
          texturedCube(x*gridSize - 2000, height-gridSize, y*gridSize -2000, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone, gridSize);
          texturedCube(x*gridSize - 2000, height-2*gridSize, y*gridSize -2000, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone, gridSize);
          texturedCube(x*gridSize - 2000, height-3*gridSize, y*gridSize -2000, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone, gridSize);
        } else if ( c == black) {
          texturedCube(x*gridSize - 2000, height-gridSize, y*gridSize -2000, wood, wood, wood, wood, wood, wood, gridSize);
          texturedCube(x*gridSize - 2000, height-2*gridSize, y*gridSize -2000, wood, wood, wood, wood, wood, wood, gridSize);
          texturedCube(x*gridSize - 2000, height-3*gridSize, y*gridSize -2000, wood, wood, wood, wood, wood, wood, gridSize);
        }
      } 

      texturedCube(x*gridSize - 2000, height, y*gridSize -2000, ground, ground, ground, ground, ground, ground, gridSize);
      texturedCube(x*gridSize - 2000, height-4*gridSize, y*gridSize -2000, ground, ground, ground, ground, ground, ground, gridSize);
    }
  }
}


void texturedCube(float x, float y, float z, PImage top, PImage bottom, PImage left, PImage right, PImage front, PImage back, float size) {
  pushMatrix();
  translate(x, y, z);
  scale(size);
  noStroke();

  beginShape(QUADS);
  texture(top);

  //top
  //     x,y,z,tx,ty
  vertex(0, 0, 0, 0, 0);
  vertex(1, 0, 0, 1, 0);
  vertex(1, 0, 1, 1, 1);
  vertex(0, 0, 1, 0, 1);
  endShape();

  //bottom
  beginShape(QUADS);
  texture(bottom);
  vertex(0, 1, 0, 0, 0);
  vertex(1, 1, 0, 1, 0);
  vertex(1, 1, 1, 1, 1);
  vertex(0, 1, 1, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(front);

  //front
  vertex(0, 0, 1, 0, 0);
  vertex(1, 0, 1, 1, 0);
  vertex(1, 1, 1, 1, 1);
  vertex(0, 1, 1, 0, 1);
  endShape();


  beginShape(QUADS);
  texture(back);
  //back
  vertex(0, 0, 0, 0, 0);
  vertex(1, 0, 0, 1, 0);
  vertex(1, 1, 0, 1, 1);
  vertex(0, 1, 0, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(left);
  //left
  vertex(1, 0, 0, 0, 0);
  vertex(1, 1, 0, 1, 0);
  vertex(1, 1, 1, 1, 1);
  vertex(1, 0, 1, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(right);
  //right
  vertex(0, 0, 0, 0, 0);
  vertex(0, 1, 0, 1, 0);
  vertex(0, 1, 1, 1, 1);
  vertex(0, 0, 1, 0, 1);

  endShape();
  popMatrix();
}


boolean canMoveF() {
  float fwdx, fwdy, fwdz;

  int mapx, mapy;

  fwdx = eyex + cos(leftRightAngle)*200;
  fwdy = eyey;
  fwdz = eyez + sin(leftRightAngle)*200;

  mapx = (int)(fwdx + 2000)/gridSize;
  mapy = (int)(fwdz + 2000)/gridSize;

  if (map.get(mapx, mapy) == white) {
    return true;
  }
  return false;
}


boolean canMoveR() {
  float fwdx, fwdy, fwdz;

  int mapx, mapy;

  fwdx = eyex + cos(leftRightAngle + radians(90))*200;
  fwdy = eyey;
  fwdz = eyez + sin(leftRightAngle + radians(90))*200;

  mapx = (int)(fwdx + 2000)/gridSize;
  mapy = (int)(fwdz + 2000)/gridSize;

  if (map.get(mapx, mapy) == white) {
    return true;
  }
  return false;
}

boolean canMoveL() {
  float fwdx, fwdy, fwdz;

  int mapx, mapy;

  fwdx = eyex + cos(leftRightAngle - radians(90))*200;
  fwdy = eyey;
  fwdz = eyez + sin(leftRightAngle -  radians(90))*200;

  mapx = (int)(fwdx + 2000)/gridSize;
  mapy = (int)(fwdz + 2000)/gridSize;

  if (map.get(mapx, mapy) == white) {
    return true;
  }
  return false;
}

boolean canMoveB() {
  float fwdx, fwdy, fwdz;

  int mapx, mapy;

  fwdx = eyex - cos(leftRightAngle)*200;
  fwdy = eyey;
  fwdz = eyez - sin(leftRightAngle)*200;

  mapx = (int)(fwdx + 2000)/gridSize;
  mapy = (int)(fwdz + 2000)/gridSize;

  if (map.get(mapx, mapy) == white) {
    return true;
  }
  return false;
}
