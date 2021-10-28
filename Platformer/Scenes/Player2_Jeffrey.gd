extends KinematicBody2D

var velocity := Vector2(0,0)
export var speed := 150
export var jump := -900
export var climb = 100
export var energy := 10
const GRAVITY := 35

#this boolean will limit when the animation can change
var anim_can_change = true

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
		anim_can_change = true
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
		anim_can_change = true
	#changed to elif and put with the others
	
	elif Input.is_action_pressed("crouch"): 
		$AnimatedSprite.play("crouch")
		
	#changed to elif and put with the others
	elif Input.is_action_pressed("climb"):
		velocity.y = climb
		$AnimatedSprite.play("climb")
	
	#changed to only do if anim can change
	elif anim_can_change:
		$AnimatedSprite.play("idle")
	#show with "pressed"
	
		
	#added the anim can change
	if Input.is_action_just_pressed("jump") and is_on_floor() and anim_can_change:
		$AnimatedSprite.play("jump")
		#flip the anim can change switch.  
		anim_can_change = false
		#velocity.y += jump
		
		
	#added anim can change limiter
	if not is_on_floor() and anim_can_change:
		$AnimatedSprite.play("jump")

	velocity.y += GRAVITY

	velocity = move_and_slide(velocity, Vector2.UP,true)

	velocity.x = lerp(velocity.x, 0,0.1)
	
	
	
func _on_Area2D_area_entered(area):
	get_tree().change_scene("res://Scenes/Level1.tscn")
	pass # Replace with function body.


func _on_Collectible2_coin_collected():
	pass # Replace with function body.


func _on_Collectible3_coin_collected():
	pass # Replace with function body.

#new signal connection
func _on_AnimatedSprite_animation_finished():
	#allow animations to change again.
	anim_can_change = true
	pass # Replace with function body.

#signal added to jump on the correct animation frame
func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.animation == "jump" and $AnimatedSprite.frame == 5:
		velocity.y += jump
		#print(3)
	
