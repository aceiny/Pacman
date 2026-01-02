class Game {
    private int score;
    private int lives;
    private boolean gameOver;
    private int powerModeFrames = 0;
    private int ghostsEatenThisPower = 0;
    private boolean hasGotExtraLife = false;
    Board board;
    
    Game(Board board){
        this.board = board;
        score = START_SCORE;
        lives = START_LIVES;
        gameOver = false;
    }
    
    int getScore(){
        return score;
    }
    
    void setScore(int s) {
        score = s;
    }
    
    int getLives(){
        return lives;
    }
    
    void setLives(int l) {
        lives = l;
    }
    
    boolean isPowerMode(){
        return powerModeFrames > 0;
    }
    
    void activatePowerMode(){
        powerModeFrames = POWER_MODE_DURATION;
        ghostsEatenThisPower = 0;
    }
    
    void updatePowerMode(){
        if(powerModeFrames > 0){
            powerModeFrames--;
            if(powerModeFrames == 0) {
                ghostsEatenThisPower = 0;
            }
        }
    }
    
    int getPowerModeFrames(){
        return powerModeFrames;
    }
    
    void setPowerModeFrames(int frames) {
        powerModeFrames = frames;
    }
    
    void decreaseLives(){
        lives -= 1;
        if(lives <= 0){
            gameOver = true;
        }
    }
    
    void increaseScore(int points){
        int oldScore = score;
        score += points;
        
        // extra vie a 10000
        if(!hasGotExtraLife && oldScore < EXTRA_LIFE_SCORE && score >= EXTRA_LIFE_SCORE) {
            lives++;
            hasGotExtraLife = true;
            println("Vie extra!");
        }
    }
    
    int getGhostScore() {
        ghostsEatenThisPower++;
        return SCORE_GHOST * (int)pow(2, ghostsEatenThisPower - 1);
    }
    void reset(){
        score = START_SCORE;
        lives = START_LIVES;
        gameOver = false;
        powerModeFrames = 0;
        ghostsEatenThisPower = 0;
        hasGotExtraLife = false;
    }

    boolean isGameOver(){
        return gameOver;
    }
    boolean isGameWin(){
        return board.getRemainingGommes() == 0;
    }
    void displayGameOverWin() {
    fill(0, 0, 0, 200);
    rect(0, 0, width, height);

    // texte VICTOIRE
    fill(0, 255, 0);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("VICTOIRE!", width/2, height/2 - 50);

    // score final
    fill(255);
    textSize(32);
    text("Score Final: " + game.getScore(), width/2, height/2 + 30);

    // instructions pour recommencer
    textSize(20);
    text("Appuyez sur R pour rejouer", width/2, height/2 + 80);

    textAlign(LEFT, BASELINE);
    }

    void displayGameOverLose(){
        fill(0, 0, 0, 200);
        rect(0, 0, width, height);
        
        // texte GAME OVER
        fill(255, 0, 0);
        textAlign(CENTER, CENTER);
        textSize(64);
        text("GAME OVER", width/2, height/2 - 50);
        
        // score final
        fill(255);
        textSize(32);
        text("Score Final: " + game.getScore(), width/2, height/2 + 30);
        
        // instructions pour recommencer
        textSize(20);
        text("Appuyez sur R pour rejouer", width/2, height/2 + 80);
        
        textAlign(LEFT, BASELINE);
    }   

}