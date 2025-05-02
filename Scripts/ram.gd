extends Panel

# Criar uma variavel que usando o numero do endereço nós conseguimos algo dependendo de outra variavel
var indexram = 0;
# Quantidade de Registradores
var ramcount = 512;
# Lista de ids dos paineis
var ramid = array_create(ramcount,-1)
# Lista dos números armazendos
var ramlist = array_create(ramcount,0)
# Nos dize qual "cena" nós estamos
var curscene = "tela" # tela, info, arq

func array_create(sz, value):
	var arr = []
	for i in range(sz):
		arr.append(value)
	return arr

func _ready():
	# Criar um stylebox
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = Color("2a2c42")  # Cor de fundo
	stylebox.set_corner_radius_all(3)    # Cantos arredondados (3px)
	
	# Criar um loop para fazer os paineis com os labels
	while indexram < ramcount: 
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
		ramid[indexram] = painel
		# Colocando o nome correto
		painel.name = "Ram" + str(indexram)
		# Colocando o Painel no container
		container.add_child(painel)
		
		# Criando o Label
		var label = Label.new()
		label.text = "Ram " + str(indexram) + " : " + str(ramlist[indexram])
		label.position = Vector2(18, 8)
		ramid[indexram].add_child(label)
		indexram += 1

func _process(_delta):
	# Detectores de "Cena"
	SignalManeger.cam_tela.connect(func(): curscene = "tela") # Tela
	SignalManeger.cam_info.connect(func(): curscene = "info") # Informações
	SignalManeger.cam_arq.connect(func(): curscene = "arq") # Arquivos
	# Teste
	if Input.is_action_just_pressed("ui_down") and curscene == "info":
		ramload(0,get_address(0) + 5)
	

# Função para modificar uma Memória
func ramload(m,n):
	# Coloca na lista
	ramlist[m] = n
	# Coloca visualmente
	var label = ramid[m].get_child(0)
	label.text = "Ram " + str(m) + " : " + str(n)

# Função para retornar um registrador
func get_address(m: int):
	return ramlist[m]
