import processing.javafx.*;

import fisica.*;
FWorld world;
FPlayer player;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

// Mode framework
int mode;

final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;

// reset variable
boolean reset;

// checkpoint variables
float checkpointX, checkpointY;

// dying variables
int deathtimer;
int deathDuration;

// switchblock variables
int effect;
final int jump = 1;
final int speed = 2;
final int death = 3;

// switchBLock effect variables
int jumpBoost, speedBoost;

// switchBlock cooldown
int switchBlockCooldown, switchBlockCooldownAmount;

// portal cooldown
int portalCooldown, portalCooldownAmount;

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
color purple = #B200FF; //bridge
color orange = #FF6A00; // lava
color yellow = #FFD800; // goomba
color gray = #808080; // wall
color lightGray = #C0C0C0; //thwomp
color darkBlue = #0026FF; //hammer bro
color lightGreen = #00FF21; // checkpoints
color switchBlockBrown = #7F3300; // switch block
color portalBlue = #98EAFF; // portal

// PVector arraylist for FPortal locations
ArrayList<PVector> portalLocations;

PFont coolvetica;

// hearts for lives
PImage heart;
PImage halfheart;

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
PImage checkpoint;

// icons for showing effect in switch block
PImage speedicon, jumpicon, deathicon;

//hammer bro hammer
PImage hammer;

PImage map;
PImage daySky;

// intro gif
PImage[] intro;
int numIntroFrames;
int introFrame;

// Portal
PImage[] portal;

// Lava
PImage[] lava;
int numLavaFrames;
int lavaFrame;

// Character
PImage[] shift;
PImage[] idle;
PImage[] jumping;
PImage[] run;
PImage[] action;

// Goomba
PImage[] goomba;

// Thwomp
PImage[] thwomp;

// Hammer Bro
PImage[] hammerbro;

// Switch block
PImage[] switchBlock;

int gridSize = 32;
float zoom = 1.5;
boolean upkey, downkey, leftkey, spacekey, rightkey, wkey, akey, skey, dkey, ekey, ckey, qkey, shiftkey;

