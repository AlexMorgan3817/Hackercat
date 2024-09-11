extends Node

@export var animator:AnimatedSprite2D
@export var animation:String = "default"

var playing:bool = false

signal AnimationEnded(a:String)

func trigger():
	animator.play(animation)
	playing = true


func _on_simple_mind_attack(MM, target):
	trigger()


func _on_animated_sprite_2d_animation_finished():
	playing = false
	AnimationEnded.emit(animation)
