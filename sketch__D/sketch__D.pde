import java.awt.Robot;

color black = #000000, white = #FFFFFF, blue = #7092BE;

float eyex, eyey, eyez; // 
float focusx, focusy, focusz; //pointing to
float upx, upy, upz;

float leftRightAngle, upDownAngle;

boolean akey, wkey, skey, dkey,spaceKey;
int thres = 0;

Robot d;
//textures
PImage mossyStone, ground, wood;

//initialize map
PImage map;
int gridSize;

//Game Objects
ArrayList<GameObject> objects;

//canvass
PGraphics world;
PGraphics HUD;


void setup() {
  objects = new ArrayList<GameObject>();

  world = createGraphics(width,height, P3D);
  HUD = createGraphics(width,height, P2D);

  try {
    d = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  world.textureMode(NORMAL);
  size(displayWidth, displayHeight, P2D);

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
  
  world.beginDraw();
  
  world.background(0);
  world.camera(eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz);
  world.pointLight(255, 255, 255, eyex, eyey, eyez);
  drawAxes();
  move();
  drawMap();
  
  int i = 0;
  while(i < objects.size()){
    GameObject obj = objects.get(i);
    obj.act();
    obj.show();
    if(obj.lives == 0){
     objects.remove(i);
     i--;
    }
    i++;
  }
  
  
  world.endDraw();
  
  image(world,0,0);
  
  HUD.beginDraw();
  HUD.stroke(white);
  HUD.strokeWeight(5);
  HUD.line(width/2 - 20,height/2,width/2 + 20,height/2);
  HUD.line(width/2,height/2 - 20,width/2,height/2 + 20);
  HUD.endDraw();
}


void drawAxes() {
  //line(x1,y1,z1,x2,y2,z2)
}

void drawFloor(int start, int end, int level, int gap) {
  world.stroke(255);
  world.strokeWeight(1);

  int x = start;
  while ((x+=gap) <= end) {
    world.line(x, level, end, x, level, start);
    world.line(end, level, x, start, level, x);
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
