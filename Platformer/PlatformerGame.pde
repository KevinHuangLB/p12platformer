import processing.javafx.*;

import fisica.*;
FWorld world;
FPlayer player;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

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
color orange = #FF6A00;
color yellow = #FFD800;
color gray = #808080;
color lightGray = #A0A0A0;

PImage stone;
PImage ice;
PImage tramp;
PImage spike;
PImage treeLog;
PImage treeIntersect;
PImage treeMiddle;
PImage treeEndEast;
PImage treeEndWest;
PImage bridge;

PImage map;

// Lava
PImage[] lava;
int numLavaFrames;
int lavaFrame;

// Character
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;

// Goomba
PImage[] goomba;

// Thwomp
PImage[] thwomp;


int gridSize = 32;
float zoom = 1.5;
boolean upkey, downkey, leftkey, spacekey, rightkey, wkey, akey, skey, dkey, ekey, qkey;

void setup() {
  size(800, 800, FX2D);
  frameRate(60);

  Fisica.init(this);
  world = new FWorld(-5000, -5000, 5000, 5000);
  world.setGravity(0, 900);
  map = loadImage("map.png");

  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();

  // GIF VARIABLES
  numLavaFrames = 6;
  lava = new PImage[numLavaFrames];

  // loading texture images
  action = idle;
  loadImages();
  loadWorld(map);

  player = new FPlayer();
  world.add(player);
}

void loadImages() {

  //loading thwomp
  thwomp = new PImage[2];
  thwomp[0] = loadImage("thwomp0.png");
  thwomp[0].resize(gridSize, gridSize);
  thwomp[1] = loadImage("thwomp1.png");
  thwomp[1].resize(gridSize, gridSize);

  // loading goomba
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);

  //loading the action
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");

  // loading lava
  int i = 0;
  while (i < numLavaFrames) {
    lava[i] = loadImage("lava" + i + ".png");
    lava[i].resize(gridSize, gridSize);
    i++;
  }

  //loading goomba

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

  bridge = loadImage("bridge.png");
  bridge.resize(gridSize, gridSize);
}

void loadWorld(PImage img) {
  world = new FWorld(-5000, -5000, 5000, 5000);
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
      b.setFriction(2);

      if (c == black) {
        b.attachImage(stone);
        b.setName("stone");
        world.add(b);
      } else if (c == gray) {
        b.attachImage(stone);
        b.setName("wall");
        world.add(b);
      } else if (c == iceBlue) {
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      } else if (c == trampPink) {
        b.attachImage(tramp);
        b.setRestitution(1.5);
        b.setName("tramp");
        world.add(b);
      } else if (c == red) {
        b.attachImage(spike);
        b.setName("spike");
        world.add(b);
      } else if (c == treeBrown) {
        b.attachImage(treeLog);
        b.setSensor(true);
        b.setName("treeLog");
        world.add(b);
      } else if (c == treeGreen && s == treeBrown) {
        b.attachImage(treeIntersect);
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
      } else if (c == purple) {
        FBridge br = new FBridge(x * gridSize, y * gridSize);
        terrain.add(br);
        world.add(br);
      } else if (c == orange) {
        FLava lv = new FLava(x * gridSize, y * gridSize, int(random(0, 6)));
        terrain.add(lv);
        world.add(lv);
      } else if (c == yellow) {
        FGoomba gmb = new FGoomba(x * gridSize, y * gridSize);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c = lightGray) {
        FThwomp thw = new FThwomp(x * gridSize, y * gridSize);
        enemies.add(thw);
        world.add(thw);
      }
    }
  }
}

void draw() {
  background(black);
  text("Player x:" + player.getX(), 50, 50);
  text("Player y:" + player.getY(), 50, 100);
  text("Player lives: " + player.lives, 50, 150);

  drawWorld();
  actWorld();
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX() * zoom + width/2, -player.getY() * zoom + height/2);
  scale(zoom);

  world.step();
  world.draw();
  popMatrix();
}

void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }

  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}
