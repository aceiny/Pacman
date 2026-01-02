// classe pour gerer le menu du jeu
class Menu {
    private boolean isVisible;
    private int selectedOption;
    private String[] options;
    
    Menu() {
        isVisible = false;
        selectedOption = 0;
        // options du menu
        options = new String[] {
            "Reprendre",
            "Recommencer",
            "Sauvegarder",
            "Charger",
            "Meilleurs Scores",
            "Quitter"
        };
    }
    
    void show() {
        isVisible = true;
    }
    
    void hide() {
        isVisible = false;
    }
    
    boolean isShowing() {
        return isVisible;
    }
    
    void toggle() {
        isVisible = !isVisible;
    }
    
    void selectNext() {
        selectedOption++;
        if (selectedOption >= options.length) {
            selectedOption = 0;
        }
    }
    
    void selectPrevious() {
        selectedOption--;
        if (selectedOption < 0) {
            selectedOption = options.length - 1;
        }
    }
    
    int getSelectedOption() {
        return selectedOption;
    }
    
    void display() {
        if (!isVisible) return;
        
        fill(0, 0, 0, 180);
        rect(0, 0, width, height);
        
        // titre
        fill(255, 255, 0);
        textAlign(CENTER, CENTER);
        textSize(48);
        text("PAUSE", width/2, height/4);
        
        // les options
        textSize(32);
        for (int i = 0; i < options.length; i++) {
            if (i == selectedOption) {
                fill(255, 255, 0);
                text("> " + options[i] + " <", width/2, height/2 + i * 50);
            } else {
                fill(200);
                text(options[i], width/2, height/2 + i * 50);
            }
        }
        
        textAlign(LEFT, BASELINE);
    }
}
