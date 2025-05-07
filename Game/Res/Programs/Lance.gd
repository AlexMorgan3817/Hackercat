class_name Lance extends Program

@export var LanceSound:AudioStream

func IsUsable(deck:Deck):
	if not super(deck):
		return false
	if not deck.PC.SelectedNode:
		return false
	return true

func UseProgram(deck:Deck):
	var target:Door
	if deck.PC and deck.PC.SelectedNode:
		for i in deck.PC.SelectedNode.Content:
			if i.Host is DoorEntity:
				target = i.Host.MyDoor
				break
	if target and not target.open:
		target.set_open(true)
		PlaySound.playsound(deck.PC.SelectedNode, LanceSound)
		super(deck)
