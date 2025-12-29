class Game {
    private int score;
    private int lives;
    private boolean gameOver;
    private int powerModeFrames = 0;
    private final int POWER_MODE_DURATION = 300; // 5 secondes de power mode

    Game(){
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
    boolean isGameOver(){
        return gameOver;
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
        score = START_SCORE;
        lives = START_LIVES;
        gameOver = false;
        powerModeFrames = 0;
    }

}