extends Node2D
@onready var player = $Player


func map_transition(node):
	var screen_rect = get_viewport().get_visible_rect()
	var screen_size = screen_rect.size
	var position_of_node = node.position
	if node.is_in_group("bullet"):
		if position_of_node.x < 0 or position_of_node.x > screen_size.x or position_of_node.y < 0 or  position_of_node.y > screen_size.y:
			node.queue_free()
			print("0")
	
	else:
		if position_of_node.x < 0:
			position_of_node.x = screen_size.x
		elif position_of_node.x > screen_size.x:
			position_of_node.x = 0
		if position_of_node.y < 0:
			position_of_node.y = screen_size.y
		elif position_of_node.y > screen_size.y:
			position_of_node.y = 0
		node.position = position_of_node
	

