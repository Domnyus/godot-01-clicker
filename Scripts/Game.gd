extends Node

var counter: int = 0
var click_ammount = 1
var upgrades = []
@onready var buttons = [
	get_node("CanvasLayer/ShopArea/Panel/Click/ClickAmmount"),
	get_node("CanvasLayer/ShopArea/Panel/Gathering/Gathering"),
	get_node("CanvasLayer/ShopArea/Panel/Mining/Mining"),
	get_node("CanvasLayer/ShopArea/Panel/Generator/Generator")
]

func _ready():
	var up_ammount = {
		"cost": 5,
		"ammount": 1,
		"calc": "(x + 3) * 1.2"
	}
	var up_gathering = {
		"enabled": false,
		"cost": 100,
		"ammount": 1,
		"calc": "(x + 50) * 1.15"
	}
	var up_mining = {
		"enabled": false,
		"cost": 2000,
		"ammount": 3,
		"calc": "(x + 1000) * 1.10"
	}
	var up_generator = {
		"enabled": false,
		"cost": 15000,
		"ammount": 9,
		"calc": "(x + 7500) * 1.05"
	}
	var up_magic = {
		"enabled": false,
		"cost": 50000,
		"ammount": 27,
		"calc": "(x + 2500) * 1.02"
	}
	var up_creation = {
		"enabled": false,
		"cost": 100000,
		"ammount": 81,
		"calc": "(x + 50000) * 1.01"
	}
	upgrades.push_back(up_ammount)
	upgrades.push_back(up_gathering)
	upgrades.push_back(up_mining)
	upgrades.push_back(up_generator)
	upgrades.push_back(up_magic)
	upgrades.push_back(up_creation)
			

func _on_button_pressed():
	counter += int(upgrades[0].ammount)
	update_text()

func _on_click_ammount_pressed():
	buy_auto(0)

func _on_gathering_pressed():
	buy_auto(1)

func _on_mining_pressed():
	buy_auto(2)

func _on_generator_pressed():
	buy_auto(3)
	
func _on_magic_pressed():
	buy_auto(4)

func _on_creation_pressed():
	buy_auto(5)

func _on_timer_timeout():
	for up in upgrades:
		if up.has("enabled") && up.enabled:
			counter += int(up.ammount)
			print(0)
		update_text()
	pass
		
func buy_auto(index: int):
	if int(upgrades[index].cost) <= int(counter):
		counter -= int(upgrades[index].cost)
		var expression = Expression.new()
		expression.parse(upgrades[index].calc.replace("x", str(upgrades[index].cost)))
		upgrades[index].cost = str(expression.execute())
		buttons[index].text = str(upgrades[index].cost)
		if upgrades[index].has("enabled") && !upgrades[index].enabled:
			upgrades[index].enabled = true
		else:
			upgrades[index].ammount += 1
	update_text()
	pass

func update_text():
	get_node("CanvasLayer/ClickArea/label_counter").text = str(counter)
	pass
