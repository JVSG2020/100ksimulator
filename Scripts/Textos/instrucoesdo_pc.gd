extends Label

@onready var asmnode = get_node("../../Assembly")

func _process(_delta):
	if asmnode.curinst >= 0:
		text = "Instrução do PC: " + str(asmnode.curinst)
