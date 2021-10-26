extends Area2D

signal coin_collected

func _on_Collectible_body_entered(body):
	print(body)
	$AnimatedSprite.play("Bounce")
	pass # Replace with function body.
	Global.score = Global.score + 1
	emit_signal("coin collected")
	print(Global.score)
	set_collision_layer_bit(3, false)
	set_collision_mask_bit(0, false)

func _on_AnimatedSprite_animation_finished(anim_name):
	if anim_name == "Bounce":
		queue_free()
	pass # Replace with function body.
