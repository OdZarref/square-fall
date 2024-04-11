extends CharacterBody2D


const GRAVITY = 3000
const JUMP = -1400.0
const MAX_FALL_VELOCITY = 1000
const MAX_UP_VELOCITY = -700
var block_player_input : bool
var hard_coded_speed : bool


func _physics_process(delta):
	if hard_coded_speed:
		velocity.y = 0

	else:
		if velocity.y < MAX_FALL_VELOCITY:
			velocity.y += GRAVITY * delta
		else:
			velocity.y = MAX_FALL_VELOCITY
		
		if not block_player_input:
			if Input.is_action_just_pressed('ui_accept'):
				velocity.y = MAX_UP_VELOCITY

	move_and_slide()

