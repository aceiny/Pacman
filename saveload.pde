class SaveLoad {
    private String saveFilePath = "data/save.txt";
    
    SaveLoad() {
    }
    
    void saveGame(Game game, Board board, Hero hero, Ghost[] ghosts) {
        // on sauvegarde tout dans un fichier
        ArrayList<String> lines = new ArrayList<String>();
        
        // infos jeu
        lines.add("GAME");
        lines.add("score:" + game.getScore());
        lines.add("lives:" + game.getLives());
        lines.add("powermode:" + game.getPowerModeFrames());
        
        // position hero
        lines.add("HERO");
        lines.add("row:" + hero.getRow());
        lines.add("col:" + hero.getCol());
        
        // fantomes
        lines.add("GHOSTS");
        for (int i = 0; i < ghosts.length; i++) {
            lines.add("ghost:" + ghosts[i].getRow() + "," + ghosts[i].getCol());
        }
        
        // sauvegarder le board
        lines.add("BOARD");
        for (int r = 0; r < board.getRows(); r++) {
            String row = "";
            for (int c = 0; c < board.getCols(); c++) {
                TypeCell cell = board.grid[r][c];
                switch(cell) {
                    case WALL: row += "W"; break;
                    case EMPTY: row += "E"; break;
                    case PACGOMME: row += "P"; break;
                    case SUPER_PACGOMME: row += "S"; break;
                    case GHOST_DOOR: row += "D"; break;
                    case BONUS: row += "B"; break;
                    default: row += "E"; break;
                }
            }
            lines.add(row);
        }
        
        String[] arr = new String[lines.size()];
        lines.toArray(arr);
        saveStrings(saveFilePath, arr);
        
        println("Jeu sauvegarde!");
    }
    
    boolean loadGame(Game game, Board board, Hero hero, Ghost[] ghosts) {
        // charge le jeu depuis le fichier
        String[] lines = loadStrings(saveFilePath);
        if (lines == null) {
            println("Pas de sauvegarde trouvee");
            return false;
        }
        
        int i = 0;
        while (i < lines.length) {
            String line = lines[i];
            
            if (line.equals("GAME")) {
                i++;
                while (i < lines.length && !lines[i].equals("HERO")) {
                    String[] parts = split(lines[i], ':');
                    if (parts[0].equals("score")) {
                        game.setScore(int(parts[1]));
                    } else if (parts[0].equals("lives")) {
                        game.setLives(int(parts[1]));
                    } else if (parts[0].equals("powermode")) {
                        game.setPowerModeFrames(int(parts[1]));
                    }
                    i++;
                }
            } else if (line.equals("HERO")) {
                i++;
                while (i < lines.length && !lines[i].equals("GHOSTS")) {
                    String[] parts = split(lines[i], ':');
                    if (parts[0].equals("row")) {
                        hero.setRow(int(parts[1]));
                    } else if (parts[0].equals("col")) {
                        hero.setCol(int(parts[1]));
                    }
                    i++;
                }
            } else if (line.equals("GHOSTS")) {
                i++;
                int ghostIndex = 0;
                while (i < lines.length && !lines[i].equals("BOARD")) {
                    if (lines[i].startsWith("ghost:")) {
                        String[] parts = split(lines[i].substring(6), ',');
                        if (ghostIndex < ghosts.length) {
                            ghosts[ghostIndex].setPosition(int(parts[0]), int(parts[1]));
                            ghostIndex++;
                        }
                    }
                    i++;
                }
            } else if (line.equals("BOARD")) {
                i++;
                int row = 0;
                while (i < lines.length && row < board.getRows()) {
                    String rowData = lines[i];
                    for (int c = 0; c < min(rowData.length(), board.getCols()); c++) {
                        char ch = rowData.charAt(c);
                        switch(ch) {
                            case 'W': board.grid[row][c] = TypeCell.WALL; break;
                            case 'E': board.grid[row][c] = TypeCell.EMPTY; break;
                            case 'P': board.grid[row][c] = TypeCell.PACGOMME; break;
                            case 'S': board.grid[row][c] = TypeCell.SUPER_PACGOMME; break;
                            case 'D': board.grid[row][c] = TypeCell.GHOST_DOOR; break;
                            case 'B': board.grid[row][c] = TypeCell.BONUS; break;
                        }
                    }
                    row++;
                    i++;
                }
                break;
            } else {
                i++;
            }
        }
        
        println("Jeu charge!");
        return true;
    }
}
