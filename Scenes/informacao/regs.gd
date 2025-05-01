extends Panel

func array_create(sz, value):
	var arr = []
	for i in range(sz):
		arr.append(value)
	return arr

func _ready():
	# Criar uma variavel que usando o numero do endereço nós conseguimos algo dependendo de outra variavel
	var indexreg = 0;
	# Lista de ids dos paineis
	var regid = array_create(32,-1)
	# Criar um stylebox
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = Color("2a2c42")  # Cor de fundo
	stylebox.set_corner_radius_all(3)    # Cantos arredondados (3px)
	
	# Criar um loop para fazer os paineis com os labels
	while indexreg < 32: 
		# Pegando o id do HflowContainer
		var container = get_node("VScrollBar/HFlowContainer")
		# Criando o painel e colocando o id dele em uma parte o array
		var painel = Panel.new()
		
		# Criando o tema e aplicando o stylebox
		var t = Theme.new()
		t.set_stylebox("panel", "Panel", stylebox)
		painel.theme = t
		
		# Colocando o Painel no tamanho correto
		painel.custom_minimum_size = Vector2(150, 40)  # Ou o tamanho que tu quiser
		
		# Colocando o painel no array
		regid[indexreg] = painel
		# Colocando o nome correto
		painel.name = "Ram" + str(indexreg)
		# Colocando o Painel no container
		container.add_child(painel)
		
		# Criando o Label
		var label = Label.new()
		label.text = "Reg " + str(indexreg) + " : " + str(0)
		label.position = Vector2(18, 8)
		regid[indexreg].add_child(label)
		indexreg += 1
