
class Entity extends Positioned{
  final String name;
  
  public Entity (String name, float x, float y, Positioned relativeTo) {
    super (x, y, relativeTo);
    this.name = name;
  }
  
  @Override
  void drawDelegate () {
    rectMode (CENTER);
    fill (fillColor);
    stroke (borderColor);
    rect(x, y, kWIDTH, kHEIGHT);
    
    textAlign (CENTER, CENTER);
    fill (0xFF000000);
    text(name, x, y);
  }
}
