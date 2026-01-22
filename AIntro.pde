void introClicks() {
  mode = GAME;
}
void intro() {
  background(black);
  textFont(coolvetica);
  if (frameCount % 8 == 0)introFrame++;
  if (introFrame == numIntroFrames) introFrame = 0;
  image(intro[introFrame], 0, 0, width, height);
  text("Platformer", 400, 300);
  textSize(80);
  text("Click to begin", 400, 500);
}
