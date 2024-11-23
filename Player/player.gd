extends CharacterBody2D

const SPEED = 200
const GRAVITY = 30
const JUMPFORCE = -600
const DASH_SPEED = 800
const DASH_DURATION = 0.2
const WALL_JUMP_FORCE = -800
const WALL_JUMP_HORIZONTAL_SPEED = 200

var dash_time_remaining = 0
var is_touching_wall = false
var has_wall_jumped = false

var jumps = 0
var oob_hits_until_knockback = 0;
func _physics_process(delta):
	# Dash mechanic
	if Input.is_action_just_pressed("dash") and dash_time_remaining <= 0:
		dash_time_remaining = DASH_DURATION
	
	if Input.is_action_pressed("left"):
		if $PlayerSprite.global_position.x > 30:
			velocity.x = -SPEED
		$PlayerSprite.flip_h = true
		
	#Adding in a jump just once if the character is on the floor
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jumps = 0
		
		jumps += 1
		if jumps <= 2:
			print("can double jump", jumps)
			velocity.y += JUMPFORCE/(jumps)
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
			oob_hits_until_knockback = 0
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
		has_wall_jumped = false
	
	# Wall jump mechanic
	if is_on_wall() and not is_on_floor():
		is_touching_wall = true
	else:
		is_touching_wall = false
	
	if Input.is_action_just_pressed("jump") and is_touching_wall and not has_wall_jumped:
		velocity.y = WALL_JUMP_FORCE
		if Input.is_action_pressed("right"):
			velocity.x = -WALL_JUMP_HORIZONTAL_SPEED
		elif Input.is_action_pressed("left"):
			velocity.x = WALL_JUMP_HORIZONTAL_SPEED
		has_wall_jumped = true
	
	# This adds gravity to our character if they are not standing on something
	if not is_on_floor():
		velocity.y += GRAVITY
	print($PlayerSprite.global_position.y)
	if $PlayerSprite.global_position.x < 30:
		if oob_hits_until_knockback > 1000:
			velocity.x = SPEED**2
			velocity.y = WALL_JUMP_FORCE
			oob_hits_until_knockback = 0
		else:
			velocity.x = SPEED
			
		oob_hits_until_knockback += 1
	#gets it moving correctly
	move_and_slide()
