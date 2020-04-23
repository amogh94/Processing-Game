import java.util.Random;

int score = 0;
int time=0;
boolean game = true;
PFont f;   

Box[] box = new Box[10];
Ball ball;

void setup(){
  size(1000,750);
  background(0,0,255);
  //frameRate(4);
  fill(255,255,0);
  rect(0,0,1000,100);
  f = createFont("Arial",16,true);
  textFont(f,16);
  textSize(32);
  for(int i=0;i<box.length;i++){
    box[i] = new Box();
  }
  ball = new Ball();
}

void drawScore(){
  fill(255,255,0);
  rect(0,0,1000,100);
  fill(255,0,0);
  text("Your Score: "+Integer.toString(score), 775, 50);
}



void draw(){
  time++;
  drawScore();
  for(int i=0;i<box.length;i++){
    box[i].draw();
  }
  if(game){
    if(time%10==0)
    score++;
    ball.draw();
    for(int i=0;i<box.length;i++){
      box[i].move();
      if(ball.intersects(box[i])){
        game = false;
        break;
      }
    }
  }else{
    fill(0,0,0);
    rect(10,10,700,80);
    fill(255);
    text("Game Over", 150, 50);
  }
  
}

void keyPressed() {
  if(key == 'q') {
    //videoExport.endMovie();
    exit();
  }
  if (key == CODED) {
    if (keyCode == UP) {
      ball.setDirection (1);
    } else if (keyCode == DOWN) {
      ball.setDirection (2);
    }  else if (keyCode == RIGHT) {
       ball.setDirection (4);
    }  else if (keyCode == LEFT) {
      ball.setDirection (3);
    } 
  }else if(key == 32){
      game = true;
      score = 0;
      setup();
    }
}
