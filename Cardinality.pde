
class Cardinality extends Positioned {
  final int position;
  final String cardinality;
  
  public Cardinality (String cardinality, int position, Association relativeTo) {
    super (0, 0, relativeTo);
    this.position = position;
    this.cardinality = cardinality;
  }
  
  @Override
  void drawDelegate () {
    fill (0xFF000000);
    float dx = 0, dy = 0;
    switch (position) {
      case TOP:
        textAlign(LEFT, BOTTOM);
        dy = -kHEIGHT/2-10;
        dx = 10;
        break;
      case BOTTOM:
        textAlign(LEFT, TOP);
        dy = kHEIGHT/2+10;
        dx = 10;
        break;
      case RIGHT:
        textAlign(LEFT, BOTTOM);
        dy = -10;
        dx = kWIDTH/2+10;
        break;
      case LEFT:
        textAlign(RIGHT, BOTTOM);
        dy = -10;
        dx = -kWIDTH/2-10;
        break;
    }
    text(toString(), x+dx, y+dy);
  }
  
  @Override
  public String toString () {
    return "("+cardinality+")"; 
  }
}
