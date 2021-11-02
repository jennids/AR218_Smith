extends KinematicBody2D

var velocity = Vector2()
export var speed = 50
const GRAVITY := 35
export var direction = -1
export var can_fall = false

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
