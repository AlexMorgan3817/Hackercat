extends ProgressBar

@export var label:RichTextLabel

func set_val(val:int, max_val:int):
	value = val
	max_value = max_val
	if label:
		label.text = "[center]" + str(value) + "/" + str(max_value)

func _on_player_controller_pwr_changed(deck:Deck, pwr:int):
	set_val(pwr, deck.MaxPWR)

func _on_entity_status_health_changed(ES:EntityStatus, currentHits):
	set_val(currentHits, ES.MaxHits)
