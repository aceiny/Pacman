class Game {
    private int score;
    private int lives;

    Game(){
        score = 0;
        lives = 2;
    }
    int getScore(){
        return score;
    }
    int getLives(){
        return lives;
    }
    void decreaseLives(){
        lives -= 1;
    }
    void increaseScore(int points){
        score += points;
    }
    
}