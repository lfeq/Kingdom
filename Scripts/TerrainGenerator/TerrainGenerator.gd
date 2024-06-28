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

## Reference to the LoadingScreen node.
@onready var loading_screen = $"../Camera2D/LoadingScreen"

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

## Returns a random tile position within the map that contains grass.
func getRandomTilePosition() -> Vector2:
	var x: int = randi() % mapWidth
	var y: int = randi() % mapHeight
	while not mapGrid[x][y]:
		x = randi() % mapWidth
		y = randi() % mapHeight
	return map_to_local(Vector2i(x, y))

## Updates the loading bar based on the current step in the loading process.
func updateLoadingBar() -> void:
	currentStep += 1
	loading_screen.updateProgressBar(float(currentStep * 100) / totalSteps)
