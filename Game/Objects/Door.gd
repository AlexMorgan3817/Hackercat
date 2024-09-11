extends Node

class_name Door

@export var MM:MainframeMover
@export var sprite:Sprite2D
@export var colorOpen:Color = Color.GREEN
@export var colorClosed:Color = Color.RED
@export var open:bool = false

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

func set_open(v:bool, user:MainframeMover = null):
	open = v
	update_state()
	if open:
		opened.emit(user)
	else:
		closed.emit(user)

func toogle(user:MainframeMover):
	set_open(!open, user)
		
