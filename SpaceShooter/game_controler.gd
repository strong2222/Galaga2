extends Node2D

var enemy_scene = preload("res://enemy.tscn")
enum Enemies { type_a, type_b, type_c }
var player_scene
@export var spawn_interval = 3
@export var max_enemies = 20
@export var difficulty_increase_rate = 0.95
@export var difficulty_interval = 30

var enemies = []
var current_interval
var spawn_timer

func _ready():
	spawn_timer = Timer.new()
	spawn_timer.connect("timeout",spawn_enemy)
	spawn_timer.autostart = true
	add_child(spawn_timer)
	current_interval = spawn_interval
	
	
	player_scene = get_parent().get_node("Player")
	
	var difficulty_timer = Timer.new()
	difficulty_timer.connect("timeout",increase_difficulty)
	difficulty_timer.autostart = true
	difficulty_timer.wait_time = difficulty_interval
	add_child(difficulty_timer)
	difficulty_timer.start()
	
	
	

func _process(delta):
	pass
func start_timer():
	spawn_timer.wait_time = current_interval
	spawn_timer.start()
func increase_difficulty():
	current_interval *= difficulty_increase_rate
	start_timer()

func spawn_enemy():
	var enemy_types = [Enemies.type_a, Enemies.type_b, Enemies.type_c]
	var enemy_type = enemy_types[randi() % enemy_types.size()]
		
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.initialize(enemy_type)
		
	get_parent().add_child.call_deferred(enemy_instance)
	var angle = randf() * PI *2
	var distance_from_player = 600
	enemy_instance.position = player_scene.position + Vector2(cos(angle),sin(angle))* distance_from_player
