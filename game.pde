import java.util.Random;
import java.util.Collections;

import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;

int score = 0;
int time=0;
boolean game = true;
PFont f;   

int BOX_COUNT = 15;
List<Box> boxes;
Ball ball;
int fileScore = 0;
void setup(){
  size(1000,750);
  background(0,0,255);
  //frameRate(4);
  fill(255,255,0);
  rect(0,0,1000,100);
  f = createFont("Arial",16,true);
  textFont(f,16);
  textSize(32);
  boxes = new ArrayList<Box>();
  for(int i=0;i<BOX_COUNT;i++){
    boxes.add(new Box());
  }
  ball = new Ball();
  fileScore = getFileScore();
  if(fileScore > highScore){
    highScore = fileScore;
  }
}

PrintWriter output;
int highScore = 0;

int getFileScore(){
  
  String[] fileLines = loadStrings("highScore.txt");
  if(fileLines == null){
    return -1;
  }else{
    int fileScore = Integer.parseInt(fileLines[0]);
    return fileScore;
  }
}

void writeHighScore(int s){
  output = createWriter("highScore.txt");
  output.println(s);
  output.flush(); // Writes the remaining data to the file
  output.close();
}

boolean paused = true;

void drawScore(){
  fill(255,255,0);
  rect(0,0,1000,100);
  fill(255,0,0);
  textSize(26);
  noFill();
  stroke(0);
  strokeWeight(4);
  int scoreWidth = (score<100)?200:220;
  rect(740,15,scoreWidth,50);
  text("Your Score: "+Integer.toString(score), 755, 50);
  textSize(16);
  text("Instructions:\n1. Press SPACE to start.                      2. Use arrow keys to control the ball.\n3. Do not hit the red boxes.                  4. Ball should not go out",10,30);
  textSize(18);
  text("High Score: "+Integer.toString(highScore), 785, 90);
}

void drawGameOver(){
  fill(0,0,0);
  stroke(0);
  rect(150,320,700,80);
  fill(255);
  textSize(16);
  text("Game Over. Press SPACE to restart", 350, 360);
}

void drawCountdown(){
  fill(0,0,0);
  stroke(0);
  rect(350,320,300,100);
  fill(255);
  textSize(40);
  text(countdown[countdownIndex], 480, 380);

}

void drawInstructions(){
  fill(0,0,0);
  rect(10,10,700,80);
  fill(255);
  text("Instructions", 150, 50);
}

String[] countdown = {"GO!","1","2","3"};
int countdownIndex = 3;

void timeChecks(){
  time++;
  
  if(time%10==0 && game && !paused){
    score++;
  }
  if(time%200==0 && game && !paused){
    //boxes.add(new Box());
  }
  if(time%100==0 && game && !paused){
    boxes.get((new java.util.Random()).nextInt(boxes.size())).setDirection();
  }
  if(paused && time%150==0 && game){
    paused = false;
  }else if(paused && time%40==0){
    countdownIndex--;
  }
}

void draw(){
  fill(0,0,255);
  rect(0,100,1000,650);
  timeChecks();
  drawScore();
   
  if(game){
    
    if(paused){
      ball.draw();
      for(Box box : boxes){
        box.draw();
      }
      if(paused){
        drawCountdown();
      }
    }else{
    
      for(Box box : boxes){
        box.move();
        box.draw();
        if(ball.intersects(box)){
          game = false;
          break;
        }
        ball.move();
        ball.draw();
      }
    }
  }else{
    // game over or not yet begun
    for(Box box : boxes){
      box.draw();
    }
    ball.draw();
    if(score > highScore){
      writeHighScore(score);
      highScore = score;
    }
    drawGameOver();
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
      if(game) return;
      paused = true;
      score = 0;
      countdownIndex = 3;
      setup();
      time = 0;
      game = true;
    }
}
