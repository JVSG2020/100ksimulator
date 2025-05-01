extends Panel

func array_create(sz, value):
	var arr = []
	for i in range(sz):
		arr.append(value)
	return arr

func _ready():
	# Criar uma variavel que usando o numero do endereço nós conseguimos algo dependendo de outra variavel
	var indexram = 0;
	# Lista de ids dos paineis
	var addrid = array_create(512,-1)
	# Criar um stylebox
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = Color("2a2c42")  # Cor de fundo
	stylebox.set_corner_radius_all(3)    # Cantos arredondados (3px)
	
	# Criar um loop para fazer os paineis com os labels
	while indexram < 512: 
		# Pegando o id do HflowContainer
		var container = get_node("VScrollContainerRam/HFlowContainerRam")
		# Criando o painel e colocando o id dele em uma parte o array
		var painel = Panel.new()
		
		# Criando o tema e aplicando o stylebox
		var t = Theme.new()
		t.set_stylebox("panel", "Panel", stylebox)
		painel.theme = t
		
		# Colocando o Painel no tamanho correto
		painel.custom_minimum_size = Vector2(150, 40)  # Ou o tamanho que tu quiser
		
		# Colocando o painel no array
		addrid[indexram] = painel
		# Colocando o nome correto
		painel.name = "Ram" + str(indexram)
		# Colocando o Painel no container
		container.add_child(painel)
		
		# Criando o Label
		var label = Label.new()
		label.text = "Ram " + str(indexram) + " : " + str(0)
		label.position = Vector2(18, 8)
		addrid[indexram].add_child(label)
		
		indexram += 1
