class FPlayer extends FGameObject {
  FPlayer() {
    super();
    setPosition(20, 0);
    setName("player");
    setFillColor(red);
    setFriction(1);
    setRotatable(false);
  }
  void show() {
  }

  void act() {
    handleInput();
    if (isTouching("spike") || isTouching("lava")) {
      setPosition(20, 6);
    }
  }

  void handleInput() {
    float vx = getVelocityX();
    float vy = getVelocityY();
    if (akey) setVelocity(-200, vy);
    if (dkey) setVelocity(200, vy);
    if (spacekey) setVelocity(vx, -200);
    if (spacekey && akey) setVelocity(-200,-200);
        if (spacekey && dkey) setVelocity(200,-200);
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
