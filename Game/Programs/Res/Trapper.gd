class_name Trapper extends Program

@export var TrapScene:PackedScene

func IsUsable(deck:Deck):
	if not super(deck):
		return false
	if len(deck.PC.MM.CurrentNode.Content) == 1:
		return true
	for i in deck.PC.MM.CurrentNode.Content:
		if is_instance_valid(i) and i.Host is Trap:
			return false
	return true
