extends GutTest

func test_use_returns_false_without_health_component():
	var medkit = MedKit.new()
	var target = Node.new()  # un Node sans HealthComponent
	
	var result = medkit.use(target)
	
	assert_false(result)
	
	target.free()

func test_use_returns_false_when_health_full():
	var medkit = MedKit.new()
	var target = Node.new()
	var health_component = HealthComponent.new()
	
	health_component.name = "HealthComponent"
	
	target.add_child(health_component)
	
	health_component.health = 4
	health_component.max_health = 4
	
	var result = medkit.use(target)
	
	assert_false(result)
	
	target.free()
	
func test_use_returns_true_when_health_full():
	var medkit = MedKit.new()
	var target = Node.new()
	var health_component = HealthComponent.new()
	
	health_component.name = "HealthComponent"
	
	target.add_child(health_component)
	
	health_component.health = 1
	health_component.max_health = 4
	
	var result = medkit.use(target)
	
	assert_true(result)
	
	target.free()
