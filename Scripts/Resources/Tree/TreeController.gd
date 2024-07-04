# TreeController.gd
## This script defines the TreeController class, which extends Node2D. 
## It manages the health and state of a tree, 
## transitioning between states based on damage taken.

extends Node2D

## Maximum health the tree can have.
@export var maxHealth: float = 50
## The state to transition to when the tree takes damage.
@export var damageState: IState
## The state to transition to when the tree is chopped.
@export var deathState: IState

## Reference to the state machine.
@onready var stateMachine = $StateMachine
## Reference to the Animated Sprite.
@onready var animatedSprite = $AnimatedSprite2D

## Current health of the tree.
var currentHealth: float

## Called when the node is added to the scene.
## Initializes the tree's health and the state machine.
func _ready() -> void:
	currentHealth = maxHealth
	stateMachine.init()

## Called every physics frame (fixed frame rate).
## Passes the delta time to the state machine for physics processing.
func _physics_process(delta: float) -> void:
	stateMachine.processPhysics(delta)
	
## Called every frame.
## Passes the delta time to the state machine for frame processing.
func _process(delta: float) -> void :
	stateMachine.processFrame(delta)

## Handles damage taken by the tree.
## Reduces the tree's health by the specified damage amount and transitions to the damage state.
## If the tree's health is depleted, it would transition to death state.
## TODO: Spawn resource so the player can pick it up
func takeDamage(damage: float) -> void:
	if currentHealth <= 0:
		return
	currentHealth -= damage
	stateMachine.changeState(damageState)
	if currentHealth <= 0:
		stateMachine.changeState(deathState)
