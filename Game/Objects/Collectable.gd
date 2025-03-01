@icon("res://Textures/Ico/Cube_ico.png")
class_name Collectable extends NetAtom
@export var ProgramInside:Program

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	$CopyOnInteract.Prog = ProgramInside
