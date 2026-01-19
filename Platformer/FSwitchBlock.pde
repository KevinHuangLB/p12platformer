class FSwitchBlock extends FGameObject {

  int frame;
  int cooldown;

  FSwitchBlock(float x, float y) {
    super();
    setPosition(x, y);
    setName("switchBlock");
    setStatic(true);
    setFriction(2);
  }
  void animate() {
    if (frame >= switchBlock.length) frame = 0;
    if (frameCount % 60 == 0) {
      if (frame == 0 && isTouching("player")) effect = jump;
      else if (frame == 1 && isTouching("player")) effect = speed;
      else if (frame == 2 && isTouching("player")) effect = death;
      attachImage(switchBlock[frame]);
      frame++;
    }
  }

  void act() {
    animate();
    if (effect == jump) {
      jumpBoost = 200;        // ADD COOLDOWN FOR THE EFFECTS
      cooldown--;
    }
    if (effect == speed) {
      speedBoost = 150;
      cooldown--;
    }
    if (effect == death) {
      checkpointX = 32;
      checkpointY = 74;
    }
  }
}
