extends Node

func close_top_ui() -> bool:
	var top_ui: Node = null
	
	for ui in get_tree().get_nodes_in_group("ui"):
		if ui.visible:
			if top_ui == null or ui.z_index > top_ui.z_index:
				top_ui = ui
				
	if top_ui:
		top_ui.close()
		return true
		
	return false
