public class Caption {
 
  private int x;
  private int y;
  private int width;
  private int height;
  
  final int Y_AXIS = 1;
  final int X_AXIS = 2;
  
  // GUI
  private Slider minPopSlider;
  private Slider maxPopSlider;
  
  private final int margin = 70;
  
  public Caption(int x, int y, int width, int height, ControlP5 controller){
    this.x = x;
    this.y = y;
    
    this.width = width;
    this.height = height;
    
    // min max default x y width height
    minPopSlider = controller.addSlider("minPopDisp", 0, 70000, 10000, x+margin-20, y+margin+350, 300, 20);
    maxPopSlider = controller.addSlider("maxPopDisp", 100000, 2200000, 2200000, x+margin-20, y+margin+450, 300, 20);
  }
  
  public int getWidth(){
    return width;
  }
  
  public int getMinPopValue(){
    return int(minPopSlider.getValue());
  }
  
  public int getMaxPopValue(){
    return int(maxPopSlider.getValue());
  }
  
  public void draw(){
    
    colorMode(RGB, 255, 255, 255);
    fill(255, 255, 255);
    rect(x+20, y+20, width-40, height-40);
    
    fill(0);
    textSize(28);
    text("Caption", x+margin, margin);
    textSize(14);
    text("Population amount (persons) :", x+margin, margin+80);
    fill(255);
    ellipse(x+margin+20, margin+130, 3, 3);
    ellipse(x+margin+80, margin+130, 14, 14);
    ellipse(x+margin+140, margin+130, 54, 54);
    ellipse(x+margin+240, margin+130, 95, 95);
    
    fill(0);
    text("Population density (persons/km^2) :", x+margin, margin+200); //<>//
    setGradient(x+margin, margin+210, 250, 20, color(191,234,255), color(0,88,132), X_AXIS);
    
    text("Minimum population to display (persons) :", x+margin, margin+340);
    text("Maximum population to display (persons) :", x+margin, margin+440);
    
    textSize(10);
    text("10000", x+margin+5, margin+150);
    text("50000", x+margin+65, margin+150);
    text("450 000", x+margin+120, margin+170);
    text("800 000", x+margin+220, margin+130);
    
    text("300", x+margin-10, margin+240);
    text("2 400", x+margin+240, margin+240);
  }
  
  public void describe(City c){
    
    int offset = 600;
    
    fill(0, 0, 0);
    textSize(20);
    text(c.getName(), x+margin, margin+offset);
    textSize(14);
    text(" - Population amount : " + int(c.getPopulation()) + " persons", x+margin, margin+offset+30);
    text(" - Population density : " + int(c.getDensity()) + " persons/km^2", x+margin, margin+offset+60);
    text(" - Altitude : " + int(c.getAltitude()) + " meters", x+margin, margin+offset+90);
  }
  
  private void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

    noFill();
  
    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    }  
    else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
  
}