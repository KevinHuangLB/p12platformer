class FPlayer extends FBox {
  FPlayer() {
    super(16, 16);
    setPosition(20, 400);
    setFillColor(red);
    setFriction(1);
    setRotatable(false);
  }
  void show() {
  }

  void act() {
    handleInput();
    checkForCollisions();
  }

  void handleInput() {
    float vx = getVelocityX();
    float vy = getVelocityY();
    if (akey) setVelocity(-250, vy);
    if (dkey) setVelocity(250, vy);
    if (spacekey && isTouching("stone", "ice", "tramp")) setVelocity(vx, -150);
  }

  boolean isTouching(String stone, String ice, String tramp) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains(stone)) return true;
      if (fc.contains(ice)) return true;
      if (fc.contains(tramp)) return true;
    }
    return false;
  }

  void checkForCollisions() {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains("spike")) {
        setPosition(20, 560);
      }
    }
  }
}
