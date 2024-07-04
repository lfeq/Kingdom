## LogController.gd

extends Node2D

## Reference to the state machine.
@onready var stateMachine = $StateMachine
## Reference to the Animated Sprite.
@onready var animatedSprite = $AnimatedSprite2D

## Called when the node is added to the scene.
## Initializes the tree's health and the state machine.
func _ready() -> void:
	stateMachine.init()

## Called every physics frame (fixed frame rate).
## Passes the delta time to the state machine for physics processing.
func _physics_process(delta: float) -> void:
	stateMachine.processPhysics(delta)
	
## Called every frame.
## Passes the delta time to the state machine for frame processing.
func _process(delta: float) -> void :
	stateMachine.processFrame(delta)
