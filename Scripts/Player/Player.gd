extends CharacterBody2D

@export var maxSpeed:= 300

@onready var animatedSprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	rotatePlayer(direction)
	changeAnimation(direction)
	velocity = direction * maxSpeed
	move_and_slide()

# Flip sprite to the left if the player moves to the left
# and flip the sprite to the right if the player moves right
func rotatePlayer(direction: Vector2) -> void:
	if direction.x <= -0.1 :
		animatedSprite.flip_h = true
	elif direction.x >= 0.1:
		animatedSprite.flip_h = false
		
# Changes the animation to idle if the player is still 
# and changes the animation to run if the player moves
func changeAnimation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		animatedSprite.play("Idle")
	else:
		animatedSprite.play("Run")
