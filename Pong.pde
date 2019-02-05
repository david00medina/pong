import processing.sound.*;


private SoundFile hitWallSound;
private SoundFile hitPaddleSound;
private SoundFile pointSound;

World world;
Player playerL;
Player playerR;
Ball ball;

static final int WIDTH = 800;
static final int HEIGHT = 800;

static final int background = 0;
static final int elementColor[] = {255, 255, 255};
static final int margin = 6;
static final int netLines = 30;
static final int fps = 40;

static final int xScore1 = WIDTH/4 - 50;
static final int yScore1 = 150;
static final int xScore2 = 3*WIDTH/4 - 50;
static final int yScore2 = 150;

static final int playerWidth = 10;
static final int playerHeight = 50;
static final int playerMargin = 50;
static final int playerSpeed = 50;
static final int[] playerColor = {255, 255, 255};

static final int ballPos = 30;
static final int diameter = 20;
static final int ballSpeed = 5;
static final int[] ballColor = {255, 255, 255};

static final int scoreSize = 128;

void setup() {
  size(800, 800);
  
  world = new World(background, elementColor, margin, netLines, fps, xScore1, yScore1, xScore2, yScore2, scoreSize);
  
  playerR = new Player(0, 0, playerWidth, playerHeight, playerMargin, playerSpeed, playerColor);
  playerR.x1 = width - playerR.x2 - playerR.margin;
  playerR.y1 = height/2 - playerR.x2/2;
  
  playerL = new Player(0, 0, playerWidth, playerHeight, playerMargin, playerSpeed, playerColor);
  playerL.x1 = playerL.x2 + playerL.margin;
  playerL.y1 = height/2 - playerL.x2/2;
  
  ball = new Ball(ballPos, diameter, ballSpeed, ballSpeed, 1, 1, ballColor);
  ball.spawn();
  
  hitWallSound = new SoundFile(this, "ping_pong_8bit_plop.wav");
  hitPaddleSound = new SoundFile(this, "ping_pong_8bit_beeep.wav");
  pointSound = new SoundFile(this, "ping_pong_8bit_peeeeeep.wav");
}

void draw() {
  world.refresh();
  playerL.refresh();
  playerR.refresh();
  boolean[] isPoint = xBallMotion();
  yBallMotion();
  ball.refresh();
  delimitBallMotion();
  for(int i = 0; i < 2; i++) {
    if(isPoint[i]) world.refreshScore(i);
  }
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == UP && playerR.y1 > (0 + world.margin)) playerR.y1 -= playerR.speed;
    else if(keyCode == DOWN && playerR.y1 < (height - (world.margin + playerR.y2 + world.margin))) playerR.y1 += playerR.speed;
  } else {
    if(key == 'w' && playerL.y1 > (0 + world.margin)) playerL.y1 -= playerL.speed;
    else if(key == 's' && playerL.y1 < (height - (world.margin + playerL.y2 + world.margin))) playerL.y1 += playerL.speed;
  }
}

public void delimitBallMotion() {
  if(ball.y < (ball.DIAMETER/2 + world.margin)) ball.y = ball.DIAMETER/2 + world.margin;
  else if(ball.y > height - (ball.DIAMETER/2 + world.margin)) ball.y = height - (ball.DIAMETER/2 + world.margin);
}

private boolean[] xBallMotion() {
  boolean[] result = {false, false};
  ball.x += ball.xSpeed*ball.xDir;
  int collisionRight = playerR.x1 - (ball.x + ball.DIAMETER);
  int collisionLeft = ball.x - (playerL.x1 + ball.DIAMETER + playerL.x2);
  
  boolean isCollisionRight = collisionRight < -playerR.x2 && ball.y >= playerR.y1 && ball.y <= (playerR.y1 + playerR.y2);
  boolean isCollisionLeft = collisionLeft < -playerR.x2 && ball.y >= playerL.y1 && ball.y <= (playerL.y1 + playerL.y2);
  if(isCollisionRight || isCollisionLeft) {
    hitPaddleSound.play();
    ball.xDir = -ball.xDir;
  }
  else if(collisionRight < -playerR.x2*10) {
    pointSound.play();
    ball.xDir = 1;
    ball.spawn();
    result[1] = true;
  } else if(collisionLeft < -playerL.x2*10) {
    pointSound.play();
    ball.xDir = -1;
    ball.spawn();
    result[0] = true;
  }
  return result;
}

private void yBallMotion() {
  ball.y += ball.ySpeed*ball.yDir;
  int collisionTop = ball.y - (ball.DIAMETER/2 + world.margin);
  int collisionBottom = height - (ball.DIAMETER/2 + ball.y + world.margin);
  boolean isCollisionTop = collisionTop <= 0;
  boolean isCollisionBottom = collisionBottom <= 0;
  if(isCollisionTop || isCollisionBottom) {
    hitWallSound.play();
    ball.yDir = -ball.yDir;
  }
}
