extends RichTextLabel

@export var pf:ProgramFrame

func _on_button_button_down():
	if pf.MyProgram:
		visible = true
		text = "[center]" + pf.MyProgram.Name + "[/center]\n"\
			+ pf.MyProgram.Description + "\n" +\
			"Use Cost: " + str(pf.MyProgram.requiredPWR) + "."


func _on_button_button_up():
	visible = false
