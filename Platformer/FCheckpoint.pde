class FCheckpoint extends FGameObject {

  boolean cKeyToggle;
  float cKeyCheckpointX, cKeyCheckpointY;
  boolean activated, deactivated;

  FCheckpoint(float x, float y) {
    super();
    setPosition(x, y);
    setName("checkpoint");
    attachImage(checkpoint);
    setStatic(true);
    setFriction(2);
  }

  void act() {
    if (player.newLife){
     cKeyToggle = false; 
    }
    if (!activated) {
      if (isTouching("player") && !cKeyToggle) {
        checkpointX = getX();
        checkpointY = getY();
        activated = true;
        if (ckey) {
          cKeyToggle = true;
          checkpointX = 32;
          checkpointY = 74;
          activated = false;
        }
      }
    }
    if (activated) {
      if (ckey) {
        cKeyToggle = true;
        checkpointX = 32;
        checkpointY = 74;
        activated = false;
      }
    }
  }
}
