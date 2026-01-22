class FHammerBro extends FGameObject {

  int direction = L;
  int speed = 50;
  int frame = 0;

  FHammerBro(float x, float y) {
    super();
    setPosition(x, y);
    setName("HammerBro");
    setRotatable(false);
  }

  void act() {
    animate();
    collide();
    move();
    throwHammer();
  }

  void animate() {
    if (frame >= hammerbro.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(hammerbro[frame]);
      if (direction == L) attachImage(reverseImage(hammerbro[frame]));
      frame++;
    }
  }

  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX() + direction, getY());
    }
    if (isTouching("player")) {
      if (player.getY() < getY() - gridSize / 1.5) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -350);
      } else {
        player.lives--;
        player.setPosition(35, 10);
      }
    }
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed * direction, vy);
  }

  void throwHammer() {
    if (frameCount % 90 == 0) {
      FBox fb = new FBox(gridSize, gridSize);
      fb.setName("hammer");
      fb.setPosition(getX(), getY());
      fb.attachImage(hammer);
      if (direction == R) fb.setVelocity(300, -300);
      if (direction == L) fb.setVelocity(-300,-300);
      fb.setAngularVelocity(20);
      fb.setSensor(true);
      world.add(fb);
    }
  }
}
