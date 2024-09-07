@icon("res://Ico/Cube_ico.png")
extends NetAtom

class_name Collectable

@export var ProgramInside:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	$CopyOnInteract.Prog = ProgramInside
