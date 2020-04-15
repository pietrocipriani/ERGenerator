final static int borderColor = 0xFF0000AA;
final static int fillColor = 0xFFEEEEFF;


Positioned TL = new Positioned(0, 0);
Positioned BR = new Positioned(1000+TL.x, 600+TL.y);
Positioned TR = new Positioned(BR.x, TL.y);
Positioned BL = new Positioned(TL.x, BR.y);

int showSaved = 0;

final static float kWIDTH = 150.0, kHEIGHT = 50.0;

final HashMap<String, Positioned> positions = new HashMap();

final ArrayList<Link> links = new ArrayList();


void setup () {
  size(1000, 600);
  
  frameRate(30);
  strokeWeight(2);
  textSize(15);
  positions.put("TL", TL);
  positions.put("TR", TR);
  positions.put("BL", BL);
  positions.put("BR", BR);
  parse();
}

void draw () {
  background(0xFFFFFFFF);
  
  for (Link link : links)
    link.drawDelegate();
    
  for (Positioned positioned : positions.values()) positioned.drawDelegate();
  
  if (showSaved > 0) {
    fill (0xFF000000);
    rect (500, 300, kWIDTH, kHEIGHT);
    fill (0xFFFFFFFF);
    textAlign(CENTER, CENTER);
    text ("SAVED", 500, 300);
    showSaved--;
  }
  
}

void keyPressed () {
  if (key == 's') {
    save("screenCap.png");
    showSaved = 45;
  } else if (key == 'r') {
    links.clear();
    positions.clear();
    parse();
  }
}
