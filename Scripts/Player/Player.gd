## Player.gd
## This script defines the Player class, which extends CharacterBody2D. It handles the player's state and animation.

class_name Player
extends CharacterBody2D

## Onready variables for AnimatedSprite2D and StateMachine nodes.
@onready var animatedSprite = $AnimatedSprite2D
@onready var stateMachine = $StateMachine

## Defines the maximun movement speed of the player.
@export var maxMovementSpeed: float = 400

## Defines the last direction the player moved to.
var lastLookAtDirection: Vector2

## Called when the node is added to the scene.
## Initializes the state machine with the current instance (self).
func _ready() -> void:
	stateMachine.init(self)
	lastLookAtDirection = Vector2.ZERO
	
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
