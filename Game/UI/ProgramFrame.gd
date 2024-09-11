extends Node2D

class_name ProgramFrame

@export var MM:MainframeMover
@export var MyProgram:Program

signal ProgramFailedUse
signal ProgramUsed
signal EmptyUse

func RemoveProgram():
	remove_child(MyProgram)
	MyProgram.queue_free()
	MyProgram = null

func SetProgram(p:Program):
	if MyProgram != null:
		remove_child(MyProgram)
		MyProgram.queue_free()
	MyProgram = p
	add_child(p)

func ActivateProgram():
	if not MyProgram:
		EmptyUse.emit()
		return
	if not MyProgram.IsUsable(MM):
		MyProgram.Inusable(MM)
		ProgramFailedUse.emit()
		return
	MyProgram.UseProgram(MM)
	ProgramUsed.emit()

func _on_player_controller_item_used():
	ActivateProgram()


func _on_texture_button_pressed():
	if MyProgram:
		RemoveProgram()
