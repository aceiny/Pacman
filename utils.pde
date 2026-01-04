void windowResized() {
    int cols = board.getCols();
    int rows = board.getRows();
    // assure une taille de cellule minimale qui permet de voir correctement le jeu
    int newCellSize = max(MIN_CELL_SIZE, min(floor((float)width / cols), floor((float)height / rows)));
    CELL_SIZE = newCellSize;
    // resize window
    surface.setSize(cols * CELL_SIZE, rows * CELL_SIZE);
}