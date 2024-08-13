extends Program

@export var TrapScene:PackedScene

func IsUsable(MM:MainframeMover):
	if not super(MM):
		return false
	if len(MM.CurrentNode.Content) == 1:
		return true
	for i in MM.CurrentNode.Content:
		if is_instance_valid(i) and i.Host is Trap:
			return false
	return true

