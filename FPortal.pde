class FPortal extends FGameObject {

  int frame, randomIndex, previousRandom;

  FPortal(float x, float y) {
    super();
    setPosition(x, y);
    setName("portal");
    setStatic(true);
    setFriction(2);
    randomIndex = int(random(0, portalLocations.size()));
    previousRandom = randomIndex;
  }
  void act() {
    animate();
    behave();
  }

  void animate() {
    if (frame >= switchBlock.length) frame = 0; // resets frame
    if (frameCount % 8 == 0) { // slows down animation
      attachImage(portal[frame]);
    }
    frame++;
  }

  void behave() {
    // when scanning image, create n ew pvector array of all portal values, then teleport to a random index in array
    if (isTouching("player") && portalCooldown == 0) {
      portalCooldown = portalCooldownAmount;
      randomIndex = int(random(0,portalLocations.size()));
      player.setPosition(portalLocations.get(randomIndex).x, portalLocations.get(randomIndex).y - gridSize);
      previousRandom = randomIndex;
      randomIndex = int(random(0, portalLocations.size()));
      while (randomIndex == previousRandom) {
        randomIndex = int(random(0, portalLocations.size()));
      }
    }
  }
}
