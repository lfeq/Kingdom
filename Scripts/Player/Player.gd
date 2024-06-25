class_name Player
extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D
@onready var stateMachine = $StateMachine

func _ready() -> void:
	stateMachine.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	stateMachine.processInput(event)
	
func _physics_process(delta: float) -> void:
	stateMachine.processPhysics(delta)
	
func _process(delta: float) -> void :
	stateMachine.processFrame(delta)
