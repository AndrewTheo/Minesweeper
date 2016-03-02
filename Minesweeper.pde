import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20

public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int BOMBS = 25;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

public boolean gameOver = false;


void setup ()
{
    size(400, 450);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r<NUM_ROWS; r++)
    {
        for(int c = 0; c<NUM_COLS; c++)
        {
            buttons[r][c] = new MSButton(r, c);
        }
    }
    
    
bombs = new ArrayList<MSButton>();
    //declare and initialize buttons
    setBombs();
}
public void setBombs()
{
while (bombs.size() < BOMBS) 
  {    
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if(!bombs.contains(buttons[r][c]))
      bombs.add(buttons[r][c]);
  }

}

public void draw ()
{
    background( 0 );
    if (gameOver)
      displayLosingMessage();
    
    
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    text("You Win!", 200, 425);
     for(int i = 0; i < NUM_ROWS; i++)
    {
    for(int j = 0; j < NUM_COLS; j++)
      if(!bombs.contains(buttons[i][j]) && !buttons[i][j].isClicked())
        return false;
    }  
    return true;
}
public void displayLosingMessage()
{
    //your code here
   
    fill(255);
  text("Game Over", 200, 425);
  for(int i = 0; i < NUM_ROWS; i++)
    for(int j = 0; j < NUM_COLS; j++)
      buttons[i][j].mousePressed();
    
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
    if (mouseButton == RIGHT)
    {
      marked = !marked;
      return;
    }
    clicked = true;
    if (bombs.contains(this))
        gameOver = true;
    else if (countBombs(r, c) != 0)
      setLabel("" + (countBombs(r, c)));
    else
    {
      for(int i = -1; i < 2; i++)
      {
        for (int j = -1; j < 2; j++)
        {
          if((i != 0 || j != 0) && isValid(r + i, c + j) && !buttons[r + i][c + j].isClicked())
            buttons[r + i][c + j].mousePressed();
        }
      }
    }
        
        
        
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if(clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r < NUM_ROWS && c < NUM_COLS && r >= 0 && c >= 0)
        {
             return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        //your code here
        int numBombs = 0;
        
    for(int i = -1; i < 2; i++)
    {
      for (int j = -1; j < 2; j++)
      {
        if((i != 0 || j != 0) && isValid(row + i, col + j) && bombs.contains(buttons[row + i][col + j]))
          numBombs++;
      }
    }
    return numBombs;

    }
    
    
}

