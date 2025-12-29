# Pacman Game

A classic Pacman game implemented in Processing (Java).

## Features

- **Pacman**: Animated with chomping mouth, moves with keyboard (WASD or arrow keys).
- **Ghosts**: Intelligent AI using Dijkstra's algorithm for pathfinding. They chase Pacman optimally or flee when frightened.
- **Power Pellets**: Eat them to turn ghosts blue and vulnerable for a limited time.
- **Score System**: Points for pellets, ghosts, and bonuses.
- **Lives**: Start with 2 lives, lose one when caught by a ghost.
- **Win/Lose Conditions**: Win by eating all pellets, lose when out of lives.

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
