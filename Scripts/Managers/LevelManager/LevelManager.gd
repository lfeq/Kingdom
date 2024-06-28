## LevelManager.gd
## This script defines the LevelManager class, which extends Node. It manages the level, including spawning the player once the terrain is generated.

extends Node

## Preload the Player scene.
@onready var playerRef: PackedScene = preload("res://Scenes/Player.tscn")
## Reference to the TileMap node.
@onready var tile_map = $"../TileMap"

## Called when the tile map has finished generating the level.
## Spawns the player at a random position on the tile map.
func _on_tile_map_finished_making_level():
	spawnPlayer()

## Spawns the player at a random position on the tile map.
## Instantiates the player scene, sets its global position, and adds it as a child of the current node.
func spawnPlayer() -> void:
	var tempPlayer: Node = playerRef.instantiate()
	tempPlayer.global_position = tile_map.getRandomTilePosition()
	add_child(tempPlayer)
