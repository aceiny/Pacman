Board board;
Hero hero;
Game game;
Ghost[] ghosts;
Menu menu;
HighScores highScores;
SaveLoad saveLoad;
boolean showingHighScores = false;
boolean askingForName = false;
boolean justAddedHighScore = false;
String playerName = "";

void settings(){
    size(28 * CELL_SIZE, 31 * CELL_SIZE);
}

void setup(){
    background(0);
    board = new Board();
    windowResized();
    game = new Game(board);
    hero = new Hero(board, game);
    menu = new Menu();
    highScores = new HighScores();
    saveLoad = new SaveLoad();
    
    // init fantomes avec delais
    ghosts = new Ghost[4];
    ghosts[0] = new Ghost(board, game, hero, 13, 12, color(255, 0, 0), 0);
    ghosts[1] = new Ghost(board, game, hero, 13, 15, color(255, 184, 255), 60);
    ghosts[2] = new Ghost(board, game, hero, 14, 13, color(0, 255, 255), 120);
    ghosts[3] = new Ghost(board, game, hero, 14, 14, color(255, 184, 82), 180);
    
    hero.initialize();
}

void draw(){
    background(0);
    // si on demande le nom du joueur
    if (askingForName) {
        drawNameInput();
        return;
    }
    
    // high scores
    if (showingHighScores) {
        highScores.display();
        if (justAddedHighScore) {
            fill(255, 255, 0);
            textSize(24);
            textAlign(CENTER, CENTER);
            text("Appuyez sur R pour rejouer", width/2, height - 40);
            textAlign(LEFT, BASELINE);
        }
        return;
    }
    
    // game over
    if(game.isGameOver()){
        game.displayGameOverLose();
        if (highScores.isHighScore(game.getScore())) {
            askingForName = true;
        }
        return;
    }
    
    // victoire
    if (game.isGameWin()) {
        game.displayGameOverWin();
        if (highScores.isHighScore(game.getScore())) {
            askingForName = true;
        }
        return;
    }
    
    // si le menu est ouvert, on met en pause
    if (menu.isShowing()) {
        // dessine le jeu en arriere plan
        board.display();
        for (int i = 0; i < ghosts.length; i++) {
            ghosts[i].display();
        }
        hero.display();
        
        drawGameInfo();
        
        menu.display();
        return;
    }

    // on met a jour le power mode
    game.updatePowerMode();

    // on affiche le board
    board.display();

    // on met a jour et affiche les fantomes
    for (int i = 0; i < ghosts.length; i++) {
        ghosts[i].update();
        ghosts[i].display();

        // on verifie si un fantome touche pacman
        if (ghosts[i].collidesWith(hero)) {
            // si on est en power mode
            if(ghosts[i].isFrightened()){
                // en power mode, on mange le fantome
                ghosts[i].getEaten();
                // incremente le score 
                int ghostScore = game.getGhostScore();
                game.increaseScore(ghostScore);
            } else if(!hero.isInvincible()) {
                // sinon le fantome nous mange
                game.decreaseLives();
                // on rend pacman invincible 

                hero.setInvincible();
                if(!game.isGameOver()){
                    // on remet pacman a une nouvelle position aleatoire
                    hero.respawn();
                }
            }
        }
    }

    hero.update();
    hero.display();

    drawGameInfo();
}

void drawGameInfo() {
    fill(255);
    textSize(24);
    text("Score: " + game.getScore(), 20, 30);
    text("Lives: " + game.getLives(), 20, 60);
}

void drawNameInput() {
    // fond
    fill(0, 0, 0, 200);
    rect(0, 0, width, height);
    
    // message
    fill(255, 255, 0);
    textAlign(CENTER, CENTER);
    textSize(36);
    text("NOUVEAU HIGH SCORE!", width/2, height/3);
    
    // affiche le score
    fill(255);
    textSize(28);
    text("Score: " + game.getScore(), width/2, height/2 - 60);
    
    textSize(24);
    text("Entrez votre nom:", width/2, height/2 - 20);
    
    // affiche le nom
    fill(255, 255, 0);
    textSize(32);
    text(playerName + "_", width/2, height/2 + 30);
    
    // instructions
    fill(200);
    textSize(20);
    text("Appuyez sur ENTREE pour valider", width/2, height/2 + 90);
    
    textAlign(LEFT, BASELINE);
}

