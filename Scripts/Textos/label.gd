extends Label

@onready var asmnode = get_node("../../../Assembly")

func _process(_delta):
	text = str(asmnode.curinst) + ": " + str(asmnode.inst_list[asmnode.curinst])
