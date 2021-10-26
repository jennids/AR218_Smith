extends KinematicBody2D

var velocity := Vector2(0,0)
export var speed := 180
export var jump := -900
export var climb = 100
export var energy := 10
const GRAVITY := 35

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")
	#show with "pressed"
	
	if Input.is_action_pressed("crouch"): 
		$AnimatedSprite.play("crouch")
	
	if Input.is_action_pressed("climb"):
		velocity.y = climb
		$AnimatedSprite.play("climb")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump
		
	if not is_on_floor():
		$AnimatedSprite.play("jump")

	velocity.y += GRAVITY

	velocity = move_and_slide(velocity, Vector2.UP)

	velocity.x = lerp(velocity.x, 0,0.1)
func _on_Area2D_area_entered(area):
	get_tree().change_scene("res://Scenes/Level1.tscn")
	pass # Replace with function body.


func _on_Collectible2_coin_collected():
	pass # Replace with function body.


func _on_Collectible3_coin_collected():
	pass # Replace with function body.
