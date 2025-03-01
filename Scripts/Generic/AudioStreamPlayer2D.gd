class_name ASP extends AudioStreamPlayer2D
func _on_player_controller_unable_to_move():
	playing = true


func _on_switch_interacted(_MM:MainframeMover):
	playing = true

func _on_collectable_picked_up():
	var t = get_parent()
	t.remove_child(self)
	t.get_parent().add_child(self)
	playing = true

func _on_mover_moved(N, silent):
	if silent:
		return
	playing = true

func _on_mover_bumped(MMCollided):
	playing = true

func _on_mover_pre_movement(MM, N, duration, silent):
	if silent: return
	playing = true