void keyPressed(){
    // si on entre un nom
    if (askingForName) {
        if (keyCode == ENTER) {
            if (playerName.length() > 0) {
                highScores.addScore(playerName, game.getScore());
                playerName = "";
                askingForName = false;
                // affiche les high scores apres avoir entre le nom
                showingHighScores = true;
                justAddedHighScore = true;
            }
        } else if (keyCode == BACKSPACE) {
            if (playerName.length() > 0) {
                playerName = playerName.substring(0, playerName.length() - 1);
            }
        } else if (key >= 32 && key <= 126 && playerName.length() < 15) {
            playerName += key;
        }
        return;
    }
    
    // si on affiche les high scores
    if (showingHighScores) {
        if (keyCode == ESC || key == 'r' || key == 'R') {
            key = 0; // evite de quitter le programme
            showingHighScores = false;
            if (justAddedHighScore) {
                justAddedHighScore = false;
                restartGame();
            }
        }
        return;
    }
    
    // si le menu est ouvert
    if (menu.isShowing()) {
        if (keyCode == ESC) {
            key = 0; // evite de quitter le programme
            menu.hide();
        } else if (keyCode == UP) {
            menu.selectPrevious();
        } else if (keyCode == DOWN) {
            menu.selectNext();
        } else if (keyCode == ENTER) {
            handleMenuSelection();
        }
        return;
    }
    
    // touche ESC pour ouvrir le menu
    if (keyCode == ESC) {
        key = 0; // evite de quitter le programme
        menu.show();
        return;
    }
    
    // si le jeu est fini et on appuie sur R, on recommence
    if((game.isGameOver() || game.isGameWin()) && (key == 'r' || key == 'R')){
        restartGame();
        return;
    }
    
    // controles du jeu
    switch(key){
        case 'z': case 'w': hero.setDirection(-1,0); break;
        case 's': hero.setDirection(1,0); break;
        case 'q': case 'a': hero.setDirection(0,-1); break;
        case 'd': hero.setDirection(0,1); break;
    }

    switch(keyCode){
        case UP: hero.setDirection(-1,0); break;
        case DOWN: hero.setDirection(1,0); break;
        case LEFT: hero.setDirection(0,-1); break;
        case RIGHT: hero.setDirection(0,1); break;
    }
}

void handleMenuSelection() {
    int option = menu.getSelectedOption();
    
    switch(option) {
        case 0: // Reprendre
            menu.hide();
            break;
        case 1: // Recommencer
            menu.hide();
            restartGame();
            break;
        case 2: // Sauvegarder
            saveLoad.saveGame(game, board, hero, ghosts);
            menu.hide();
            break;
        case 3: // Charger
            if (saveLoad.loadGame(game, board, hero, ghosts)) {
                menu.hide();
            }
            break;
        case 4: // Meilleurs Scores
            menu.hide();
            showingHighScores = true;
            break;
        case 5: // Quitter
            exit();
            break;
    }
}

void restartGame() {
    board = new Board();
    game.reset();
    game.board = board; 
    hero = new Hero(board, game);
    hero.initialize();
    
    ghosts[0] = new Ghost(board, game, hero, 13, 12, color(255, 0, 0), 0);
    ghosts[1] = new Ghost(board, game, hero, 13, 15, color(255, 184, 255), 60);
    ghosts[2] = new Ghost(board, game, hero, 14, 13, color(0, 255, 255), 120);
    ghosts[3] = new Ghost(board, game, hero, 14, 14, color(255, 184, 82), 180);
}

