int cellSize = 5;

int[][] curGrid;
int[][] nextGrid;

boolean showGrid = false;
boolean paused = false;

color c1 = color(0, 213, 255);
color c2 = color(83, 240, 93);
color fillC = c1;

boolean mouseDown = false;

void setup()
{
  size(800, 800);
  curGrid = new int[width / cellSize][height / cellSize];
  // nextGrid = new int[width / cellSize][height / cellSize];
  
  drawGrid(curGrid);
  delay(300);
  curGrid = updateGrid(curGrid);
  drawGrid(curGrid);
}

void draw()
{
  if (mouseDown)
  {
    if (mouseX > 0 && mouseY > 0 && mouseX < width && mouseY < height)
    {
      int indX = floor(mouseX / cellSize);
      int indY = floor(mouseY / cellSize);
      
      curGrid[indX][indY] = 1;
    }
  }
  if (!paused)
  {
    delay(10);
    curGrid = updateGrid(curGrid);
    drawGrid(curGrid);
  }
}

int[][] updateGrid(int[][] grid)
{
  int[][] output = new int[grid.length][grid.length]; 
  for (int i = 0; i < grid.length; i++)
  {
    for (int j = 0; j < grid[i].length; j++)
    {
      if (grid[i][j] == 1){
        if (i < (grid.length - 1) && j < (grid[i].length - 1))
        {
          int[] neighbors = {grid[i-1][j+1], grid[i][j+1], grid[i+1][j+1]};
          if (neighbors[1] == 0)
            output[i][j+1] = 1;
          else if (neighbors[1] == 1)
          {
            if (neighbors[0] == 1 && neighbors[2] == 1)
              output[i][j] = 1;
            else if (neighbors[0] == 1 && neighbors[2] == 0)
              output[i+1][j+1] = 1;
             else if (neighbors[2] == 1 && neighbors[0] == 0)
              output[i-1][j+1] = 1;
             else if (neighbors[0] == 0 && neighbors[2] == 0)
             {
               int rand = int(round(random(1)));
               if (rand == 1)
                 output[i-1][j+1] = 1;
               else
                 output[i+1][j+1] = 1;
             }
          }
      }
      else
        output[i][j] = 1;
      }
    }
  }
  return output;
}

void drawGrid(int[][] grid)
{
  background(0);  
  for (int i = 0; i < grid.length; i++)
  {
    for (int j = 0; j < grid[i].length; j++)
    {
      if (grid[i][j] == 0)
      {
        noFill();
        if (showGrid)
        {
          stroke(fillC);
          strokeWeight(0.5);
        }
         else
          noStroke();
          
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      }
      else if (grid[i][j] == 1)
      {
        fill(fillC);
        noStroke();
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      }
    }
  }
}

void keyPressed()
{
  if (key == 'g')
     showGrid = !showGrid;
  if (key == ' ')
    paused = !paused;
  if (key == 'f')
  {
     if (fillC == c1)
       fillC = c2;
     else
       fillC = c1;
  }
}
void mousePressed()
{
  mouseDown = true;
}
void mouseReleased()
{
  mouseDown = false;
}
