extends CharacterBody2D

var enemyType
enum Enemies{type_a,type_b,type_c}
enum Behaviour{aggressive,passive,attacking}
var current_behaviour = Behaviour.aggressive
@export var speed = 50
var player
var is_attacking: bool = false

func initialize(type: Enemies):
	enemyType = type


func _ready():
	
	player = get_parent().get_node("Player")
	
	
	var direction = player.position-position
	rotation = direction.normalized().angle()+PI/2

	match enemyType:
		Enemies.type_a:
			set_type_a()
		Enemies.type_b:
			set_type_b()
		Enemies.type_c:
			set_type_c()

func _process(delta):
	var direction = player.position - position
	
	if not is_attacking:
		if player.position != position:
			current_behaviour = Behaviour.aggressive
		else:
			current_behaviour = Behaviour.passive
	
	match current_behaviour:
		Behaviour.aggressive :
			aggresive_stance(direction)

		Behaviour.passive:
			passive_stance()

		Behaviour.attacking:
			attacking_stance(direction)
			


	move_and_slide()
	

func _physics_process(delta):
	pass

func set_type_a():
	$Sprite2D.hframes = 10
	$Sprite2D.vframes = 9 
	$Sprite2D.frame = 19

func set_type_b():
	$Sprite2D.hframes = 10
	$Sprite2D.vframes = 9 
	$Sprite2D.frame = 24

func set_type_c():
	$Sprite2D.hframes = 10
	$Sprite2D.vframes = 9 
	$Sprite2D.frame = 17
	
func aggresive_stance(direction):
	rotation = direction.normalized().angle() + PI / 2
	velocity =  direction.normalized()* speed
func passive_stance():
	velocity = Vector2.ZERO
func attacking_stance(direction):
	rotation = direction.normalized().angle() + PI / 2
	velocity = direction.normalized() * speed * 4
func in_attack_range(body):
	is_attacking = true
	if body.is_in_group("player"):
		current_behaviour =Behaviour.attacking
		print("suga")
		
		
func out_attack_range(body):
	is_attacking = false
	if body.is_in_group("player"):
		current_behaviour = Behaviour.passive
