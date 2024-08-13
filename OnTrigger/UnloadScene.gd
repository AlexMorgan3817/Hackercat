extends Button


func _on_pressed():
	get_tree().unload_current_scene()
