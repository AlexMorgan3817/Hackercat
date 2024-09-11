extends Program

func IsUsable(MM:MainframeMover):
	if not super(MM):
		return false
	if not MM.PC.SelectedNode:
		return false
	return true

func UseProgram(MM:MainframeMover):
	var target:Door
	if MM.PC and MM.PC.SelectedNode:
		for i in MM.PC.SelectedNode.Content:
			if i.Host is DoorEntity:
				target = i.Host.MyDoor
				break
	if target and not target.open:
		target.set_open(true)
		super(MM)
