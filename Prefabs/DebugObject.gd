extends Polygon2D

func _ready():
	if not GLOB.DEBUG:
		queue_free()
