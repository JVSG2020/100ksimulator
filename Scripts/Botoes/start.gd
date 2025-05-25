extends Button

var change := true
@onready var asmnode = get_node("../../Assembly")

func _ready():
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	if change:
		asmnode.run = true
		text = "Stop"
	else:
		asmnode.run = false
		text = "Start"
	change = !change  # alterna true/false
