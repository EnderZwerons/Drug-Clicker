extends Control

const Item = preload("res://Item.gd")

var itemArray = [Item.new("Marajuana", 10), Item.new("Cocaine", 25), Item.new("Methamphetamine", 50), Item.new("Heroin", 100)]

var labelArray = []

var initialized:bool = false

func _ready():
	InitializeInSceneObjects()
	
func GetAllNodes(node) -> Array:
	var nodeArray:Array
	for N in node.get_children():
		nodeArray += [N]
		if N.get_child_count() > 0:
			nodeArray += GetAllNodes(N)
	return nodeArray
	
func InitializeInSceneObjects():
	for child in GetAllNodes(self):
		if child is TextureButton:
			child.pressed.connect(GlobalBtnBehaviour)
			if child.name.ends_with("_Obtain"):
				child.pressed.connect(
					func():
						ItemObtain(GetItemByName(child.name.split("_")[0]))
				)
			elif child.name.ends_with("_Upgrade"):
				child.pressed.connect(
					func():
						ItemUpgrade(GetItemByName(child.name.split("_")[0]))
				)
		elif child is Label and child.name.begins_with("ItemValue_"):
			labelArray += [child]
	initialized = true
	
func GetItemByName(itemName:String) -> Item:
	for item in itemArray:
		if item.name == itemName:
			return item
	return itemArray[0]
	
			
func GlobalBtnBehaviour():
	$BtnSound.play()
	
	
func Buy(item:Item) -> bool:
	if item.amount >= item.upgradeCost * item.upgradedAmount:
		item.amount -= (item.upgradeCost * item.upgradedAmount)
		return true
	return false

func ItemObtain(item:Item):
	item.Obtain()

func ItemUpgrade(item:Item):
	if Buy(item):
		item.Upgrade()

func _process(delta):
	if !initialized:
		pass
	for i in range(len(labelArray)):
		labelArray[i].text = str(itemArray[i].amount)
	
		
