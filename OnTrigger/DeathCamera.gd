extends Node
@export var Host:Node2D
@export var scene:PackedScene

func trigger():
	var cam:Node2D = scene.instantiate()
	GLOB.get_global_node(Host).add_child(cam)
	cam.set_global_position(Host.get_global_position())

func _on_entity_status_death(ES):
	trigger()
