Board board;
Hero hero;
Game game;
Ghost[] ghosts;

void settings(){
    size(28 * CELL_SIZE, 31 * CELL_SIZE);
}

void setup(){
    background(0);
    // init de board de jeu  
    board = new Board();

    // init de la jeu 
    game = new Game();

    //init pacman 
    hero = new Hero(board, game);
    
    //init les fantomes 
    ghosts = new Ghost[4];
    ghosts[0] = new Ghost(board, game, 13, 12, color(255, 0, 0));   
    ghosts[1] = new Ghost(board, game, 13, 15, color(255, 184, 255));
    ghosts[2] = new Ghost(board, game, 14, 13, color(0, 255, 255));   
    ghosts[3] = new Ghost(board, game, 14, 14, color(255, 184, 82)); 
    
    // affiche le board pour premier fois 
    board.display();

    // choisit une cellule vide au hasard pour pacman 
    hero.initialize();

    // afficher pacman 
    hero.display();

}

void draw(){
    background(0);
    
    // si le jeu est fini, on affiche l'ecran de game over
    if(game.isGameOver()){
        displayGameOver();
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
                // icreament le score
                game.increaseScore(SCORE_GHOST);
            } else if(!hero.isInvincible()) {
                // sinon le fantome nous mange
                game.decreaseLives();
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
    
    // on affiche le score et les vies
    fill(255);
    textSize(24);
    text("Score: " + game.getScore(), 20, 30);
    text("Lives: " + game.getLives(), 20, 60);
}

void displayGameOver(){
    fill(0, 0, 0, 200);
    rect(0, 0, width, height);
    
    // texte GAME OVER
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("GAME OVER", width/2, height/2 - 50);
    
    // score final
    fill(255);
    textSize(32);
    text("Score Final: " + game.getScore(), width/2, height/2 + 30);
    
    // instructions pour recommencer
    textSize(20);
    text("Appuyez sur R pour rejouer", width/2, height/2 + 80);
    
    textAlign(LEFT, BASELINE);
}   
void keyPressed(){    
    // si le jeu est fini et on appuie sur R, on recommence
    if(game.isGameOver() && (key == 'r' || key == 'R')){
        game.reset();
        board = new Board();
        hero = new Hero(board, game);
        hero.initialize();
        
        ghosts[0] = new Ghost(board, game, 13, 12, color(255, 0, 0));
        ghosts[1] = new Ghost(board, game, 13, 15, color(255, 184, 255));
        ghosts[2] = new Ghost(board, game, 14, 13, color(0, 255, 255));
        ghosts[3] = new Ghost(board, game, 14, 14, color(255, 184, 82));
        return;
    }
    
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