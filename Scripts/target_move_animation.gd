extends Node2D

class_name TargetMoveAnimation

@export var MM:MainframeMover

# Called when the node enters the scene tree for the first time.
func _ready():
	if not MM:
		var p = get_parent()
		if p:
			for i in p.get_children():
				if i is MainframeMover:
					MM = i
					break
	MM.AnimatePreMovement.connect(_premove)
	MM.AnimatePreMoveFailed.connect(_failed)
	MM.AnimateFinishMovement.connect(_finish)

func _finish(MM:MainframeMover, N:MNode):
	set_visible(false)
	
func _failed(MM:MainframeMover, N:MNode):
	set_visible(false)

func _premove(MM:MainframeMover, N:MNode):
	set_visible(true)
	set_global_position(N.get_global_position())
