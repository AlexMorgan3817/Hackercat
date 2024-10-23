extends Control

class_name ProgramFrame

@export var MM:MainframeMover
@export var MyProgram:Program

@export var DescButton:BaseButton
@export var DelButton:BaseButton
@export var DescObject:RichTextLabel

signal ProgramFailedUse
signal ProgramUsed
signal EmptyUse


func RemoveProgram():
	MyProgram.queue_free()
	MyProgram = null

func SetProgram(p:Program):
	if MyProgram != null:
		MyProgram.queue_free()
	MyProgram = p

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

func examine():
	if MyProgram:
		DescObject.visible = true
		DescObject.text = "[center]" + MyProgram.Name + "[/center]\n"\
			+ MyProgram.Description + "\n" +\
			"Use Cost: " + str(MyProgram.requiredPWR) + "."
	GLOB.addtimer(self, func(): DescObject.visible = false, 40)
