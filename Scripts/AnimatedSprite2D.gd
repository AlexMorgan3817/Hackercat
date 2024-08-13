extends AnimatedSprite2D

@export var AutoplayAnimation_sprite:String = "default"
@export var AutoplayAnimation:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if AutoplayAnimation:
		play(AutoplayAnimation_sprite)


func _on_play_animation_animation_ended(a):
	if AutoplayAnimation:
		play(AutoplayAnimation_sprite)
