extends Control

# Criar array
func create_list(sz, value):
	var arr = []
	for i in range(sz):
		arr.append(value)
	return arr

# Variáveis
var inst_list = create_list(2048,"nop")
var curinst = 0
var opcode = "nop"
var run = false
var charac = 5
var arrayinst = create_list(16,0)
var arraymem = create_list(512,0)
var timer := 0.0
var nexinst = 1
@onready var regnode = get_node("../UI-Informacoes/Regs")

# Recortar String
func string_cut(text: String, begin: int, length: int) -> String:
	if begin < 0 or begin >= text.length():
		return ""
	var end = min(begin + length, text.length())
	return text.substr(begin, end - begin)

# Caractere no índice da String
func string_char_at(text: String, index: int) -> String:
	if index < 0 or index >= text.length():
		return ""
	
	return text[index]

# Dividir String por espaços (Não os incluindo) em um Array
func string_split(text: String):
	var arr = []
	var box = ""
	
	for i in range(text.length()):
		if string_char_at(text,i) != " ":
			box += string_char_at(text,i)
		else:
			arr.append(box)
			box = ""
	arr.append(box)
	box = ""
	return arr

# Remove caracteres do parâmetro "remove" e retorna a String sem os caracteres correspondentes
func removechar(text: String, remove: String) -> String:
	var resultado := ""
	for i in range(text.length()):
		var c := text[i]
		if remove.find(c) == -1:
			resultado += c
	return resultado

func _ready():
	print("test")
	inst_list[0] = "ldi r1 5"
	inst_list[1] = "ldi r2 3"
	inst_list[2] = "add r1 r2 r3"
	inst_list[3] = "jmp 6"
	inst_list[4] = "sub r3 r1 r4"
	inst_list[5] = "jmp 8"
	inst_list[6] = "adi r3 4"
	inst_list[7] = "jmp 4"
	inst_list[8] = "hlt"
	
	SignalManeger.exec.connect(run_inst)

func _process(delta : float):
	
	
	# Conseguir o Opcode da instrução
	opcode = string_cut(inst_list[curinst],0,3)
	
	if run:
		# Conseguir o Rate
		var rate = $"../UI-Tela/RateSlider".value / 30
		
		timer += delta
		var interval = 1.0 / rate  # tempo entre execuções
		while timer >= interval:
			timer -= interval
			run_inst()

func run_inst():
	# Instrução Halt
	if opcode == "HLT" or opcode == "hlt":
		run = false
		nexinst = curinst+1
	
	# Instrução Add
	if opcode == "ADD" or opcode == "add":
		arrayinst = string_split(removechar(inst_list[curinst],"r"))
		arraymem = regnode.reglist
		regnode.loader = [arrayinst[3].to_int(),arraymem[arrayinst[1].to_int()] + arraymem[arrayinst[2].to_int()]]
		SignalManeger.loadreg.emit()
		nexinst = curinst+1
	
	# Instrução Subtract
	if opcode == "SUB" or opcode == "sub":
		arrayinst = string_split(removechar(inst_list[curinst],"r"))
		arraymem = regnode.reglist
		regnode.loader = [arrayinst[3].to_int(),arraymem[arrayinst[1].to_int()] - arraymem[arrayinst[2].to_int()]]
		SignalManeger.loadreg.emit()
		nexinst = curinst+1
	
	# Instrução Load Immediate
	if opcode == "LDI" or opcode == "ldi":
		arrayinst = string_split(removechar(inst_list[curinst],"r"))
		arraymem = regnode.reglist
		regnode.loader = [arrayinst[1].to_int(),arrayinst[2].to_int()]
		SignalManeger.loadreg.emit()
		nexinst = curinst+1
	
	# Instrução Add Immediate
	if opcode == "ADI" or opcode == "adi":
		arrayinst = string_split(removechar(inst_list[curinst],"r"))
		arraymem = regnode.reglist
		regnode.loader = [arrayinst[1].to_int(),arraymem[arrayinst[1].to_int()] + arrayinst[2].to_int()]
		SignalManeger.loadreg.emit()
		nexinst = curinst+1
	
	# Instrução Jump
	if opcode == "JMP" or opcode == "jmp":
		arrayinst = string_split(removechar(inst_list[curinst],"r"))
		nexinst = arrayinst[1].to_int()
	
	# Próxima instrução
	curinst = nexinst % 2048
