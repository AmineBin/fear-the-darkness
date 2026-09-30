class_name MedKit

extends InvItem

func use(target: Node) -> bool:
	if not target.has_node("HealthComponent"):
		return false
	
	var health_component = target.get_node_or_null("HealthComponent")
	
	if health_component.can_be_healed() == false:
		return false
	
	health_component.regain_health(4)
	return true
