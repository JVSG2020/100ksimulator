extends Panel

# Criar uma variavel que usando o numero do endereço nós conseguimos algo dependendo de outra variavel
var indexreg = 0;
# Quantidade de Registradores
var regcount = 32;
# Lista de ids dos paineis
var regid = array_create(regcount,-1)
# Lista dos números armazendos
var reglist = array_create(regcount,0)
# Nos diz qual "cena" nós estamos
var curscene = "tela" # tela, info, arq
# Uma variável para configurar um valor de um registrador [Reg, Numb]
var loader = [0,0]

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
	while indexreg < regcount: 
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
		painel.name = "Reg" + str(indexreg)
		# Colocando o Painel no container
		container.add_child(painel)
		
		# Criando o Label
		var label = Label.new()
		label.text = "Reg " + str(indexreg) + " : " + str(reglist[indexreg])
		label.position = Vector2(18, 8)
		regid[indexreg].add_child(label)
		indexreg += 1
	
	if not SignalManeger.loadreg.is_connected(regdef):
		SignalManeger.loadreg.connect(regdef)

func _process(_delta):
	# Detectores de "Cena"
	SignalManeger.cam_tela.connect(func(): curscene = "tela") # Tela
	SignalManeger.cam_info.connect(func(): curscene = "info") # Informações
	SignalManeger.cam_arq.connect(func(): curscene = "arq") # Arquivos
	
	# Um teste
	if Input.is_action_just_pressed("ui_up") and curscene == "info":
		regload(1,get_register(1) + 3)
	# O registrador 0 é sempre 0, então :
	regload(0, 0)

# Função para modificar um registrador
func regload(r,n):
	# Coloca na lista
	reglist[r] = n
	# Coloca visualmente
	var label = regid[r].get_child(0)
	label.text = "Reg " + str(r) + " : " + str(n)

# Função para retornar um registrador
func get_register(r):
	return reglist[r]

func regdef():
	regload(loader[0],loader[1])
