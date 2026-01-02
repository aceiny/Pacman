// gerer les meilleurs scores
class HighScores {
    private String[] playerNames;
    private int[] scores;
    private final int MAX_SCORES = 5;
    private String filePath = "data/highscores.txt";
    
    HighScores() {
        playerNames = new String[MAX_SCORES];
        scores = new int[MAX_SCORES];
        loadScores();
    }
    
    void loadScores() {
        String[] lines = loadStrings(filePath);
        if (lines != null && lines.length > 0) {
            for (int i = 0; i < min(lines.length, MAX_SCORES); i++) {
                String[] parts = split(lines[i], ':');
                if (parts.length == 2) {
                    playerNames[i] = parts[0];
                    scores[i] = int(parts[1]);
                }
            }
        } else {
            // init par defaut
            for (int i = 0; i < MAX_SCORES; i++) {
                playerNames[i] = "---";
                scores[i] = 0;
            }
        }
    }
    
    void saveScores() {
        String[] lines = new String[MAX_SCORES];
        for (int i = 0; i < MAX_SCORES; i++) {
            lines[i] = playerNames[i] + ":" + scores[i];
        }
        saveStrings(filePath, lines);
    }
    
    boolean isHighScore(int score) {
        for (int i = 0; i < MAX_SCORES; i++) {
            if (score > scores[i]) return true;
        }
        return false;
    }
    
    void addScore(String name, int score) {
        // ajoute un nouveau score
        int position = -1;
        for (int i = 0; i < MAX_SCORES; i++) {
            if (score > scores[i]) {
                position = i;
                break;
            }
        }
        
        if (position != -1) {
            // decale tous les scores inferieurs
            for (int i = MAX_SCORES - 1; i > position; i--) {
                playerNames[i] = playerNames[i-1];
                scores[i] = scores[i-1];
            }
            
            // insere le nouveau score
            playerNames[position] = name;
            scores[position] = score;
            
            saveScores();
        }
    }
    
    void display() {
        // affiche l'ecran des meilleurs scores
        fill(0, 0, 0, 200);
        rect(0, 0, width, height);
        
        fill(255, 255, 0);
        textAlign(CENTER, CENTER);
        textSize(48);
        text("MEILLEURS SCORES", width/2, height/6);
        
        // affiche les scores
        textSize(32);
        for (int i = 0; i < MAX_SCORES; i++) {
            fill(255);
            String line = (i+1) + ". " + playerNames[i] + " - " + scores[i];
            text(line, width/2, height/3 + i * 60);
        }
        
        // instruction pour retourner
        fill(200);
        textSize(24);
        text("Appuyez sur ECHAP pour retourner", width/2, height - 80);
        
        textAlign(LEFT, BASELINE);
    }
}
