import java.lang.Math;
import java.util.Random;
import processing.sound.*;

public class Ball {
    public int x;
    public int y;
    public final int DIAMETER;
    public int xSpeed;
    public int ySpeed;
    public int xDir;
    public int yDir;
    public int[] ballColor;
    

    public Ball(int ballPos, int DIAMETER, int xSpeed, int ySpeed, int xDir, int yDir, int[] ballColor) {
        this.x = ballPos;
        this.y = ballPos;
        this.DIAMETER = DIAMETER;
        this.xSpeed = xSpeed;
        this.ySpeed = ySpeed;
        this.xDir = xDir;
        this.yDir = yDir;
        this.ballColor = ballColor;
    }
    
    public void spawn() {
      x = width/2;
      y = (int)random(height);
      
      Random rand = new Random();
      yDir = (int)Math.pow(-1, rand.nextInt(3) + 1);
    }
    
    public void refresh() {
      stroke(ballColor[0], ballColor[1], ballColor[2]);
      fill(ballColor[0], ballColor[1], ballColor[2]);
      ellipse(x, y, DIAMETER, DIAMETER);
    }
}
