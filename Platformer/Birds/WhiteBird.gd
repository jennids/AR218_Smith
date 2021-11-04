extends KinematicBody2D

var velocity = Vector2()
export var speed = 50
const GRAVITY := 35
export var direction = -1
export var can_fall = false
export var stop_on_slope = true 

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("idle")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$AnimatedSprite.play("jump")
		
	velocity.y += GRAVITY

	velocity = move_and_slide(velocity,Vector2.UP,true)
	stop_on_slope = true 
	
func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h()
		$ground_check.position.x = $ground_check.position.x *1
	if can_fall:
		$ground_check.enabled = false

func _process(delta):
	if is_on_wall():
		flip_enemy()
	if not can_fall:
		if not $ground_check.is_colliding() and is_on_floor():
			flip_enemy()
		direction = direction * 1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	velocity.y += GRAVITY
	velocity.x = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)
func flip_enemy():
	direction = direction * 1
	$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	$ground_check.position.x = $ground_check.position.x *1
