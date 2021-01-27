void move() {

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
  if (spaceKey) {
    objects.add(new Bullet());
  }



  focusx = eyex + cos(leftRightAngle)*300;
  focusy = eyey + tan(upDownAngle)*300;
  focusz = eyez + sin(leftRightAngle)*300;

  if (upDownAngle > PI/(2.5)) {
    upDownAngle = PI/2.5;
  }

  if (upDownAngle < -PI/(2.5)) {
    upDownAngle = -PI/2.5;
  }


  //thres = Math.min(thres, 100);
  //thres++;

  //if (mouseX >= width-1 && thres > 20) {
  //  d.mouseMove(2, mouseY);
  //  pmouseY = mouseY;
  //  pmouseX = mouseX;
  //  thres = 0;
  //} else if (mouseX <= 1 && thres > 20) {
  //  d.mouseMove(width-2, mouseY);
  //  pmouseY = mouseY;
  //  pmouseX = mouseX;
  //  thres = 0;
  //} else if (thres > 20) {
  //  leftRightAngle+=(mouseX - pmouseX)*0.0015;
  //  upDownAngle+=(mouseY - pmouseY)*0.0015;
  //}


  if (frameCount < 2) {
    d.mouseMove(width/2, height/2);
    mouseX = width/2;
    mouseY = height/2;
  }
  if (mouseX < 1) {
    d.mouseMove(width-2, mouseY);
  } else if (mouseX > width-2) {
    d.mouseMove(1, mouseY);
  } 
  leftRightAngle += (mouseX - pmouseX)*0.01;
  upDownAngle    += (mouseY - pmouseY)*0.005;
  if (upDownAngle > PI/2.5) upDownAngle = PI/2.5;
  if (upDownAngle < -PI/2.5) upDownAngle = -PI/2.5;
}
