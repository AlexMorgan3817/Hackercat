class_name TargetMoveAnimation extends Node2D
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
	MM.PreMovement.connect(_premove)
	MM.PreMoveFailed.connect(_failed)
	MM.FinishMovement.connect(_finish)

func _finish(mover:MainframeMover, N:MNode):
	set_visible(false)
	
func _failed(mover:MainframeMover, N:MNode):
	set_visible(false)

func _premove(mover:MainframeMover, N:MNode, duration:float, silent:bool):
	set_visible(true)
	set_global_position(N.get_global_position())
