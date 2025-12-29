class Game {
    private int score;
    private int lives;
    private boolean gameOver;
    private int powerModeFrames = 0;
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
    int getLives(){
        return lives;
    }
    boolean isPowerMode(){
        return powerModeFrames > 0;
    }
    void activatePowerMode(){
        powerModeFrames = POWER_MODE_DURATION;
    }
    void updatePowerMode(){
        if(powerModeFrames > 0){
            powerModeFrames--;
        }
    }
    int getPowerModeFrames(){
        return powerModeFrames;
    }
    void decreaseLives(){
        lives -= 1;
        if(lives <= 0){
            gameOver = true;
        }
    }
    void increaseScore(int points){
        score += points;
    }
    void reset(){
        // reset le jeu
        score = START_SCORE;
        lives = START_LIVES;
        gameOver = false;
        powerModeFrames = 0;
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