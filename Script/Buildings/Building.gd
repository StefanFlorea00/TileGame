extends Node

class_name Building
var id = 0
var money = 15
var owned = false
var selected = false
var residents = 30
onready var position = Vector2(0,0)

func _ready():
	pass # Replace with function body.
	
func getPosition():
	return position
	
func getMoney():
	return money
	
func setX(x):
	self.x = x

func setY(y):
	self.y = y
	
func setPosition(x,y):
	position = Vector2(x,y)

func isOwned():
	return owned

func setTexture(texturegive):
	self.texture = texturegive
	
func use():
	print("THIS IS BUILDING")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
