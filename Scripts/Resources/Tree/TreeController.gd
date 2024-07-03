# TreeController.gd
extends Node2D

@onready var stateMachine = $StateMachine

func _ready() -> void:
	stateMachine.initNoPlayer()

## Called every physics frame (fixed frame rate).
## Passes the delta time to the state machine for physics processing.
func _physics_process(delta: float) -> void:
	stateMachine.processPhysics(delta)
	
## Called every frame.
## Passes the delta time to the state machine for frame processing.
func _process(delta: float) -> void :
	stateMachine.processFrame(delta)
