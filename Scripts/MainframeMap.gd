extends Node2D

class_name Mainframe

@export var circuit:TileMap
@export var tilesize:int = 32
@export var tileoffset:Vector2 = -Vector2(16, 16)

func _ready():
	process_circuit()

func process_circuit():
	var rect:Rect2i = circuit.get_used_rect()
	if GLOB.DEBUG:
		print("Begin")
		var P:Polygon2D = Polygon2D.new()
		P.color = Color(1, 0.7, 0.7, 0.3)
		var begin = tilesize * (Vector2(rect.position) + Vector2(1,1)) + tileoffset
		var end   = tilesize * (Vector2(rect.end) + Vector2(1,1)) + tileoffset
		var p = []
		p.append(begin)
		p.append(Vector2(end.x, begin.x))
		p.append(end)
		p.append(Vector2(begin.x, end.y))
		P.set_polygon(p)
		add_child(P)
		print(P.polygon)
