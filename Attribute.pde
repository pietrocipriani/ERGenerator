
class Attribute extends Dot {
  final String name;
  final int labelPosition;
  
  public Attribute (String name, int labelPosition, float x, float y, boolean primary, Positioned relativeTo) {
    super (x, y, primary, relativeTo);
    this.name = name;
    this.labelPosition = labelPosition;
  }
  public Attribute (String name, int labelPosition, float x, float y, Positioned relativeTo) {
    this (name, labelPosition, x, y, false, relativeTo);
  }
  public Attribute (String name, float x, float y, boolean primary, Positioned relativeTo) {
    this (name, LEFT, x, y, primary, relativeTo);
  }
  public Attribute (String name, float x, float y, Positioned relativeTo) {
    this (name, LEFT, x, y, false, relativeTo);
  }
  
  @Override
  void drawDelegate () {
    super.drawDelegate(); 
    fill (0xFF000000);
    float dx = 0, dy = 0;
    switch (labelPosition) {
      case TOP:
        textAlign(CENTER, BOTTOM);
        dy = -10;
        break;
      case BOTTOM:
        textAlign(CENTER, TOP);
        dy = 10;
        break;
      case RIGHT:
        textAlign(LEFT, CENTER);
        dx = 10;
        break;
      case LEFT:
        textAlign(RIGHT, CENTER);
        dx = -10;
        break;
    }
    text(name, x + dx, y + dy);
  }
}
