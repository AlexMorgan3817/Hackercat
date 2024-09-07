extends Node

class_name Door

@export var MM:MainframeMover
@export var sprite:Sprite2D
@export var colorOpen:Color = Color.GREEN
@export var colorClosed:Color = Color.RED
@export var open:bool = false

@export var password:String = "password"

signal opened(By:MainframeMover)
signal closed(By:MainframeMover)

func _ready():
	update_state()

func update_state():
	if open:
		MM.Dense = false
		sprite.modulate = colorOpen
	else:
		MM.Dense = true
		sprite.modulate = colorClosed

func forceopen():
	open = true
	update_state()
func forceclose():
	open = false
	update_state()
func toogle(user:MainframeMover):
	open = !open
	update_state()
	if open:
		opened.emit(user)
	else:
		closed.emit(user)
		
