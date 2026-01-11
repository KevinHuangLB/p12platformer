class FLava extends FGameObject {
  
  int lavaFrame;
    
  FLava(float x, float y, int lf) {
    super();
    setPosition(x, y);
    setName("lava");
    lavaFrame = lf;
    attachImage(lava[lavaFrame]);
    setStatic(true);
  }

  void act() {
    if (frameCount % 10 == 0)lavaFrame++;
    if (lavaFrame == numLavaFrames) lavaFrame = 0;
    attachImage(lava[lavaFrame]);
  }
}
