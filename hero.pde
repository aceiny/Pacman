class Hero {
    private int row;
    private int col;
    int dirRow = 0, dirCol = 0;
    int nextRowDir = 0, nextColDir = 0;
    
    private int moveDelay = MOVE_DELAY;
    private int frameCounter = 0;
    
    private int invincibilityFrames = 0;
    private final int INVINCIBILITY_DURATION = 60;

    private boolean isInitialized = false;
    private Board board;
    private Game game;

    Hero(Board board, Game game) {
        this.board = board;
        this.game = game;
    }

    boolean isInitialized() {
        return this.isInitialized;
    }

    void setRow(int newRow) {
        if (newRow < 0 || newRow >= board.getRows()) {
            return;
        }
        this.row = newRow;
    }

    void setCol(int newCol) {
        if (newCol < 0 || newCol >= board.getCols()) {
            return;
        }
        this.col = newCol;
    }


    int getRow() {
        return this.row;
    }

    int getCol() {
        return this.col;
    }
    
    boolean isInvincible() {
        return invincibilityFrames > 0;
    }
    
    void setInvincible() {
        invincibilityFrames = INVINCIBILITY_DURATION;
    }

    boolean canMove(int newRow, int newCol){
        return isValidMove(board, newRow, newCol);
    }
    
    void setDirection(int rowDir, int colDir){
        nextRowDir = rowDir;
        nextColDir = colDir;
    }
    
    int wrapPosition(int pos, int max) {
        if(pos < 0) return max - 1;
        if(pos >= max) return 0;
        return pos;
    }
    
    void update(){
        if(invincibilityFrames > 0) {
            invincibilityFrames--;
        }
        
        frameCounter++;
        if(frameCounter >= moveDelay){
            frameCounter = 0;
            
            int newRow = wrapPosition(row + nextRowDir, board.getRows());
            int newCol = wrapPosition(col + nextColDir, board.getCols());
            
            if(canMove(newRow, newCol)){
                dirRow = nextRowDir;
                dirCol = nextColDir;
                row = newRow;
                col = newCol;
            } else {
                newRow = wrapPosition(row + dirRow, board.getRows());
                newCol = wrapPosition(col + dirCol, board.getCols());
                
                if(canMove(newRow, newCol)){
                    row = newRow;
                    col = newCol;
                }
            }
            
            eat();
        }
    }
    
    void eat(){
        TypeCell currentCell = board.grid[row][col];
        
        if(currentCell == TypeCell.PACGOMME){
            board.grid[row][col] = TypeCell.EMPTY;
            game.increaseScore(SCORE_PACGOMME);
        }
        else if(currentCell == TypeCell.SUPER_PACGOMME){
            board.grid[row][col] = TypeCell.EMPTY;
            game.increaseScore(SCORE_SUPER);
            game.activatePowerMode();
        }
        else if(currentCell == TypeCell.BONUS){
            board.grid[row][col] = TypeCell.EMPTY;
            game.increaseScore(SCORE_BONUS);
        }
    }
    
    void initialize() {
        if (this.isInitialized) {
            return;
        }

        int emptyCount = 0;
        for (int r = 0; r < board.getRows(); r++) {
            for (int c = 0; c < board.getCols(); c++) {
                if (board.grid[r][c] == TypeCell.EMPTY) {
                    emptyCount++;
                }
            }
        }
        
        if (emptyCount > 0) {
            int targetIndex = int(random(emptyCount));
            int currentIndex = 0;
            
            for (int r = 0; r < board.getRows(); r++) {
                for (int c = 0; c < board.getCols(); c++) {
                    if (board.grid[r][c] == TypeCell.EMPTY) {
                        if (currentIndex == targetIndex) {
                            this.row = r;
                            this.col = c;
                            this.isInitialized = true;
                            return;
                        }
                        currentIndex++;
                    }
                }
            }
        }
    }
    
    void respawn() {
        isInitialized = false ;
        this.initialize();
    }

    void display() {
        if (!isInitialized) {
            return;
        }
        
        if(isInvincible() && frameCount % 10 < 5) {
            return;
        }
        
        int x = col * CELL_SIZE;
        int y = row * CELL_SIZE;
        int centerX = x + CELL_SIZE/2;
        int centerY = y + CELL_SIZE/2;
        int radius = (CELL_SIZE - 4) / 2;
        
        float mouthSize = abs(sin(frameCount * 0.1f));
        
        fill(255, 255, 0);
        noStroke();
        ellipse(centerX, centerY, CELL_SIZE - 4, CELL_SIZE - 4);
        
        fill(0);
        noStroke();
        if (dirCol == 1) { // droite
            triangle(centerX, centerY, centerX + radius, centerY - radius * mouthSize, centerX + radius, centerY + radius * mouthSize);
        } else if (dirCol == -1) { // gauche
            triangle(centerX, centerY, centerX - radius, centerY - radius * mouthSize, centerX - radius, centerY + radius * mouthSize);
        } else if (dirRow == -1) { // haut
            triangle(centerX, centerY, centerX - radius * mouthSize, centerY - radius, centerX + radius * mouthSize, centerY - radius);
        } else if (dirRow == 1) { // bas
            triangle(centerX, centerY, centerX - radius * mouthSize, centerY + radius, centerX + radius * mouthSize, centerY + radius);
        }
        // si pas de direction, pas de bouche
    }
}
