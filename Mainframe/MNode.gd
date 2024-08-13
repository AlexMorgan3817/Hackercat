extends Node2D

class_name MNode#, "res://Textures/UI_Frame.png"

@export var Links:Array[MNode] = [null,null,null,null]
@export var Content:Array[MainframeMover]
var UndirrectedLinks:Array[MNode]

@export var Passable:bool = true

signal Interacted(MM:MainframeMover)
signal MovedIn(MM:MainframeMover)
signal MovedOut(MM:MainframeMover)

func ArePassing(MM:MainframeMover):
	if not Passable:
		return false
	var dot = true
	for i in Content:
		if is_instance_valid(i) and i.Dense:
			dot = false
			i.emit_signal("Bumped", MM)
			MM.emit_signal("Bumped", i)
	return dot

func _ready():
	assert(len(Links) == 4, "MNode should have all four directions.")
	for i in Links:
		if i == null:
			continue
		UndirrectedLinks.append(i)


func _on_interacted(MM):
	for i in Content:
		if is_instance_valid(i):
			i.emit_signal("Interacted", MM)
