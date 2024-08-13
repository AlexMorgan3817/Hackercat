extends ProgressBar

@export var label:RichTextLabel


func _on_player_controller_pwr_changed(PC:PlayerController, PWR:int):
	value = PWR
	max_value = PC.MaxPWR
	if label:
		label.text = "[center]" + str(value) + "/" + str(max_value)

func _on_entity_status_health_changed(ES:EntityStatus, currentHits):
	value = currentHits
	max_value = ES.MaxHits
	if label:
		label.text = "[center]" + str(value) + "/" + str(max_value)
