void texturedCube(float x, float y, float z, PImage top, PImage bottom, PImage left, PImage right, PImage front, PImage back, float size) {
  world.pushMatrix();
  world.translate(x, y, z);
  world.scale(size);
  world.noStroke();

  world.beginShape(QUADS);
  world.texture(top);

  //top
  //     x,y,z,tx,ty
  world.vertex(0, 0, 0, 0, 0);
  world.vertex(1, 0, 0, 1, 0);
  world.vertex(1, 0, 1, 1, 1);
  world.vertex(0, 0, 1, 0, 1);
  world.endShape();

  //bottom
  world.beginShape(QUADS);
  world.texture(bottom);
  world.vertex(0, 1, 0, 0, 0);
  world.vertex(1, 1, 0, 1, 0);
  world.vertex(1, 1, 1, 1, 1);
  world.vertex(0, 1, 1, 0, 1);
  world.endShape();

  world.beginShape(QUADS);
  world.texture(front);

  //front
  world.vertex(0, 0, 1, 0, 0);
  world.vertex(1, 0, 1, 1, 0);
  world.vertex(1, 1, 1, 1, 1);
  world.vertex(0, 1, 1, 0, 1);
  world.endShape();


  world.beginShape(QUADS);
  world.texture(back);
  //back
  world.vertex(0, 0, 0, 0, 0);
  world.vertex(1, 0, 0, 1, 0);
  world.vertex(1, 1, 0, 1, 1);
  world.vertex(0, 1, 0, 0, 1);
  world.endShape();

  world.beginShape(QUADS);
  world.texture(left);
  //left
  world.vertex(0, 0, 0, 0, 0);
  world.vertex(0, 0, 1, 1, 0);
  world.vertex(0, 1, 1, 1, 1);
  world.vertex(0, 1, 0, 0, 1);
  world.endShape();

  world.beginShape(QUADS);
  world.texture(right);
  //right
  world.vertex(1, 0, 0, 0, 0);
  world.vertex(1, 0, 1, 1, 0);
  world.vertex(1, 1, 1, 1, 1);
  world.vertex(1, 1, 0, 0, 1);

  world.endShape();
  world.popMatrix();
}
