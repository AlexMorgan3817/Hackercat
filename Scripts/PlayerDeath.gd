extends Node

@export var player:Player
@export var ES:EntityStatus

func _ready():
	ES.Death.connect(_death)

func _death(ES:EntityStatus):
	player.Mover.enabled = false
	player.remove_child(player.UI)
	player.get_parent().add_child.call_deferred(player.UI)
	player.remove_child(player.DamageOverlay)
	player.get_parent().add_child.call_deferred(player.DamageOverlay)
	player.queue_free()
	
