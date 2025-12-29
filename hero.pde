class Hero {
    private int row;
    private int col;
    int dirRow = 0, dirCol = 0;     // la direction actuelle de mouvement
    int nextRowDir = 0, nextColDir = 0; // la direction qui on veut prendre apres
    
    private int moveDelay = MOVE_DELAY;      // combien de frames on attend avant de bouger
    private int frameCounter = FRAME_COUNTER;    // compteur des frames
    
    private int invincibilityFrames = 0;  // frames d'invincibilité après un hit
    private final int INVINCIBILITY_DURATION = 60; // 1 seconde d'invincibilité

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

    int[] getCoords() {
        int[] coordsTable = {this.row, this.col};
        return coordsTable;
    }
    
    boolean isInvincible() {
        return invincibilityFrames > 0;
    }
    
    void setInvincible() {
        invincibilityFrames = INVINCIBILITY_DURATION;
    }

    boolean canMove(int newRow , int newCol){
        // on verifie si la nouvelle position est valide
        if (  newRow < 0 || newRow >= board.getRows()  || newCol < 0 || newCol >= board.getCols() ) {
            return false ;
        }
        // on peut pas traverser les murs 
        return board.grid[newRow][newCol] != TypeCell.WALL;
    }

   void setDirection(int rowDir, int colDir){
        nextRowDir = rowDir;
        nextColDir = colDir;
    }
    void update(){
        // on diminue les frames d'invincibilité
        if(invincibilityFrames > 0) {
            invincibilityFrames--;
        }
        
        frameCounter++;
        if(frameCounter >= moveDelay){
            frameCounter = 0;
            
            // d'abord on essaye de tourner dans la direction demandée
            if(canMove(row + nextRowDir, col + nextColDir)){
                dirRow = nextRowDir;
                dirCol = nextColDir;
                row += dirRow;
                col += dirCol;
            }

            // sinon on continue tout droit dans la meme direction
            else if(canMove(row + dirRow, col + dirCol)){
                row += dirRow;
                col += dirCol;
            }
            
            // maintenant on mange ce qu'il y a dans la cellule
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
            // on mange la super pac-gomme et on active le power mode
            board.grid[row][col] = TypeCell.EMPTY;
            game.increaseScore(SCORE_SUPER);
            game.activatePowerMode();
        }
    }
    
    void initialize() {
        if (this.isInitialized) {
            return;
        }

        // on compte combien de cellules vides y a
        int emptyCount = 0;
        for (int r = 0; r < board.getRows(); r++) {
            for (int c = 0; c < board.getCols(); c++) {
                if (board.grid[r][c] == TypeCell.EMPTY) {
                    emptyCount++;
                }
            }
        }
        
        // maintenant on choisit une cellule vide au hasard
        if (emptyCount > 0) {
            int targetIndex = int(random(emptyCount));
            int currentIndex = 0;
            
            // on parcourt encore une fois pour trouver la cellule choisie
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
        
        // si on est invincible, on clignote (on affiche 1 frame sur 2)
        if(isInvincible() && frameCount % 10 < 5) {
            return;
        }
        
        int x = col * CELL_SIZE;
        int y = row * CELL_SIZE;
        
        // on dessine pacman 
        fill(255, 255, 0);
        noStroke();
        ellipse(x + CELL_SIZE/2, y + CELL_SIZE/2, CELL_SIZE - 4, CELL_SIZE - 4);
    }
}
