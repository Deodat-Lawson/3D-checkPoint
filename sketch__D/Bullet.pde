class Bullet extends GameObject {

  PVector dir;
  float speed;

  Bullet() {
    super(eyex, eyey, eyez, 10);
    speed = 50;
    float vx = cos(leftRightAngle), vy = tan(upDownAngle), vz = sin(leftRightAngle);
    dir = new PVector(vx, vy, vz);
    dir.setMag(speed);
  }

  void act() {
    int hitx = int(loc.x + 2000)/gridSize;
    int hity = int(loc.z + 2000)/gridSize;

    if (map.get(hitx, hity) == white) {
      if (loc.y >= height || loc.y <= 800) {
        lives = 0;
        for (int i = 0; i < 5; i++) {
          objects.add(new Particle(loc));
        }
      }
      loc.add(dir);
    } else {
      lives = 0;
      for (int i = 0; i < 5; i++) {
        objects.add(new Particle(loc));
      }
    }
  }
}
