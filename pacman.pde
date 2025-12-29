Board board;
Hero hero;
Game game;
void settings(){
    size(1000, 1000);
}

void setup(){
    background(0);
    board = new Board();
    hero = new Hero(board);
    game = new Game();
    board.display();
    hero.initialize();
    hero.display();

}

void draw(){
    background(0);
    
    board.display();
    hero.update();
    hero.display();
    fill(255);
    textSize(24);
    text("Score: " + game.getScore(), 20, 30);
}   
void keyPressed(){    
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