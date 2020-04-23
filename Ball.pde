class Ball{
  float x;
  float y;
  float r;
  float speed;
  int dy; // 1 for dy, -1 for up, 0 for none
  int dx; // 1 for dx, -1 for left, 0 for none
  int direction;
  public Ball(){
    r = random(15,20);
    x = random(r,1000-r);
    y = random(100+(2*r),750-(2*r));
    speed = random(3,5);
    direction = 1;
    setDirection(1);
  }
  private void setDirection(int d){
    switch(d){
      case 1: dy = -1; dx = 0; break; // up
      case 2: dy = 1; dx = 0; break; // down
      case 3: dy = 0; dx = -1; break; // left
      default: dy = 0; dx = 1; break; // right
    }
    direction = d;
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
    
    fill(0,0,255);
    rect(0,100,1000,650);
    
    fill(0,0,255);
    stroke(0,0,255);
    ellipse(x, y, r,r);
    
   
    x = x + dx*speed;
    
    y = y + dy*speed;
    if(x >= 1000+r){x = (-1)*r;}
    else if(x< (-1*r)){x =1000+r;}
    if(y >= 750+r){ y = 100+r; }
    else if(y-r<=100){y = 750+r; }
    
    fill(0,255,0);
    stroke(0,255,0);
    ellipse(x, y, r,r);
  }
}
