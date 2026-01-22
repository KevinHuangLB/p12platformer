void gameClicks() {
  
}

void game() {
  
  if (player.lives == 0){
   mode = GAMEOVER; 
  }
  
  actWorld();
  drawWorld(); //order of these two were changed, above one
  showDisplay();
}
