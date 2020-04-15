
class Link {
  final Positioned from, to;
  final boolean direct;
  final Direction priority;
  
  
  public Link (Positioned from, Positioned to) {
    this.from = from;
    this.to = to;
    direct = false;
    this.priority = Direction.VERTICAL;
  }
  public Link (Positioned from, Positioned to, Direction priority) {
    this.from = from;
    this.to = to;
    direct = false;
    this.priority = priority;    
  }
  public Link (Positioned from, Positioned to, boolean direct) {
    this.from = from;
    this.to = to;
    this.direct = direct;
    this.priority = Direction.VERTICAL;
  }
  
  void drawDelegate () {
    stroke (borderColor);
    if (direct) {
      line (from.x, from.y, to.x, to.y);
    } else {
      line (from.x, from.y, priority == Direction.VERTICAL ? from.x : to.x, priority == Direction.HORIZONTAL ? from.y : to.y);
      line (priority == Direction.VERTICAL ? from.x : to.x, priority == Direction.HORIZONTAL ? from.y : to.y, to.x, to.y);
    }
  }
}

enum Direction {VERTICAL, HORIZONTAL};
