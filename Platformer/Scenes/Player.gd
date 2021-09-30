extends KinematicBody2D

const GRAVITY = 35

var velocity = Vector2(0,0)

export var speed = 100
export var jump = -900


func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	else: $AnimatedSprite.play("idle")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump
		
	if not is_on_floor():
		$AnimatedSprite.play("jump")
		#get_node("AnimatedSprite)
		velocity.y += GRAVITY
	
	print(velocity)
	velocity.x = lerp(velocity.x,0,0.1)
	move_and_slide(velocity,Vector2.UP)
	
