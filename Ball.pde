class Ball{
  float x;
  float y;
  float r;
  float speed;
  int dy; // 1 for this.dy, -1 for up, 0 for none
  int dx; // 1 for this.dx, -1 for left, 0 for none
  int direction;
  public Ball(){
    r = random(15,20);
    x = random(r,1000-r);
    y = random(100+(2*r),750-(2*r));
    this.speed = 0.4;// random(0,0.8);
    setDirection(1);
  }
  private void setDirection(int d){
    switch(d){
      case 1: this.dy = -1; this.dx = 0; break; // up
      case 2: this.dy = 1; this.dx = 0; break; // down
      case 3: this.dy = 0; this.dx = -1; break; // left
      default: this.dy = 0; this.dx = 1; break; // right
    }
    this.direction = d;
  }
  
  public boolean intersects(Box box){
    
    // top edge
    double yDist = Math.pow((y-box.top),2);
    for(float i=box.left;i<=box.right;i+=0.2){
      double xDist = Math.pow((double)(x-i),2);
      double dist = yDist + xDist;
      if(dist < r*r){
        return true;
      }
    }
    
    // bottom edge
    yDist = Math.pow((y-box.bottom),2);
    for(float i=box.left;i<=box.right;i+=0.2){
      double xDist = Math.pow(x-i,2);
      double dist = yDist + xDist;
      if(dist < r*r){
        return true;
      }
    }
    
    // left edge
    double xDist = Math.pow((x-box.left),2);
    for(float i=box.top;i<=box.bottom;i+=0.2){
      yDist = Math.pow(y-i,2);
      double dist = yDist + xDist;
      if(dist < r*r){
        return true;
      }
    }
    
    // right edge
    xDist = Math.pow((x-box.right),2);
    for(float i=box.top;i<=box.bottom;i+=0.2){
      yDist = Math.pow(y-i,2);
      double dist = yDist + xDist;
      if(dist < r*r){
        return true;
      }
    }
    
    return false;
  }
  public void draw(){
    fill(0,255,0);
    stroke(0,255,0);
    ellipse(x, y, r,r);
  }
  
  public void move(){
    x = x + this.dx*this.speed;
    y = y + this.dy*this.speed;
    //if(x >= 1000+r){x = (-1)*r;}
    //else if(x< (-1*r)){x =1000+r;}
    //if(y >= 750+r){ y = 100+r; }
    //else if(y-r<=100){y = 750+r; }
    if(x >= 1000+r){game = false; return;}
    else if(x< (-1*r)){game = false; return;}
    if(y >= 750+r){ game = false; return; }
    else if(y-r<=100){game = false; return; }
  }
}
