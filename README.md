# My first game using GODOT

This is my first game in GODOT. I'm trying to make a game like 
[Kingdom: Two Crowns](https://store.steampowered.com/app/701160/Kingdom_Two_Crowns/) but with a little more city building. I'm giving myself two weeks to finish the project (24/06/2024 to 08/07/2024)
Wish me luck!

## Assets
I'm currently using [this](https://pixelfrog-assets.itch.io/tiny-swords) asset pack made by Pixel Frog.

## Map Generation
The map is generated using Cellular Automata and applied to the level tilemap. 
Currently, the map generation process takes a long time to load. It's unclear whether this issue is related to the 
editor or if it's a general performance issue with Godot. The code was adapted from another repository of mine, 
where I implemented Cellular Automata in [Unity](https://github.com/lfeq/Artificial-Intelligence-2/blob/master/Ecosystem/Assets/Scripts/Terrain%20Generation/CellularAutomata2D.cs).

Here is a code snippet of the current version in GDScript:
```gd
## Generates a random map by populating the map grid with random boolean values.
func generateRandomMap() -> void:
	for x in range(mapWidth):
		mapGrid.append([])
		for y in range(mapHeight):
			mapGrid[x].append(randi() % 2 == 0) # Random boolean

## Iterates over the map grid to create a new map based on the number of grasses around each tile.
func iterateNewMap() -> void:
	var tempMap = []
	for x in range(mapWidth):
		tempMap.append([])
		for y in range(mapHeight):
			tempMap[x].append(numberOfGrassesAroundTile(x, y) >= GRASS_DENSITY_LIMIT)
	mapGrid = tempMap
```
Here are the results:

![results](ReadmeFiles\MapDemo.gif)

## Resources

### Tree
Trees can be cut down by getting hit, once the health of the tree reaches 0 it spawns a log to be picked up by the player.

![CuttingTrees.gif](ReadmeFiles\CuttingTrees.gif)