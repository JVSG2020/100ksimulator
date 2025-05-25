extends Button
@onready var asmnode = "../../Assembly"


func _ready():
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	SignalManeger.exec.emit()
