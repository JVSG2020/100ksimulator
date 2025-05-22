extends Control

var inst_list = create_list(2048,"nop")
var curinst = 0
var opcode = "nop"

func create_list(sz, value):
	var arr = []
	for i in range(sz):
		arr.append(value)
	return arr

func _ready():
	print("test")
	inst_list[0] = "ldi r1 5"
	inst_list[1] = "ldi r2 3"
	inst_list[2] = "add r1 r2 r3"

func _process(_delta):
	opcode = "ldi"
