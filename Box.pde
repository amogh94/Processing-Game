class Box{
  float x;
  float y;
  float r;
  float left, right, top, bottom;
  int direction;
  float speed;
  int dy; // 1 for dy, -1 for up, 0 for none
  int dx; // 1 for dx, -1 for left, 0 for none
  Random boxMovement = new Random();
  public Box(){
    r = random(10,25);
    x = random(r,1000-r);
    y = random(100+(2*r),750-(2*r));
    left = x-r;
    right = x+r;
    top = y-r;
    bottom = y+r;
    setDirection();
  }
  
  private void setDirection(){
    direction = boxMovement.ints(1,(4+1)).findFirst().getAsInt();
    switch(direction){
      case 1: dy = -1; dx = 0; break; // up
      case 2: dy = 1; dx = 0; break; // down
      case 3: dy = 0; dx = -1; break; // left
      default: dy = 0; dx = 1; break; // right
    }
  }
  
  private void draw(){
    fill(255,0,0);
    stroke(255,0,0);
    rect(x-r, y-r, 2*r, 2*r);
  }
  
  public void move(){
    
    fill(0,0,255);
    stroke(0,0,255);
    rect(x-r, y-r, 2*r, 2*r);
    speed = random(1,3);
    x = x + dx*speed;
    y = y + dy*speed;
    if(dx*speed<0){
      left -= dx*speed; right -= dx*speed;
    }else{
      left += dx*speed; right += dx*speed;
    }
    
    if(dy*speed < 0){
      top -= dy*speed; bottom -= dy*speed; 
    }else{
      top += dy*speed; bottom += dy*speed; 
    }
    if(x >= 1000+r){x = (-1)*r; left = x-r; right = x+r;}
    else if(x< (-1*r)){x =1000+r; left = x-r; right = x+r; }
    if(y >= 750+r){ y = 100+r; top = y-r; bottom  = y+r; }
    else if(y-r<=100){y = 750+r;  top = y-r; bottom  = y+r; }
    
    fill(255,0,0);
    stroke(255,0,0);
    rect(x-r, y-r, 2*r, 2*r);
  }
}