void setup() {
  size(800, 800, FX2D);
  frameRate(60);
  smooth(4);

  mode = INTRO;

  textAlign(CENTER, CENTER);
  rectMode(CENTER);

  Fisica.init(this);
  world = new FWorld(-5000, -5000, 5000, 5000);
  world.setGravity(0, 900);
  map = loadImage("map.png");

  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  
  coolvetica = createFont("Coolvetica Hv Comp.otf", 200);

  // PVector arraylist for portals
  portalLocations = new ArrayList<PVector>();

  //checkpoint variables
  checkpointX = 35;
  checkpointY = 74;

  // switch block effect variables
  effect = 0;
  jumpBoost = 0;
  speedBoost = 0;

  // dying timer variables
  deathtimer = 60;
  deathDuration = deathtimer;

  // portal block cooldown variables
  portalCooldown = 0;
  portalCooldownAmount = 60;

  // switch block cooldown variables
  switchBlockCooldown = 400;
  switchBlockCooldownAmount = switchBlockCooldown;

  // GIF VARIABLES
  
  // intro gif
  numIntroFrames = 51;
  intro = new PImage[numIntroFrames];
  
  // lava gif
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

  // loading skies
  daySky = loadImage("daysky.png");

  // loading hearts
  heart = loadImage("heart.png");
  heart.resize(gridSize, gridSize);
  halfheart = loadImage("halfheart.png");
  heart.resize(gridSize, gridSize);

  // loading portal textures
  portal = new PImage[4];
  portal[0] = loadImage("portal0.png");
  portal[0].resize(gridSize, gridSize);
  portal[1] = loadImage("portal1.png");
  portal[1].resize(gridSize, gridSize);
  portal[2] = loadImage("portal2.png");
  portal[2].resize(gridSize, gridSize);
  portal[3] = loadImage("portal3.png");
  portal[3].resize(gridSize, gridSize);

  // load icons
  deathicon = loadImage("deathicon.png");
  deathicon.resize(gridSize * 2, gridSize * 2);
  jumpicon = loadImage("jumpicon.png");
  jumpicon.resize(gridSize * 2, gridSize * 2);
  speedicon = loadImage("speedicon.png");
  speedicon.resize(gridSize * 2, gridSize * 2);

  //loading switch block
  switchBlock = new PImage[3];
  switchBlock[0] = loadImage("switchblock0.png");
  switchBlock[0].resize(gridSize, gridSize);
  switchBlock[1] = loadImage("switchblock1.png");
  switchBlock[1].resize(gridSize, gridSize);
  switchBlock[2] = loadImage("switchblock2.png");
  switchBlock[2].resize(gridSize, gridSize);

  //loading checkpoint
  checkpoint = loadImage("checkpoint.png");
  checkpoint.resize(gridSize, gridSize);

  //loading hammerbro
  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("hammerbro0.png");
  hammerbro[0].resize(gridSize, gridSize);
  hammerbro[1] = loadImage("hammerbro1.png");
  hammerbro[1].resize(gridSize, gridSize);

  //loading hammer of hammerbro
  hammer = loadImage("hammer.png");
  hammer.resize(gridSize, gridSize);

  //loading thwomp
  thwomp = new PImage[2];
  thwomp[0] = loadImage("thwomp0.png");
  thwomp[0].resize(gridSize * 2, gridSize * 2);
  thwomp[1] = loadImage("thwomp1.png");
  thwomp[1].resize(gridSize * 2, gridSize * 2);

  // loading goomba
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);

  //loading the action
  shift = new PImage[2];
  shift[0] = loadImage("shift0.png");
  shift[1] = loadImage("shift1.png");

  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jumping = new PImage[1];
  jumping[0] = loadImage("jump0.png");

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
  
  // loading intro
  int j = 0;
  while (j < numIntroFrames) {
    intro[j] = loadImage("frame_" + j + "_delay-0.12s.gif");
    intro[j].resize(gridSize, gridSize);
    j++;
  }

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
      } else if (c == lightGray) {
        FThwomp thw = new FThwomp(x * gridSize, y * 1.5 * gridSize);
        enemies.add(thw);
        world.add(thw);
      } else if (c == darkBlue) {
        FHammerBro hb = new FHammerBro(x * gridSize, y * gridSize);
        enemies.add(hb);
        world.add(hb);
      } else if (c == lightGreen) {
        FCheckpoint cp = new FCheckpoint(x * gridSize, y * gridSize);
        terrain.add(cp);
        world.add(cp);
      } else if (c == switchBlockBrown) {
        FSwitchBlock sb = new FSwitchBlock(x * gridSize, y * gridSize);
        terrain.add(sb);
        world.add(sb);
      } else if (c == portalBlue) {
        FPortal pt = new FPortal(x * gridSize, y * gridSize);
        terrain.add(pt);
        PVector pv = new PVector(x * gridSize, y * gridSize);
        portalLocations.add(pv);
        world.add(pt);
      }
    }
  }
}



void draw() {
  background(daySky);

  if (mode == INTRO) intro();
  else if (mode == GAME) game();
  else if (mode == PAUSE) pause();
  else if (mode == GAMEOVER) gameOver();
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

  if (portalCooldown > 0) {
    portalCooldown--;
  }
}

void showDisplay() {

  if (player.lives == 4) { // lives
    image(heart, 370, 320);
    image(heart, 410, 320);
  }
  if (player.lives == 3) {
    image(heart, 370, 320);
    image(halfheart, 410, 320);
  }
  if (player.lives == 2) {
    image(heart, 390, 320);
  }
  if (player.lives == 1) {
    image(halfheart, 390, 320);
  }

  if (effect == 1) { // effects
    image(jumpicon, 400, 100);
    text(switchBlockCooldown / 20, 425, 50);
  }
  if (effect == 2) {
    image(speedicon, 400, 100);
    text(switchBlockCooldown / 20, 425, 50);
  }

  if (player.died) {
    deathtimer--;
    image(deathicon, width / 2 - gridSize, 100 + gridSize);
  }
  if (deathtimer == 0) {
    player.died = false;
    deathtimer = deathDuration;
  }
}
