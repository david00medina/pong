public class World {
  public int margin;
  public int background;
  public int[] elementColor;
  public int netLines;
  public int score1;
  public int xScore1;
  public int yScore1;
  public int score2;
  public int xScore2;
  public int yScore2;
  public int scoreSize;
  public int fps;
  
  public World(int background, int[] elementColor, int margin, int netLines, int fps, int xScore1, int yScore1, int xScore2, int yScore2, int scoreSize) {
    this.background = background;
    this.elementColor = elementColor;
    this.margin = margin;
    this.netLines = netLines;
    this.fps = fps;
    
    score1 = 0;
    this.xScore1 = xScore1;
    this.yScore1 = yScore1;
    
    score2 = 0;
    this.xScore2 = xScore2;
    this.yScore2 = yScore2;
    
    this.scoreSize = scoreSize;
  }
  
  public void refresh() {
    stroke(elementColor[0], elementColor[1], elementColor[2]);
    fill(elementColor[0], elementColor[1], elementColor[2]);
    frameRate(fps);
    buildWorld();
    buildNet();
    buildScore();
  }
  
  private void buildWorld() {
    background(background);
    strokeWeight(margin);
    line(0,0,width,0);
    line(0,height,width,height);
  }
  
  private void buildNet() {
    for(int i = 0; i < netLines; i++) {
      int startY = i*(height/(netLines*2) + netLines);
      int endY = startY + height/(netLines*2);
      line(width/2, startY, width/2, endY);
    }
  }
  
  private void buildScore() {
    textSize(scoreSize);
    text(score1, xScore1, yScore1);
    text(score2, xScore2, yScore2);
  }
  
  public void refreshScore(int i) {
    switch(i) {
      case 1:
        score1++;
        break;
      case 0:
        score2++;
        break;
    }
  }
}
