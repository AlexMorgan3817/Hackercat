extends Program

func IsUsable(MM:MainframeMover):
	if not super(MM):
		return false
	if not MM.PC.SelectedNode:
		return false
	return true
