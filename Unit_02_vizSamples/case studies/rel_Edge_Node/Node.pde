class Node {
  float x, y;
  float dx, dy;
  boolean fixed;
  String label;
 
  Node(String label) {
    this.label = label;
    x = random(width);
    y = random(height);
  }
 
  void relax( ) {
    float ddx = 0;
    float ddy = 0;
    for (int j = 0; j < nodeCount; j++) {
      Node n = nodes[j];
      if (n != this) {
        float vx = x - n.x;
        float vy = y - n.y;
        float lensq = vx * vx + vy * vy;
        if (lensq == 0) {
          ddx += random(1);
          ddy += random(1);
        }
        else if (lensq < 100*100) {
          ddx += vx / lensq;
          ddy += vy / lensq;
        }
      }
    }
    float dlen = mag(ddx, ddy) / 2;
    if (dlen > 0) {
      dx += ddx / dlen;
      dy += ddy / dlen;
    }
  }
 
  void update( ) {
    if (!fixed) {
      x += constrain(dx, -5, 5);
      y += constrain(dy, -5, 5);
      x = constrain(x, 0, width);
      y = constrain(y, 0, height);
    }
    dx /= 2;
    dy /= 2;
  }
 
  void draw( ) {
    if (selection == this) {
      fill(selectColor);
    }
    else if (fixed) {
      fill(fixedColor);
    }
    else {
      fill(nodeColor);
    }
    stroke(255);
    strokeWeight(2);
    rectMode(CORNER);
    float w = textWidth(label) + 10;
    float h = textAscent( ) + textDescent( ) + 4;
    //rect(x - w/2, y - h/2, w, h);
    ellipse(x,y,w,w);
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x, y);
  }
}