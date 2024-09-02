extends CharacterBody2D
var bullet_speed = 300

var hFrame = 7
var vFrame = 10
var Frame = 7


func _ready():
	$Sprite2D.vframes = vFrame
	$Sprite2D.hframes = hFrame
	$Sprite2D.frame = Frame
func _process(delta):
	position += velocity * delta
	get_parent().map_transition(self)
	
func travel(direction,mouse_rotation):
	rotation = mouse_rotation
	
	velocity = direction.normalized()*bullet_speed
	
		


