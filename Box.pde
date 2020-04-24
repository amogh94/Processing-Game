class Box{
  float x;
  float y;
  float r;
  float left, right, top, bottom;
  int direction;
  float speed;
  int dy; // 1 for dy, -1 for up, 0 for none
  int dx; // 1 for this.dx, -1 for left, 0 for none
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
  
  public void setDirection(){
    direction = boxMovement.ints(1,(4+1)).findFirst().getAsInt();
    switch(direction){
      case 1: this.dy = -1; this.dx = 0; break; // up
      case 2: this.dy = 1; this.dx = 0; break; // down
      case 3: this.dy = 0; this.dx = -1; break; // left
      default: this.dy = 0; this.dx = 1; break; // right
    }
  }
  
  private void draw(){
    fill(255,0,0);
    stroke(255,0,0);
    rect(x-r, y-r, 2*r, 2*r);
  }
  
  public String toString(){
    String res = "BOX : center = ("+x+", "+y+")";
    res += " r = "+r;
    res += " left = "+left+", right = "+right+", top = "+top+", bottom = "+bottom;
    return res;
  }
  
  public void move(){
    this.speed = random(3,5);
    left = x-r;
    right = x+r; 
    top = y-r;
    bottom = y+r;
    
    x = x + this.dx*this.speed;
    y = y + this.dy*this.speed;
    if(this.dx*speed<0){
      left -= this.dx*speed; right -= this.dx*this.speed;
    }else{
      left += this.dx*speed; right += this.dx*this.speed;
    }
    if(this.dy*speed < 0){
      top -= this.dy*speed; bottom -= this.dy*this.speed; 
    }else{
      top += this.dy*speed; bottom += this.dy*this.speed; 
    }
    switch(direction){
      case 1: // going up
        if(y-r <= 100){
          y = 750+r; top = y-r; bottom = y+r;
        }
        break;
      case 2: // going down
        if(y>=750+r){
          y = 100+r; top = y-r; bottom  = y+r;
        }
        break;
      case 3: // going left
        if(x< (-1*r)){
          x =1000+r; left = 1000; right = 1000+2*r;
        }
        break;
      case 4:
        if(x >= 1000+r){
          x = (-1)*r; left = x-r; right = x+r;
        }
        break;
    }
  }
}
