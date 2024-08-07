## Player.gd
## This script defines the Player class, which extends CharacterBody2D. 
## It handles the player's state and animation.

class_name Player
extends CharacterBody2D

signal picked_up_wood

## Onready variables for AnimatedSprite2D and StateMachine nodes.
@onready var animatedSprite = $AnimatedSprite2D
@onready var stateMachine = $StateMachine

## Defines the maximun movement speed of the player.
@export var maxMovementSpeed: float = 400
## Defines the damage the player does
@export var damage: float = 15

## Defines the last direction the player moved to.
var lastLookAtDirection: Vector2

## Called when the node is added to the scene.
## Initializes the state machine.
func _ready() -> void:
	stateMachine.init()
	lastLookAtDirection = Vector2.ONE
	
## Handles unhandled input events.
## Passes the input event to the state machine for processing.
func _unhandled_input(event: InputEvent) -> void:
	stateMachine.processInput(event)
	
## Called every physics frame (fixed frame rate).
## Passes the delta time to the state machine for physics processing.
func _physics_process(delta: float) -> void:
	stateMachine.processPhysics(delta)
	
## Called every frame.
## Passes the delta time to the state machine for frame processing.
func _process(delta: float) -> void :
	stateMachine.processFrame(delta)

## Called when another area enters the player's attack collider.
## If the area belongs to the "Tree" group, it inflicts damage to the tree.
func _on_attack_collider_area_entered(area: Area2D):
	if area.is_in_group("Tree"):
		area.get_parent().takeDamage(damage)

## Called when another area enters the player's pick up collider
## If the area belongs to the "Log" group, it is added to the resources counter (not yet implemented).
func _on_pick_up_collider_area_entered(area: Area2D):
	if area.is_in_group("Log"):
		area.get_parent().queue_free()
		picked_up_wood.emit()
