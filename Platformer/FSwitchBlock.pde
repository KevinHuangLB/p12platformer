class FSwitchBlock extends FGameObject {



  FSwitchBlock(float x, float y) {
    super();
    setPosition(x, y);
    setName("switchBlock");
    attachImage(switchBlock);
    setStatic(true);
    setFriction(2);
  }
}
