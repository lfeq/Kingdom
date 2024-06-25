class_name IState
extends Node

@export var animationName: String
@export var movementSpeed: float = 400

var parent: Player

func enter() -> void:
	parent.animatedSprite.play(animationName)
	
func exit() -> void:
	pass
	
func processInput(event: InputEvent) -> IState:
	return null
	
func processFrame(delta: float) -> IState:
	return null
	
func processPhysics(delta: float) -> IState:
	return null
