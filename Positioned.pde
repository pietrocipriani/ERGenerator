
class Positioned {
  final float x, y;
  public Positioned (float x, float y) {
    this.x = x;
    this.y = y;
  }
  public Positioned (float x, float y, Positioned relativeTo) {
    this(x + relativeTo.x, y + relativeTo.y);
  }
  void drawDelegate (){}
}
