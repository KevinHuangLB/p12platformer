import fisica.*;
FWorld world;
FPlayer player;
color white = #FFFFFF;
color black = #000000;
color brown = #996633;
color red = #FF0000;
color green = #00FF00;
color blue = #0000FF;
color iceBlue = #00FFFF;
color trampPink = #FF00DC;
color treeBrown = #964B00;
color treeGreen = #2D9900;
color purple = #B200FF;

PImage stone;
PImage ice;
PImage tramp;
PImage spike;
PImage treeLog;
PImage treeIntersect;
PImage treeMiddle;
PImage treeEndEast;
PImage treeEndWest;

PImage map;

int gridSize = 16;
float zoom = 1.25;
boolean upkey, downkey, leftkey, spacekey, rightkey, wkey, akey, skey, dkey, ekey, qkey;

void setup() {
  size(800, 800);
  Fisica.init(this);
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  map = loadImage("map.png");
  loadImages();
  loadWorld(map);

  player = new FPlayer();
  world.add(player);
}

void loadImages() {
  stone = loadImage("stone.png");
  stone.resize(gridSize, gridSize);

  ice = loadImage("ice.png");
  ice.resize(gridSize, gridSize);

  tramp = loadImage("trampoline.png");
  tramp.resize(gridSize, gridSize);

  spike = loadImage("spike.png");
  spike.resize(gridSize, gridSize);

  treeLog = loadImage("tree_trunk.png");
  treeLog.resize(gridSize, gridSize);

  treeIntersect = loadImage("tree_intersect.png");
  treeIntersect.resize(gridSize, gridSize);

  treeMiddle = loadImage("treetop_center.png");
  treeMiddle.resize(gridSize, gridSize);

  treeEndEast = loadImage("treetop_e.png");
  treeEndEast.resize(gridSize, gridSize);

  treeEndWest = loadImage("treetop_w.png");
  treeEndWest.resize(gridSize, gridSize);
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {

      color c = img.get(x, y); // color of current pixel
      color s = img.get(x, y+1); //color below current pixel
      color w = img.get(x-1, y); // color left of current pixel
      color e = img.get(x+1, y); // color east of current pixel

      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x * gridSize, y * gridSize);
      b.setStatic(true);

      if (c == black) {
        b.attachImage(stone);
        b.setFriction(14);
        b.setName("stone");
        world.add(b);
      } else if (c == iceBlue) {
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      } else if (c == trampPink) {
        b.attachImage(tramp);
        b.setFriction(14);
        b.setRestitution(3);
        b.setName("tramp");
        world.add(b);
      } else if (c == red) {
        b.attachImage(spike);
        b.setFriction(0);
        b.setName("spike");
        world.add(b);
      } else if (c == treeBrown) {
        b.attachImage(treeLog);
        b.setFriction(0);
        b.setSensor(true);
        b.setName("treeLog");
        world.add(b);
      } else if (c == treeGreen && s == treeBrown) {
        b.attachImage(treeIntersect);
        b.setFriction(0);
        b.setSensor(true);
        b.setName("treetop");
        world.add(b);
      } else if (c == treeGreen && w == treeGreen && e == treeGreen) {
        b.attachImage(treeMiddle);
        b.setName("treetop");
        world.add(b);
      } else if (c == treeGreen && w != treeGreen) {
        b.attachImage(treeEndWest);
        b.setName("treetop");
        world.add(b);
      } else if (c == treeGreen && e != treeGreen) {
        b.attachImage(treeEndEast);
        b.setName("treetop");
        world.add(b);
      }
    }
  }
}

  void draw() {
    background(white);
    fill(black);
    text("Player x:" + player.getX(), 50, 50);
    text("Player y:" + player.getY(), 50, 100);
    pushMatrix();
    translate(-player.getX() * zoom + width/2, -player.getY() * zoom + height/2);
    scale(zoom);
    world.step();
    world.draw();
    popMatrix();
    player.act();
  }
