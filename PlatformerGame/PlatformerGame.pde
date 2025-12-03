import fisica.*;
FWorld world;

color white = #FFFFFF;
color black = #000000;

PImage map;
int gridSize = 25;

void setup() {
  size(800, 800);
  Fisica.init(this);
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  map = loadImage("map.png");

  for (int y = 0; y < map.height; y++) {
    for (int x = 0; x < map.width; x++) {
      color c = map.get(x, y);
      if (c == black) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x * gridSize, y * gridSize);
        b.setStatic(true);
        world.add(b);
      }
    }
  }
}

void draw() {
  world.step();
  world.draw();
}
