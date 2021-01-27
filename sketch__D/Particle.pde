class Particle extends GameObject {

  PVector dir;
  float speed;

  int time;

  Particle(PVector loc) {
    super(loc.x, loc.y, loc.z, 10);
    speed = 50;
    float vx = -cos(leftRightAngle + radians(random(-90, 90))), vy = 1, vz = - sin(leftRightAngle + radians(random(-90, 90)));
    dir = new PVector(vx, vy, vz);
    dir.setMag(speed);  
    time = 0;
  }

  void act() {
    int hitx = int(loc.x + 2000)/gridSize;
    int hity = int(loc.z + 2000)/gridSize;

    if (loc.y >= height && time > 100) {
      loc.y = height + 1;
      dir.setMag(0);
    } else if (map.get(hitx, hity) == white || time < 100) {
      loc.add(dir); 
      if (dir.x > 0) {
        dir.x--;
      }
      if (dir.z > 0) {
        dir.z--;
      }

      if (dir.x < 0) {
        dir.x = 0;
      }
      if (dir.z < 0) {
        dir.z = 0;
      }     
      if (loc.y > height) {
        loc.y = height;
      }
    }
    
    if(time > 1000){
     lives = 0; 
    }

    time++;
  }
}
