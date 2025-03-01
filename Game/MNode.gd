@icon("res://Textures/UI_Frame.png")
class_name MNode extends Node2D

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
			i.Bumped.emit(MM)
			MM.Bumped.emit(i)
	return dot

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		for i in Content:
			i.CurrentNode = null

func _ready():
	assert(len(Links) == 4, "MNode should have all four directions.")
	for i in Links:
		if i == null:
			continue
		UndirrectedLinks.append(i)
	Interacted.connect(_on_interacted)

func _on_interacted(mm:MainframeMover):
	for i in Content:
		if is_instance_valid(i):
			i.Interacted.emit(mm)

func Left(mm:MainframeMover):
	MovedOut.emit(mm)
	Content.erase(mm)

func Join(mm:MainframeMover):
	Content.append(mm)
	MovedIn.emit(mm)
