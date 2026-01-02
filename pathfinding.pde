int[][] computeDistances(Board board, int targetRow, int targetCol) {
    int rows = board.getRows();
    int cols = board.getCols();
    
    int[][] dist = new int[rows][cols];
    boolean[][] visited = new boolean[rows][cols];
    
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            dist[r][c] = Integer.MAX_VALUE;
            visited[r][c] = false;
        }
    }
    dist[targetRow][targetCol] = 0;
    
    int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    
    for (int i = 0; i < rows * cols; i++) {
        int minDist = Integer.MAX_VALUE;
        int cr = -1, cc = -1;
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (!visited[r][c] && dist[r][c] < minDist) {
                    minDist = dist[r][c];
                    cr = r;
                    cc = c;
                }
            }
        }
        if (cr == -1) break;
        visited[cr][cc] = true;
        
        for (int[] d : dirs) {
            int nr = cr + d[0];
            int nc = cc + d[1];
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && isValidMove(board, nr, nc) && !visited[nr][nc]) {
                int newDist = dist[cr][cc] + 1;
                if (newDist < dist[nr][nc]) {
                    dist[nr][nc] = newDist;
                }
            }
        }
    }
    
    return dist;
}

boolean isValidMove(Board board, int newRow, int newCol) {
    if (newRow < 0 || newRow >= board.getRows() || newCol < 0 || newCol >= board.getCols()) {
        return false;
    }
    return board.grid[newRow][newCol] != TypeCell.WALL;
}