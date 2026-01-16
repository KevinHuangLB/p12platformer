class FCheckpoint extends FGameObject {

  FCheckpoint(float x, float y) {
    super();
    setPosition(x, y);
    setName("checkpoint");
    attachImage(checkpoint);
    setStatic(true);
  }

  void act() {
    if (ckey){
     checkpointX = 35;
     checkpointY = 10;
    }
    if (isTouching("player")){
      checkpointX = getX();
      checkpointY = getY();
    }
  }
}
