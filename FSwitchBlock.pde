class FSwitchBlock extends FGameObject {

  int frame;
  int activatedEffect;

  FSwitchBlock(float x, float y) {
    super();
    setPosition(x, y);
    setName("switchBlock");
    setStatic(true);
    setFriction(2);
  }
  void animate() {
    if (frame >= switchBlock.length) frame = 0; // resets frame
    if (frameCount % 60 == 0) {
      if (frame == 0 && isTouching("player") && effect == 0) { // JUMP ANIMATION
        activatedEffect = 1;
        effect = jump;
        attachImage(switchBlock[activatedEffect - 1]);
      } else if (frame == 1 && isTouching("player") && effect == 0) { // SPEED ANIMATION
        effect = speed;
        activatedEffect = 2;
        attachImage(switchBlock[activatedEffect - 1]);
      } else if (frame == 2 && isTouching("player") && effect == 0) { // DEATH ANIMATION
        activatedEffect = 3;
        effect = death;
        attachImage(switchBlock[activatedEffect - 1]);
      }
      if (activatedEffect == 0 || effect == 0) { // NOTHING IS ACTIVATED, KEEP CYCLING
        attachImage(switchBlock[frame]);
      }
      frame++;
    }
  }

  void act() {
    animate();
    effects();
  }
  void effects() { // applies effect and cooldown timer
    if (effect == 0) {
      jumpBoost = 0;
      speedBoost = 0;
    }
    if (effect == jump) {
      jumpBoost = 200;
      switchBlockCooldown--;
    }
    if (effect == speed) {
      speedBoost = 150;
      switchBlockCooldown--;
    }
    if (switchBlockCooldown == 0) {
      activatedEffect = 0;
      effect = 0;
      switchBlockCooldown = switchBlockCooldownAmount;
    }
  }
}
