# TerrainGenerator.gd
# This script defines the TerrainGenerator class, which extends TileMap. It generates a random terrain map using cellular automata.

extends TileMap

## Signals when the level generator finished creating the level
signal finishedMakingLevel

# Map size settings.
@export_category("Map Size")
## Width of the map
@export var mapWidth: int = 5
## Width of the map
@export var mapHeight: int = 5
## Number of iterations for the cellular automata algorithm and the grass density limit.
@export var numberOfIterations: int = 5
## Probability to spawn a tree. (goes from 0 to 100) 
@export var treeProbability: int = 40
## Probability to spawn a mine. (goes from 0 to 100) 
@export var mineProbability: int = 10

## Reference to the LoadingScreen node.
@onready var loading_screen = $"../LoadingScreen"
@onready var treeRef: PackedScene = preload("res://Scenes/Resources/tree.tscn")

const GRASS_DENSITY_LIMIT: int = 5

## Grid representing the map.
var mapGrid = []
## Test string (purpose not specified in the script).
var testString: String = ""
var currentStep: int = 0
@onready var totalSteps: int = mapWidth * mapHeight

func createMap() -> void:
	currentStep = 0
	loading_screen.updateLoadingScreenLabel("Loading...")
	generateRandomMap()
	for i in numberOfIterations:
		iterateNewMap()
	await drawMap()
	finishedMakingLevel.emit()

## Generates a random map by populating the map grid with random boolean values.
func generateRandomMap() -> void:
	for x in range(mapWidth):
		mapGrid.append([])
		for y in range(mapHeight):
			mapGrid[x].append(randi() % 2 == 0) # Random boolean

## Iterates over the map grid to create a new map based on the number of grasses around each tile.
func iterateNewMap() -> void:
	var result = "Iterating Map..."
	loading_screen.updateLoadingScreenLabel(result)
	var tempMap = []
	for x in range(mapWidth):
		tempMap.append([])
		for y in range(mapHeight):
			tempMap[x].append(numberOfGrassesAroundTile(x, y) >= GRASS_DENSITY_LIMIT)
	mapGrid = tempMap

## Draws the map based on the map grid. Adds terrain and foam to the tilemap.
func drawMap() -> void:
	loading_screen.updateLoadingScreenLabel("Drawing Map...")
	var positions = []
	for x in range(mapWidth):
		await get_tree().create_timer(0.01).timeout  # Allow the screen to update
		for y in range(mapHeight):
			if mapGrid[x][y]:
				positions.append(Vector2i(x, y))
				set_cells_terrain_connect(1, positions, 0, 0) # Add terrain to tilemap
				if numberOfGrassesAroundTile(x, y) >= GRASS_DENSITY_LIMIT:
					set_cell(0, Vector2i(x, y), 6, Vector2i(0, 0)) # Add foam to tilemap
				if randi() % 100 + 1 <= treeProbability:
					#set_cell(2, Vector2i(x, y), 2, Vector2i(0, 0)) # Add tree to tilemap
					spawnResource(Vector2i(x, y), treeRef)
				elif (randi() % 100 + 1 <= mineProbability) and (!isEdgeOfTilemap(x, y) \
				and (numberOfGrassesAroundTile(x, y) == 9) and (!isSurrounded(2, x, y))):
					set_cell(2, Vector2i(x, y), 4, Vector2i(0, 0)) # Add mine to tilemap
			updateLoadingBar()

## Returns the number of grasses around a given tile position.
func numberOfGrassesAroundTile(t_xPosition: int, t_yPosition: int) -> int:
	var numberOfGrasses: int = 0
	for y in range(t_yPosition - 1, t_yPosition + 2):
		for x in range(t_xPosition - 1, t_xPosition + 2):
			if isGrass(x, y):
				numberOfGrasses += 1
	return numberOfGrasses

## Checks if a given tile position contains grass. If the position is out of bounds, it returns true.
func isGrass(t_xPosition: int, t_yPosition: int) -> bool:
	if t_xPosition < 0 or t_xPosition >= mapWidth or t_yPosition < 0 or t_yPosition >= mapHeight:
		return true
	return mapGrid[t_xPosition][t_yPosition]

## Check if is on the edge of the tilemap
func isEdgeOfTilemap(t_xPosition: int, t_yPosition: int) -> bool:
	if t_xPosition == 0 or t_xPosition == (mapWidth - 1) or t_yPosition == 0 or t_yPosition == (mapHeight - 1):
		return true
	return false

## Returns a random tile position within the map that contains grass.
func getRandomTilePosition() -> Vector2:
	var x: int = randi() % mapWidth
	var y: int = randi() % mapHeight
	while not mapGrid[x][y]:
		x = randi() % mapWidth
		y = randi() % mapHeight
	return map_to_local(Vector2i(x, y))
	
## Check if current tile has other painted tiles around it
func isSurrounded(layer: int, t_xPosition: int, t_yPosition: int) -> bool:
	for y in range(t_yPosition - 1, t_yPosition + 2):
		for x in range(t_xPosition - 1, t_xPosition + 2):
			if (get_cell_source_id(layer, Vector2i(x, y)) != -1):
				return true
	return false

## Updates the loading bar based on the current step in the loading process.
func updateLoadingBar() -> void:
	currentStep += 1
	loading_screen.updateProgressBar(float(currentStep * 100) / totalSteps)
	
func spawnResource(position: Vector2i, resourceToSpawn: PackedScene) -> void:
	var tempResource: Node = resourceToSpawn.instantiate()
	tempResource.global_position = map_to_local(position)
	add_sibling(tempResource)
