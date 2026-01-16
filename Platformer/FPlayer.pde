class FPlayer extends FGameObject {

  int frame;
  int direction;
  int lives;

  FPlayer() {
    super();
    frame = 0;
    direction = R;
    setPosition(35, 10);
    setName("player");
    setFillColor(red);
    setFriction(1);
    setRotatable(false);
    lives = 3;
  }
  void show() {
  }

  void act() {
    input();
    if (isTouching("spike") || isTouching("lava") || isTouching("hammer")) {
      setPosition(checkpointX, checkpointY);
      lives--;
    }
    collisions();
    animate();
  }

  void input() {
    float vx = getVelocityX();
    float vy = getVelocityY();

    if (abs(vy) < 0.1) {
      action = idle;
    }

    if (akey) {
      setVelocity(-250, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      setVelocity(250, vy);
      action = run;
      direction = R;
    }
    if (spacekey) {
      setVelocity(vx, -250);
    }
    if (spacekey && akey) {
      setVelocity(-250, -250);
      direction = L;
    }
    if (spacekey && dkey) {
      setVelocity(250, -250);
      direction = R;
    }
    if (abs(vy) > 0.1) {
      action = jump;
    }
  }

  void collisions() {
  }

  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) {
        attachImage(action[frame]);
      }
      if (direction == L){
        attachImage(reverseImage(action[frame]));
      }
      frame++;
    }
  }


  // stop double jumping below

  //boolean isTouching(String stone, String ice, String tramp) {
  //  ArrayList<FContact> contacts = getContacts();
  //  for (int i = 0; i < contacts.size(); i++) {
  //    FContact fc = contacts.get(i);
  //    if (fc.contains(stone)) return true;
  //    if (fc.contains(ice)) return true;
  //    if (fc.contains(tramp)) return true;
  //  }
  //  return false;
  //}
}
