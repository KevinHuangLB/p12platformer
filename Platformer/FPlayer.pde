class FPlayer extends FGameObject {

  int frame;
  int direction;
  int lives;
  boolean newLife;

  FPlayer() {
    super();
    frame = 0;
    direction = R;
    setPosition(35, 74);
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
      setPosition(checkpointX, checkpointY - gridSize);
      setVelocity(0, 0);
      newLife = true;
      lives--;
    } else {
      newLife = false;
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

    if (shiftkey) {
      action = shift;
      setVelocity(0,vy + 60);
    }

    if (akey && !shiftkey) {
      setVelocity(-225, vy);
      action = run;
      direction = L;
    }
    if (dkey && !shiftkey) {
      setVelocity(225, vy);
      action = run;
      direction = R;
    }
    if (spacekey && !shiftkey) {
      setVelocity(vx, -225);
    }
    if (spacekey && akey && !shiftkey) {
      setVelocity(-225, -250);
      direction = L;
    }
    if (spacekey && dkey && !shiftkey) {
      setVelocity(225, -250);
      direction = R;
    }
    if (shiftkey && akey){
      action = shift;
      setVelocity(-125,vy + 30);
    }
    if (shiftkey && dkey){
      action = shift;
      setVelocity(125,vy + 30);
    }
    if (shiftkey && spacekey){
      setVelocity(vx, -120);
    }
    if (abs(vy) > 0.1 && !shiftkey) {
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
      if (direction == L) {
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
