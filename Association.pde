
class Association extends Positioned{
  final String name;
  
  public Association (String name, float x, float y, Positioned relativeTo) {
    super (x, y, relativeTo);
    this.name = name;
  }
  
  @Override
  void drawDelegate () {
    fill (0xFFFFFFFF);
    stroke (borderColor);
    quad(x, y-kHEIGHT/2,
      x-kWIDTH/2, y,
      x, y+kHEIGHT/2,
      x+kWIDTH/2, y
    );
    
    textAlign (CENTER, CENTER);
    fill (0xFF000000);
    text(name, x, y);
  }
}
