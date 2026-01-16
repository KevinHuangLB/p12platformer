class FThwomp extends FGameObject {

  int speed, cooldown;
  boolean falling, rising, onCooldown;

  FThwomp(float x, float y) {
    super(2);
    setPosition(x, y);
    setName("thwomp");
    setStatic(true);
    setRotatable(false);
    falling = false;
    rising = false;
    cooldown = 41;
  }

  void act() {
    move();
    animate();
    collide();
  }

  void animate() {
    if (falling && !onCooldown) {
      attachImage(thwomp[1]);
    } else {
      attachImage(thwomp[0]);
    }
  }

  void collide() {
    if (isTouching("player")) {
      player.lives--;
      player.setPosition(35, 10);
    }
  }

  void move() {
    if (!falling && !rising) {
      if (abs(player.getX() - getX()) < gridSize) {
        falling = true;
        rising = false;
        setStatic(false);
      }
    }
    if (falling) {
      if (isTouching("wall")) {
        onCooldown = true;
        cooldown--;
        if (cooldown < 0) {
          rising = true;
          falling = false;
          onCooldown = false;
          cooldown = 41;
        }
      }
      //if (!(abs(player.getX() - getX()) < gridSize)) { DETECTION FOR BACKING OUT IF PLAYER NO LONGER UNDER
      //  falling = false;
      //  rising = true;
      //}
    }
    if (rising) {
      setVelocity(0, -500);
      if (isTouching("stone")) {
        println("touched stone");
        setStatic(true);
        rising = false;
      }
      if (abs(player.getX() - getX()) < gridSize && !(player.getY() < getY() - gridSize / 1.5)) {
        rising = false;
        falling = true;
      }
    }
  }
}
