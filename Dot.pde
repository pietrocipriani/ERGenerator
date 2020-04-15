
class Dot extends Positioned {
  final boolean primary;
  public Dot (float x, float y, boolean primary, Positioned relativeTo) {
    super (x, y, relativeTo);
    this.primary = primary;
  }
  
  @Override
  void drawDelegate () {
    stroke (borderColor);
    if (primary) fill (borderColor);
    else fill (0xFFFFFFFF);
    circle(x, y, 10);
  }
}
