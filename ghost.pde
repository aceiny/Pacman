class Ghost {
    private int row;
    private int col;
    private int dirRow = 0, dirCol = 0;
    
    private int moveDelay = MOVE_DELAY + 2; 
    private int frameCounter = 0;
    
    private Board board;
    private Game game;
    private Hero hero;
    private color ghostColor;
    private int startRow, startCol;
    private boolean isEaten = false;
    private int respawnTimer = 0;
    private int releaseDelay;
    private boolean isReleased = false;
    
    Ghost(Board board, Game game, Hero hero, int startRow, int startCol, color c) {
        this(board, game, hero, startRow, startCol, c, 0);
    }
    
    Ghost(Board board, Game game, Hero hero, int startRow, int startCol, color c, int delay) {
        this.board = board;
        this.game = game;
        this.hero = hero;
        this.row = startRow;
        this.col = startCol;
        this.startRow = startRow;
        this.startCol = startCol;
        this.ghostColor = c;
        this.releaseDelay = delay;
        if (delay == 0) {
            isReleased = true;
        }
        chooseSmartDirection();
    }
    
    int getRow() {
        return this.row;
    }
    
    int getCol() {
        return this.col;
    }
    
    void setPosition(int r, int c) {
        this.row = r;
        this.col = c;
    }
    
    boolean canMove(int newRow, int newCol) {
        return isValidMove(board, newRow, newCol);
    }
    
    void chooseRandomDirection() {
        int choice = int(random(4));
        switch(choice) {
            case 0: dirRow = -1; dirCol = 0; break;
            case 1: dirRow = 1; dirCol = 0; break;
            case 2: dirRow = 0; dirCol = -1; break;
            case 3: dirRow = 0; dirCol = 1; break;
        }
    }
    
    void chooseSmartDirection() {
        int heroRow = hero.getRow();
        int heroCol = hero.getCol();
        
        int[][] dist = computeDistances(board, heroRow, heroCol);
        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        float bestValue = isFrightened() ? -Float.MAX_VALUE : Float.MAX_VALUE;
        int bestDir = -1;
        
        for (int i = 0; i < dirs.length; i++) {
            int newRow = row + dirs[i][0];
            int newCol = col + dirs[i][1];
            
            if (dirs[i][0] == -dirRow && dirs[i][1] == -dirCol) continue;
            
            if (canMove(newRow, newCol)) {
                float value = dist[newRow][newCol];
                if (isFrightened()) {
                    if (value > bestValue) {
                        bestValue = value;
                        bestDir = i;
                    }
                } else {
                    if (value < bestValue) {
                        bestValue = value;
                        bestDir = i;
                    }
                }
            }
        }
        
        if (bestDir != -1) {
            dirRow = dirs[bestDir][0];
            dirCol = dirs[bestDir][1];
        } else {
            chooseRandomDirection();
        }
    }
    
    void update() {
        if(!isReleased) {
            releaseDelay--;
            if(releaseDelay <= 0) {
                isReleased = true;
            }
            return;
        }
        
        if(isEaten){
            respawnTimer--;
            if(respawnTimer <= 0){
                isEaten = false;
                row = startRow;
                col = startCol;
            }
            return;
        }
        
        frameCounter++;
        if (frameCounter >= moveDelay) {
            frameCounter = 0;
            
            chooseSmartDirection();
            if (canMove(row + dirRow, col + dirCol)) {
                row += dirRow;
                col += dirCol;
            } else {
                chooseRandomDirection();
                if (canMove(row + dirRow, col + dirCol)) {
                    row += dirRow;
                    col += dirCol;
                }
            }
        }
    }
    
    void display() {
        // pas encore sorti
        if (!isReleased) {
            int x = col * CELL_SIZE;
            int y = row * CELL_SIZE;
            fill(ghostColor, 100);
            noStroke();
            ellipse(x + CELL_SIZE/2, y + CELL_SIZE/2, CELL_SIZE - 4, CELL_SIZE - 4);
            return;
        }
        
        // si le fantome est mange, on l'affiche pas
        if(isEaten){
            return;
        }
        
        int x = col * CELL_SIZE;
        int y = row * CELL_SIZE;
        
        // Choisit la couleur du fantome de son statut
        // si pacman est en power mode, les fantomes deviennent bleu 
        if(game.isPowerMode()){
            if(game.getPowerModeFrames() < 90 && frameCount % 20 < 10){
                fill(255, 255, 255); // blanc quand ca clignote
            } else {
                fill(0, 0, 255); // bleu en mode frightened
            }
        } else {
            fill(ghostColor);
        }
        
        noStroke();
        
        arc(x + CELL_SIZE/2, y + CELL_SIZE/2, CELL_SIZE - 4, CELL_SIZE - 4, PI, TWO_PI);
        
        rect(x + 2, y + CELL_SIZE/2, CELL_SIZE - 4, CELL_SIZE/2 - 2);
        
        int waveSize = (CELL_SIZE - 4) / 3;
        for (int i = 0; i < 3; i++) {
            arc(x + 2 + i * waveSize + waveSize/2, y + CELL_SIZE - 2, 
                waveSize, waveSize/2, 0, PI);
        }
        
        fill(255);
        ellipse(x + CELL_SIZE/2 - 4, y + CELL_SIZE/2 - 2, 6, 6);
        ellipse(x + CELL_SIZE/2 + 4, y + CELL_SIZE/2 - 2, 6, 6);
        
        fill(0, 0, 200);
        ellipse(x + CELL_SIZE/2 - 4 + dirCol * 2, y + CELL_SIZE/2 - 2 + dirRow * 2, 3, 3);
        ellipse(x + CELL_SIZE/2 + 4 + dirCol * 2, y + CELL_SIZE/2 - 2 + dirRow * 2, 3, 3);
    }
    
    // on verifie si le fantome touche pacman
    boolean collidesWith(Hero hero) {
        return this.row == hero.getRow() && this.col == hero.getCol() && !isEaten;
    }
    
    void getEaten(){
        isEaten = true;
        respawnTimer = GHOST_RESPAWN_TIME;
    }
    
    boolean isFrightened(){
        return game.isPowerMode() && !isEaten;
    }
}
