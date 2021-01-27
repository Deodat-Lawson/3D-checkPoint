
boolean canMoveF() {
  float fwdx, fwdy, fwdz;

  int mapx, mapy;

  for (int i = -20; i < 20; i++) {
    fwdx = eyex + cos(leftRightAngle + radians(i))*150;
    fwdy = eyey;
    fwdz = eyez + sin(leftRightAngle + radians(i))*150;

    mapx = (int)(fwdx + 2000)/gridSize;
    mapy = (int)(fwdz + 2000)/gridSize;

    if (map.get(mapx, mapy) != white) {
      return false;
    }
  }

  return true;
}


boolean canMoveR() {
  float fwdx, fwdy, fwdz;

  int mapx, mapy;
  for (int i = -20; i < 20; i++) {
    fwdx = eyex + cos(leftRightAngle + radians(90) + radians(i))*150;
    fwdy = eyey;
    fwdz = eyez + sin(leftRightAngle + radians(90) + radians(i))*150;

    mapx = (int)(fwdx + 2000)/gridSize;
    mapy = (int)(fwdz + 2000)/gridSize;

    if (map.get(mapx, mapy) != white) {
      return false;
    }
  }
  return true;
}

boolean canMoveL() {
  float fwdx, fwdy, fwdz;

  int mapx, mapy;

  for (int i = -20; i < 20; i++) {

    fwdx = eyex + cos(leftRightAngle - radians(90)+radians(i))*150;
    fwdy = eyey;
    fwdz = eyez + sin(leftRightAngle -  radians(90)+radians(i))*150;

    mapx = (int)(fwdx + 2000)/gridSize;
    mapy = (int)(fwdz + 2000)/gridSize;

    if (map.get(mapx, mapy) != white) {
      return false;
    }
  }
  return true;
}

boolean canMoveB() {
  float fwdx, fwdy, fwdz;

  int mapx, mapy;
  for (int i = -20; i <20; i++) {
    fwdx = eyex - cos(leftRightAngle+radians(i))*150;
    fwdy = eyey;
    fwdz = eyez - sin(leftRightAngle+radians(i))*150;

    mapx = (int)(fwdx + 2000)/gridSize;
    mapy = (int)(fwdz + 2000)/gridSize;

    if (map.get(mapx, mapy) != white) {
      return false;
    }
  }
  return true;
}
