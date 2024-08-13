extends Node

func _on_entity_status_death(ES):
	get_tree().reload_current_scene()

func _on_restart_timer_timeout():
	get_tree().reload_current_scene()

func _on_pressed():
	get_tree().reload_current_scene()
