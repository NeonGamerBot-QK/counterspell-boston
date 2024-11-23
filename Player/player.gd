extends CharacterBody2D

const SPEED = 200
const GRAVITY = 30
const JUMPFORCE = -800
func _ready() -> void:
	print($PlayerSprite.global_position)

func _physics_process(delta):
	#Adding left and right directional movement based on the variable SPEED
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$PlayerSprite.flip_h = false
		
	if Input.is_action_pressed("left"):
		if $PlayerSprite.global_position.x > 20:
			velocity.x = -SPEED
		$PlayerSprite.flip_h = true	
		
	#Adding in a jump just once if the character is on the floor
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	
	#This code slows the character to a stop if you let go of left or right
	velocity.x = lerp(int(velocity.x), 0, .1)
	
	#This adds gravity to our character if they are not standing on something
	if not is_on_floor():
		velocity.y += GRAVITY
	
	#gets it moving correctly
	move_and_slide()
