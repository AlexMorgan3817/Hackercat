extends AnimationPlayer

@export var autostart:bool = false
@export var animation:String = "default"

func _ready():
	if autostart:
		play(animation)

func _on_entity_status_took_damage(ES, currentHits):
	play("TookDamage")
