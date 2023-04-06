class_name Item

var amount:int = 0

var upgradedAmount:int = 1

var upgradeCost:int = 5

var name:String = ""

var myself:Item = null

func _init(nm:String, upCost:int = 5):
	name = nm
	upgradeCost = upCost
	
func Obtain():
	amount += upgradedAmount

func Upgrade():
		upgradedAmount += 1
