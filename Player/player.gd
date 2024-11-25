extends CharacterBody2D

const SPEED = 200
const GRAVITY = 30
const JUMPFORCE = -600
const DASH_SPEED = 800
const DASH_DURATION = 0.2
const WALL_JUMP_FORCE = -800
const WALL_JUMP_HORIZONTAL_SPEED = 200
const MAX_WALL_JUMPS = 2

var dash_time_remaining = 0
var is_touching_wall = false
var wall_jump_count = 0

func _physics_process(delta):
	# Dash mechanic
	if Input.is_action_just_pressed("dash") and dash_time_remaining <= 0:
		dash_time_remaining = DASH_DURATION
	
	if dash_time_remaining > 0:
		dash_time_remaining -= delta
		if Input.is_action_pressed("right"):
			velocity.x = DASH_SPEED
			$PlayerSprite.flip_h = false
		elif Input.is_action_pressed("left"):
			velocity.x = -DASH_SPEED
			$PlayerSprite.flip_h = true
	else:
		# Adding left and right directional movement based on the variable SPEED
		if Input.is_action_pressed("right"):
			velocity.x = SPEED
			$PlayerSprite.flip_h = false
		elif Input.is_action_pressed("left"):
			if $PlayerSprite.global_position.x > 30:
				velocity.x = -SPEED
			$PlayerSprite.flip_h = true
		else:
			# This code slows the character to a stop if you let go of left or right
			velocity.x = lerp(int(velocity.x), 0, .1)
	
	# Adding in a jump just once if the character is on the floor
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
		wall_jump_count = 0  # Reset wall jump count when on the floor
	
	# Wall jump mechanic
	if is_on_wall() and not is_on_floor():
		is_touching_wall = true
	else:
		is_touching_wall = false
	
	if Input.is_action_just_pressed("jump") and is_touching_wall and wall_jump_count < MAX_WALL_JUMPS:
		velocity.y = WALL_JUMP_FORCE
		if Input.is_action_pressed("right"):
			velocity.x = -WALL_JUMP_HORIZONTAL_SPEED
		elif Input.is_action_pressed("left"):
			velocity.x = WALL_JUMP_HORIZONTAL_SPEED
		wall_jump_count += 1
	
	# This adds gravity to our character if they are not standing on something
	if not is_on_floor():
		velocity.y += GRAVITY
	
	# gets it moving correctly
	move_and_slide()
