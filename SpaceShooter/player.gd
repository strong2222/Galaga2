extends CharacterBody2D

var bullet_scene = preload("res://bullet_node.tscn")
var move_speed = 250
func _ready():
	pass
func _process(delta):
	get_parent().map_transition(self)
	

func _physics_process(delta):
	
	var mouse_position = get_global_mouse_position()
	
	var direction = mouse_position-global_position
	var move_velocity = Vector2.ZERO
	
	var rotation_angle = direction.angle()
	
	rotation = rotation_angle+PI/2
	if Input.is_action_just_pressed("shoot"):
		shoot(direction,rotation)
	_handle_input(move_velocity)
	move_and_slide()

func _handle_input(move_veloctiy):
	if Input.is_action_pressed("down"):
		move_veloctiy.y +=1
	if Input.is_action_pressed("up"):
		move_veloctiy.y -=1
	if Input.is_action_pressed("left"):
		move_veloctiy.x -=1
	if Input.is_action_pressed("right"):
		move_veloctiy.x +=1
	
	velocity = move_veloctiy.normalized() * move_speed

func shoot(direction,rot):
	var bullet = bullet_scene.instantiate()
	bullet.position = global_position
	bullet.travel(direction,rot)
	get_parent().add_child(bullet)
	print("1")
	
