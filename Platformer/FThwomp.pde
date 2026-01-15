class FThwomp extends FGameObject {

  int speed;
  boolean falling, rising;

  FThwomp(float x, float y) {
    super();
    setPosition(x, y);
    setName("thwomp");
    setStatic(true);
    setRotatable(false);
    falling = false;
    rising = false;
  }

  void act() {
    move();
    animate();
    collide();
  }

  void animate() {
    if (rising) attachImage(thwomp[1]);
    else attachImage(thwomp[0]);
  }

  void collide() {
    if (isTouching("player")) {
      player.lives--;
      player.setPosition(35, 10);
    }
  }

  void move() {
    if (!falling && !rising) {
      println("idle");
      if (abs(player.getX() - getX()) < gridSize) {
        falling = true;
        rising = false;
        setStatic(false);
      }
    }
    if (falling) {
      println("falling");
      if (isTouching("wall")) {
        rising = true;
        falling = false;
      }
    }
    if (rising) {
      println("rising");
      setVelocity(0, -300);
      if (isTouching("stone")) {
        println("touched stone");
        setStatic(true);
        rising = false;
      }
    }
  }
}
