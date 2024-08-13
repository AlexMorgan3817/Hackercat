extends Node




func _on_lance_program_used(MM:MainframeMover):
	var target:Door
	if MM.PC and MM.PC.SelectedNode:
		for i in MM.PC.SelectedNode.Content:
			var c = i.Host.get_children()
			for j in c:
				if j is Door:
					target = j
					break
			if target:
				break
	if target:
		target.forceopen()
