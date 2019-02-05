public class Player {
    public int x1;
    public int y1;
    public int x2;
    public int y2;
    public int speed;
    public int[] playerColor;
    public int margin;

    public Player(int x1, int y1, int x2, int y2, int margin, int speed, int[] playerColor) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
        this.margin = margin;
        this.speed = speed;
        this.playerColor = playerColor;
    }
    
    public void refresh() {
      stroke(playerColor[0], playerColor[1], playerColor[2]);
      fill(playerColor[0], playerColor[1], playerColor[2]);
      
      if(y1 > height) y1 = height-y2;
      else if(y1 < 0) y1 = 0;
      
      rect(x1, y1, x2, y2);
    }
}
