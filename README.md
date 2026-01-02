# Pacman Game

A classic Pacman game implemented in Processing (Java).

## Features

- **Pacman**: Animated with chomping mouth, moves with keyboard (WASD or arrow keys).
- **Ghosts**: Intelligent AI using Dijkstra's algorithm for pathfinding. They chase Pacman optimally or flee when frightened.
  - Sequential release: Ghosts exit one by one with timed delays
- **Power Pellets**: Eat them to turn ghosts blue and vulnerable for a limited time.
- **Score System**: 
  - Pac-Gommes: 10 points
  - Super Pac-Gommes: 50 points
  - Bonus fruits: 500 points
  - Ghosts: 200, 400, 800, 1600 points (multiplier during same power mode)
- **Lives**: Start with 2 lives, lose one when caught by a ghost. Gain extra life at 10,000 points.
- **Win/Lose Conditions**: Win by eating all pellets, lose when out of lives.
- **Edge Wrapping**: Pac-Man can wrap around screen edges
- **Menu System**: Press ESC to pause and access menu
  - Resume game
  - Restart
  - Save game
  - Load game
  - View high scores
  - Quit
- **High Scores**: Top 5 scores saved with player names
- **Level Loading**: Loads levels from text files

## How to Run

### Option 1: Using Processing (Recommended for Development)
1. Install [Processing](https://processing.org/download/).
2. Open the `pacman.pde` file in Processing.
3. Click the play button to run the game.

### Option 2: Running the Pre-built Binary (Linux)
If you have the exported application:
1. Navigate to the `bin/linux-amd64/` folder.
2. Run the `pacman` executable:
   ```
   ./pacman
   ```
   (Make sure it's executable: `chmod +x pacman` if needed)

This allows you to play without installing Processing.

## Controls

- **Movement**: W/A/S/D or Arrow keys
- **Restart**: Press R after game over

## Game Mechanics

- Eat all small pellets and power pellets to win.
- Avoid ghosts unless you have a power pellet (they turn blue).
- Ghosts respawn after being eaten.
- Score extra points for eating ghosts while powered up.

## Technical Details

- **Pathfinding**: Ghosts use Dijkstra's algorithm for optimal chasing/fleeing.
- **Maze**: Custom grid-based layout with walls, pellets, and ghost house.
- **AI**: Ghosts start with smart directions and recalculate paths every move.

## Files

- `pacman.pde`: Main game loop and setup.
- `board.pde`: Maze and pellet management.
- `hero.pde`: Pacman logic and movement.
- `ghost.pde`: Ghost AI and behavior.
- `game.pde`: Score, lives, and game state.
- `types.pde`: Enums for cell types.
- `constants.pde`: Game constants.
- `pathfinding.pde`: Dijkstra's algorithm implementation.

Enjoy the game!
