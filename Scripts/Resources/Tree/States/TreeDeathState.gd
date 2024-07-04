# TreeDeathState.gd
## This script defines the TreeDeathState class, which extends IState. 
## It represents the death state of a tree.

extends IState

## Reference to tree.
@onready var tree = $"../.."
## Reference to spawn postion
@onready var spawn_resource_position = $"../../SpawnResourcePosition"
@onready var logRef: PackedScene = preload("res://Scenes/Resources/log.tscn")

## Called when the state is entered.
## Plays the idle animation for the tree.
func enter() -> void:
	tree.animatedSprite.play(animationName)
	spawnLog()

## Spawns a log.
func spawnLog() -> void:
	var tempLog: Node = logRef.instantiate()
	tempLog.global_position = spawn_resource_position.global_position
	$"../..".add_sibling(tempLog)
