extends Node

@export var SpriteObj:AnimatedSprite2D
@export var animation:String

func Trigger():
	SpriteObj.play(animation)


func _on_trap_triggered(_MM:MainframeMover):
	Trigger()
