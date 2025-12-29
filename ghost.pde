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
    
    Ghost(Board board, Game game, Hero hero, int startRow, int startCol, color c) {
        this.board = board;
        this.game = game;
        this.hero = hero;
        this.row = startRow;
        this.col = startCol;
        this.startRow = startRow;
        this.startCol = startCol;
        this.ghostColor = c;
        chooseSmartDirection();
    }
    
    int getRow() {
        return this.row;
    }
    
    int getCol() {
        return this.col;
    }
    
    boolean canMove(int newRow, int newCol) {
        return isValidMove(board, newRow, newCol);
    }
    
    void chooseRandomDirection() {
        int[] directions = {0, 1, 2, 3};
        int choice = directions[int(random(4))];
        
        switch(choice) {
            case 0: dirRow = -1; dirCol = 0; break;  // haut
            case 1: dirRow = 1; dirCol = 0; break;   // bas
            case 2: dirRow = 0; dirCol = -1; break;  // gauche
            case 3: dirRow = 0; dirCol = 1; break;   // droite
        }
    }
    
    void chooseSmartDirection() {
        int heroRow = hero.getRow();
        int heroCol = hero.getCol();
        
        // Utiliser Dijkstra pour calculer les distances
        int[][] dist = computeDistances(board, heroRow, heroCol);
        
        // directions possibles
        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        float bestValue = isFrightened() ? -Float.MAX_VALUE : Float.MAX_VALUE;
        int bestDir = -1;
        
        for (int i = 0; i < dirs.length; i++) {
            int newRow = row + dirs[i][0];
            int newCol = col + dirs[i][1];
            
            // eviter de revenir en arriere immediatement
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
        // si le fantome est mange, on attend avant de respawn
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
            
            // on essaye de continuer dans la meme direction
            if (canMove(row + dirRow, col + dirCol)) {
                row += dirRow;
                col += dirCol;
            } else {
                // si on peut pas continuer, on choisit une nouvelle direction intelligente
                chooseSmartDirection();
                if (canMove(row + dirRow, col + dirCol)) {
                    row += dirRow;
                    col += dirCol;
                }
            }
        }
    }
    
    void display() {
        // si le fantome est mange, on l'affiche pas
        if(isEaten){
            return;
        }
        
        int x = col * CELL_SIZE;
        int y = row * CELL_SIZE;
        
            // Choisit la couleur du fantome en fonction de son statut
        // si on est en power mode, les fantomes deviennent bleus 
        if(game.isPowerMode()){
            if(game.getPowerModeFrames() < 90 && frameCount % 20 < 10){
                fill(255, 255, 255); // blanc quand ça clignote
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
