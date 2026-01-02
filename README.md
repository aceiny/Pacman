# Pacman Game

Jeu Pacman classique developpe en Processing (Java) pour le projet de Programmation Java.

## Fonctionnalites

### Jeu de Base
- **Pacman**: Controle par clavier (ZQSD ou fleches)
- **Fantomes**: 4 fantomes avec sortie sequentielle (delais de 0, 60, 120, 180 frames)
  - IA intelligente utilisant l'algorithme de Dijkstra (extension implementee)
  - Ralentis pendant le mode power
- **Pac-Gommes**: Mangez toutes les gommes pour gagner
- **Super Pac-Gommes**: Active le mode power temporairement
- **Systeme de Score**: 
  - Pac-Gommes: 10 points
  - Super Pac-Gommes: 50 points
  - Bonus: 500 points
  - Fantomes: 200, 400, 800, 1600 points (multiplicateur pendant le meme mode power)
- **Vies**: Commence avec 2 vies, perd une vie si touche par un fantome
  - Vie supplementaire a 10 000 points
- **Conditions de Fin**: Victoire si toutes les gommes mangees, defaite si 0 vie
- **Teleportation**: Pacman peut traverser les bords du labyrinthe

### Menu (Touche Echap)
- Reprendre la partie
- Recommencer
- Sauvegarder la partie en cours
- Charger une partie sauvegardee
- Consulter les meilleurs scores (Top 5)
- Quitter

### Systeme de Sauvegarde
- **Meilleurs Scores**: Top 5 avec noms des joueurs (data/highscores.txt)
- **Sauvegarde**: Possibilite de sauvegarder et charger une partie (data/save.txt)
- **Niveaux**: Chargement depuis fichiers texte (data/levels/level1.txt)

## Execution

### Avec Processing
1. Installer [Processing](https://processing.org/download/)
2. Ouvrir le fichier `pacman.pde` dans Processing
3. Cliquer sur le bouton Play

### Binaire (Linux)
Si l'application est exportee:
```bash
cd bin/linux-amd64/
chmod +x pacman
./pacman
```

## Controles

- **Deplacement**: Z/Q/S/D ou Fleches directionnelles
- **Menu**: Echap pour pause
- **Recommencer**: R apres game over ou victoire
- **Saisie du nom**: Entree pour valider, Backspace pour effacer

## Deroulement du Jeu

1. **Debut**: 2 vies, 0 points
2. **Deplacements**: Pac-Man se deplace le long des murs sans pouvoir les traverser
3. **Fantomes**: Sortent un par un de leur emplacement initial
4. **Gommes**: 
   - Pac-Gomme: +10 points
   - Super Pac-Gomme: +50 points + mode power
5. **Mode Power**: Les fantomes deviennent bleus et ralentis, peuvent etre manges
6. **Bonus**: Apparait dans le labyrinthe, +500 points
7. **Collision**: Si touche par un fantome, perd 1 vie et repositionnement
8. **Fin**: Victoire si toutes les gommes mangees, defaite si 0 vie

## Architecture

### Fichiers Principaux
- `pacman.pde`: Boucle principale (setup, draw, keyPressed)
- `board.pde`: Gestion du plateau de jeu et chargement des niveaux
- `hero.pde`: Logique et deplacements de Pac-Man
- `ghost.pde`: IA et comportement des fantomes
- `game.pde`: Score, vies, etats du jeu
- `menu.pde`: Menu pause avec 6 options
- `highscores.pde`: Gestion des meilleurs scores
- `saveload.pde`: Sauvegarde et chargement
- `types.pde`: Enumerations (TypeCell)
- `constants.pde`: Constantes du jeu
- `pathfinding.pde`: Implementation de l'algorithme de Dijkstra

### Dossiers
- `data/`: Fichiers de donnees
  - `highscores.txt`: Top 5 scores
  - `save.txt`: Sauvegarde de partie
  - `levels/`: Fichiers de niveaux (.txt)

## Extensions Implementees

- **IA Intelligente**: Les fantomes utilisent l'algorithme de Dijkstra pour traquer ou fuir Pac-Man
- **Comportement Adaptatif**: Les fantomes changent de strategie selon le mode power
- **Pathfinding Optimise**: Calcul des distances avec Dijkstra pour mouvement intelligent

## Format des Niveaux

Fichier texte avec:
- Ligne 1: Titre du niveau
- Lignes suivantes: Grille avec
  - `x`: Mur
  - `V`: Vide
  - `o`: Pac-Gomme
  - `O`: Super Pac-Gomme
  - `P`: Position Pac-Man (devient vide apres chargement)
  - `D`: Porte fantomes (extension)
  - `B`: Bonus (extension)

---

Projet realise dans le cadre du cours de Programmation Java.
