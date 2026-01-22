void gameOverClicks(){
  mode = INTRO;
  reset = true;
  player.lives = 4;
  checkpointX = 32;
  checkpointY = 74;
  actWorld();
  drawWorld();
  showDisplay();    
}

void gameOver(){
  background(black);
  // add reset lives
}
