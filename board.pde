class Board {
    TypeCell[][] grid; 
    private int rowCount ; 
    private int colCount ;
    private String levelTitle = "";

    Board(){
        if (!loadFromFile("data/levels/level1.txt")) {
            loadDefaultBoard();
        }
    }
    
    Board(String filename) {
        if (!loadFromFile(filename)) {
            loadDefaultBoard();
        }
    }
    
    boolean loadFromFile(String filename) {
        String[] lines = loadStrings(filename);
        if (lines == null || lines.length < 2) return false;
        
        levelTitle = lines[0];
        int rows = lines.length - 1;
        int cols = lines[1].length();
        
        grid = new TypeCell[rows][cols];
        
        for (int r = 0; r < rows; r++) {
            String line = lines[r + 1];
            for (int c = 0; c < min(line.length(), cols); c++) {
                char ch = line.charAt(c);
                switch(ch) {
                    case 'x': case 'w': grid[r][c] = TypeCell.WALL; break;
                    case 'V': case 'P': grid[r][c] = TypeCell.EMPTY; break;
                    case 'o': grid[r][c] = TypeCell.PACGOMME; break;
                    case 'O': grid[r][c] = TypeCell.SUPER_PACGOMME; break;
                    case 'D': grid[r][c] = TypeCell.GHOST_DOOR; break;
                    case 'B': grid[r][c] = TypeCell.BONUS; break;
                    default: grid[r][c] = TypeCell.EMPTY; break;
                }
            }
        }
        
        rowCount = rows;
        colCount = cols;
        
        println("Niveau charge: " + levelTitle);
        return true;
    }
    
    void loadDefaultBoard() {
    final TypeCell W = TypeCell.WALL;
    final TypeCell P = TypeCell.PACGOMME;
    final TypeCell O = TypeCell.SUPER_PACGOMME;
    final TypeCell E = TypeCell.EMPTY;
    final TypeCell D = TypeCell.GHOST_DOOR;
    final TypeCell B = TypeCell.BONUS;
    
    grid = new TypeCell[][] {
        {W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W},
        {W, P, P, P, P, P, P, P, P, P, P, P, P, W, W, P, P, P, P, P, P, P, P, P, P, P, P, W},
        {W, P, W, W, W, W, P, W, W, W, W, W, P, W, W, P, W, W, W, W, W, P, W, W, W, W, P, W},
        {W, O, W, W, W, W, P, W, W, W, W, W, P, W, W, P, W, W, W, W, W, P, W, W, W, W, O, W},
        {W, P, W, W, W, W, P, W, W, W, W, W, P, W, W, P, W, W, W, W, W, P, W, W, W, W, P, W},
        {W, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, W},
        {W, P, W, W, W, W, P, W, W, P, W, W, W, W, W, W, W, W, P, W, W, P, W, W, W, W, P, W},
        {W, P, W, W, W, W, P, W, W, P, W, W, W, W, W, W, W, W, P, W, W, P, W, W, W, W, P, W},
        {W, P, P, P, P, P, P, W, W, P, P, P, P, W, W, P, P, P, P, W, W, P, P, P, P, P, P, W},
        {W, W, W, W, W, W, P, W, W, W, W, W, E, W, W, E, W, W, W, W, W, P, W, W, W, W, W, W},
        {W, W, W, W, W, W, P, W, W, W, W, W, E, E, E, E, W, W, W, W, W, P, W, W, W, W, W, W},
        {W, W, W, W, W, W, P, W, W, E, E, E, E, B, E, E, E, E, E, W, W, P, W, W, W, W, W, W},
        {W, W, W, W, W, W, P, W, W, E, W, W, D, D, D, D, W, W, E, W, W, P, W, W, W, W, W, W},
        {W, W, W, W, W, W, P, W, W, E, W, E, E, E, E, E, E, W, E, W, W, P, W, W, W, W, W, W},
        {E, E, E, E, E, E, P, E, E, E, W, E, E, E, E, E, E, W, E, E, E, P, E, E, E, E, E, E},
        {W, W, W, W, W, W, P, W, W, E, W, E, E, E, E, E, E, W, E, W, W, P, W, W, W, W, W, W},
        {W, W, W, W, W, W, P, W, W, E, W, W, W, W, W, W, W, W, E, W, W, P, W, W, W, W, W, W},
        {W, W, W, W, W, W, P, W, W, E, E, E, E, E, E, E, E, E, E, W, W, P, W, W, W, W, W, W},
        {W, W, W, W, W, W, P, W, W, E, W, W, W, W, W, W, W, W, E, W, W, P, W, W, W, W, W, W},
        {W, W, W, W, W, W, P, W, W, E, W, W, W, W, W, W, W, W, E, W, W, P, W, W, W, W, W, W},
        {W, P, P, P, P, P, P, P, P, P, P, P, P, W, W, P, P, P, P, P, P, P, P, P, P, P, P, W},
        {W, P, W, W, W, W, P, W, W, W, W, W, P, W, W, P, W, W, W, W, W, P, W, W, W, W, P, W},
        {W, P, W, W, W, W, P, W, W, W, W, W, P, W, W, P, W, W, W, W, W, P, W, W, W, W, P, W},
        {W, O, P, P, W, W, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, W, W, P, P, O, W},
        {W, W, W, P, W, W, P, W, W, P, W, W, W, W, W, W, W, W, P, W, W, P, W, W, P, W, W, W},
        {W, W, W, P, W, W, P, W, W, P, W, W, W, W, W, W, W, W, P, W, W, P, W, W, P, W, W, W},
        {W, P, P, P, P, P, P, W, W, P, P, P, P, W, W, P, P, P, P, W, W, P, P, P, P, P, P, W},
        {W, P, W, W, W, W, W, W, W, W, W, W, P, W, W, P, W, W, W, W, W, W, W, W, W, W, P, W},
        {W, P, W, W, W, W, W, W, W, W, W, W, P, W, W, P, W, W, W, W, W, W, W, W, W, W, P, W},
        {W, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, P, W},
        {W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W}
    };
        rowCount = grid.length;
        colCount = grid[0].length;
    }
    
    int getRows(){
        return rowCount;
    }
    
    int getCols(){
        return colCount;
    }

    // Affiche le board de jeu
    void display(){
        for(int r = 0 ; r < this.rowCount ; r++){
                for(int c = 0 ; c < this.colCount ; c++){
                    int x = c * CELL_SIZE ;
                    int y = r * CELL_SIZE ;
                    switch(grid[r][c]){
                        case WALL : 
                            stroke(33, 33, 222);
                            strokeWeight(2);
                            noFill();
                            rect(x, y, CELL_SIZE, CELL_SIZE);
                        break;
                        case PACGOMME : 
                            fill(255, 184, 174);
                            noStroke();
                            ellipse(x + CELL_SIZE/2, y + CELL_SIZE/2, 4, 4);
                        break;
                        case SUPER_PACGOMME : 
                            fill(255, 184, 174);
                            noStroke();
                            float pulseSize = 10 + sin(frameCount * 0.1) * 2;
                            ellipse(x + CELL_SIZE/2, y + CELL_SIZE/2, pulseSize, pulseSize);
                        break;
                        case GHOST_DOOR :
                            stroke(255, 184, 255);
                            strokeWeight(3);
                            line(x, y + CELL_SIZE/2, x + CELL_SIZE, y + CELL_SIZE/2);
                        break ;
                        case BONUS :
                            // dessine un bonus (fruit)
                            fill(255, 0, 0);
                            noStroke();
                            ellipse(x + CELL_SIZE/2, y + CELL_SIZE/2 + 2, 12, 12);
                            fill(0, 255, 0);
                            rect(x + CELL_SIZE/2 - 2, y + CELL_SIZE/2 - 6, 4, 6);
                        break;
                        default :
                        // Rien
                        break ; 
                    }
                }
        }
    }   
    // Retourne le nombre de pacgommes et super pacgommes restants
    int getRemainingGommes() {
        int count = 0;
        for (int r = 0; r < rowCount; r++) {
            for (int c = 0; c < colCount; c++) {
                if (grid[r][c] == TypeCell.PACGOMME || grid[r][c] == TypeCell.SUPER_PACGOMME) {
                    count++;
                }
            }
        }
        return count;
    }
}