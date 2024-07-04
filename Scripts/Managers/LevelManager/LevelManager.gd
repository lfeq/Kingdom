## LevelManager.gd
## This script defines the LevelManager class, which extends Node. 
## It manages the level, including spawning the player once the terrain is generated.

extends Node

## Preload the Player scene.
@onready var playerRef: PackedScene = preload("res://Scenes/Player.tscn")
## Reference to the TileMap node.
@onready var tile_map = $"../TileMap"
## Reference to the LoadingScreen node.
@onready var loading_screen = $"../LoadingScreen"
## Reference to resources counter.
@onready var resources_counter_canvas = $"../ResourcesCounterCanvas"

## Called when the tile map has finished generating the level.
## Removes the Camera2D node and spawns the player at a random position on the tile map.
func _on_tile_map_finished_making_level():
	loading_screen.queue_free()
	spawnPlayer()
	resources_counter_canvas.init()

## Spawns the player at a random position on the tile map.
## Instantiates the player scene, sets its global position, and adds it as a child of the current node.
func spawnPlayer() -> void:
	var tempPlayer: Node = playerRef.instantiate()
	tempPlayer.global_position = tile_map.getRandomTilePosition()
	add_sibling(tempPlayer)

## Called when the play button on the loading screen is pressed.
## Updates the loading screen label and starts the map creation process.
func _on_loading_screen_pressed_play():
	loading_screen.updateLoadingScreenLabel("Planting seed...")
	tile_map.createMap()
