extends CharacterBody2D


const GRAVITY = 3000
const JUMP = -1400.0
const MAX_FALL_VELOCITY = 700
const MAX_UP_VELOCITY = -700

func _physics_process(delta):
	if velocity.y < MAX_FALL_VELOCITY:
		velocity.y += GRAVITY * delta
	else:
		velocity.y = MAX_FALL_VELOCITY
	
	if Input.is_action_just_pressed('ui_accept'):
		velocity.y = MAX_UP_VELOCITY

	move_and_slide()

