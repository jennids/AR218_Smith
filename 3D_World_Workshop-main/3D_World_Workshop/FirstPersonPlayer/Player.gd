#modified from https://godottutorials.pro/fps-godot-tutorial/
extends KinematicBody

#physcis
export var moveSpeed: float = 5.0
export var jumpForce : float = 5.0
export var gravity : float = 12.0

# cam look
export var minLookAngle : float = -90.0
export var maxLookAngle : float = 90.0
export var lookSensitivity : float = 0.5

# vectors
var vel : Vector3 = Vector3()
var mouseDelta : Vector2 = Vector2()
 
# player components
onready var camera = get_node("Camera")

# called when an input is detected
func _input (event):
	# did the mouse move?
	if event is InputEventMouseMotion:
		mouseDelta = event.relative

# called every frame
func _process (delta):
	# rotate camera along X axis
	camera.rotation_degrees -= Vector3(rad2deg(mouseDelta.y), 0, 0) * lookSensitivity * delta
 
	# clamp the vertical camera rotation
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	
	# rotate player along Y axis
	rotation_degrees -= Vector3(0, rad2deg(mouseDelta.x), 0) * lookSensitivity * delta
	
	# reset the mouse delta vector
	mouseDelta = Vector2()

# called every physics step
func _physics_process (delta):
	# reset the x and z velocity
	vel.x = 0
	vel.z = 0
	 
	var input := Vector2()
	 
	# movement inputs
	if Input.is_action_pressed("move_forward"):
		input.y -= 1
		$walk.pitch_scale = rand_range(0.8, 1.2)
		$walk.play()
	if Input.is_action_pressed("move_backward"):
		input.y += 1
		$walk.pitch_scale = rand_range(0.8, 1.2)
		$walk.play()
	if Input.is_action_pressed("move_left"):
		input.x -= 1
		$walk.pitch_scale = rand_range(0.8, 1.2)
		$walk.play()
	if Input.is_action_pressed("move_right"):
		input.x += 1
		$walk.pitch_scale = rand_range(0.8, 1.2)
		$walk.play()
	# normalize the input so we can't move faster diagonally
	input = input.normalized()
	
	# get our forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	# set the velocity
	vel.z = (forward * input.y + right * input.x).z * moveSpeed
	vel.x = (forward * input.y + right * input.x).x * moveSpeed
	 
	# apply gravity
	vel.y -= gravity * delta
	 
	# move the player
	vel = move_and_slide(vel, Vector3.UP)
	
	# jump if we press the jump button and are standing on the floor
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jumpForce
