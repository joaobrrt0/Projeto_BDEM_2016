# script roteiro do BDAM - no repositório Treino_Extensao
# Antes de começar a fazer qualquer coisa:
# a) commit este roteiro com a mensagem "script roteiro BDAM" e envie para o repositório Treino_Extensao
# b) salve o script com outro nome (script_BDAM.R) e commit com a mensagem "script BDAM" e envie para o repositório Treino_Extensao

# Ao inserir os comandos em cada Tarefa de cada Etapa, mantenha as linhas de comentários e orientações colocadas pela professora


##### ETAPA 1 - banco 1 - equivalente ao SIM ######
##### Você deve criar e estar na branch banco-1 antes de inserir os comandos #####
##### NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho ###

# Tarefa 1: Leitura do banco de dados banco 1 = SIM.csv com o nome de dados_bd1
# Ler o arquivo, verificar estrutura dos dados e dar uma olhada nos dados

# Ao terminar a Tarefa 1 commit com a mensagem " script - tarefa 1" e envie para o repositório Treino_Extensao


# Tarefa 2: Manipulação dos dados
# Padronizar as categorias VEICULO_CAUSADOR para Carro e Moto e indicar que branco é NA
# Atribuir legendas para a variável SEXO_CONDUTOR_CAUSADOR, sendo 1: Masculino e 2: Feminino
# Criar uma nova variável em dados_bd1 F_IDADE categorizando as idades em: 22 a 34, 35 a 45

# Ao terminar a Tarefa 2 commit com a mensagem " script - tarefa 1 a 2" e envie para o repositório Treino_Extensao


# Tarefa 3: Criar o banco de dados BANCO1_RJ, POR MUNICÍPIO, com as seguintes variáveis listadas abaixo. 
# Variáveis que se referem a medidas de posição e de dispersão devem ser calculadas sem considerar NAs

# Atenção: a 1a linha do banco deve ser da UF 33
# ANO: 2025
# NIVEL: UF ou MUNICIPIO
# CODIGO: código do municipio (ou da UF)
# TV: total de veículos causadores de acidentes
# TC: total de carros causadores do acidente
# TM: total de motos causadoras do acidente
# TVCF: total de veículos causadores de acidentes com condutor mulher
# TVCM: total de veículos causadores de acidentes com condutor homem
# TC_22_34: total de condutores causadores de acidentes na faixa etária de 22 a 34 anos
# TC_35_45: total de condutores causadores de acidentes na faixa etária de 35 a 45 anos
# NMF: número médio de feridos
# DPF: desvio-padrão de feridos
# F_P25: percentil 25 do número de feridos
# F_P50: percentil 50 do número de feridos
# F_P75: percentil 75 do número de feridos
# TAFA: total de acidentes cuja causa foi falta de atenção
# TADS: total de acidentes cuja causa foi desrespeito à sinalização
# TADA: total de acidentes cuja causa foi o uso de drogas ou álcool
# TACO: total de acidentes cuja causa foi outros

# Ao terminar a Tarefa 3 commit com a mensagem " script - tarefa 1 a 3" e envie para o repositório Treino_Extensao


# Tarefa 4: Exportar o banco de dados BANCO1_RJ com o nome BANCO1_RJ.csv

# Ao terminar a Tarefa 4 commit com a mensagem "dados e script - Etapa 1"



##### ETAPA 2 - banco 2 - equivalente ao SINASC ######
##### Você deve criar e estar na branch banco-2 antes de inserir os comandos #####
##### NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho ###

# Tarefa 1: Leitura do banco de dados banco 2 = SINASC.csv com o nome de dados_bd2
# Ler o arquivo, verificar estrutura dos dados e dar uma olhada nos dados


# ---------------------------------------------------------------------------
# UF de trabalho: RIO DE JANEIRO (RJ) - código 33
# Definir a pasta de trabalho como sendo a pasta TREINO_EXTENSÃO do repositório local
# setwd("C:/Users/User/Desktop/Projeto_BDEM_2016/TREINO_EXTENSÃO")

# Leitura do banco de dados: o arquivo tem separador "," (por isso read.csv)
dados_bd2 = read.csv("banco 2 = SINASC - banco 2 = SINASC.csv")

# Verificando se a leitura foi feita corretamente
dim(dados_bd2)     # esperado: 50 linhas e 5 colunas
nrow(dados_bd2)    # 50
ncol(dados_bd2)    # 5

# Verificando a estrutura dos dados
str(dados_bd2)
names(dados_bd2)
# "MUNICIPIO" "SEXO_PROPRIETARIO" "IDADE_PROPRIETARIO" "TIPO_VEICULO" "VALOR_VEICULO"

# Dando uma olhada nos dados
head(dados_bd2)
summary(dados_bd2)

# Frequência das categorias das variáveis qualitativas, já procurando categorias estranhas
table(dados_bd2$MUNICIPIO, useNA = "ifany")           # 11 municípios do RJ (códigos 33xxxx)
table(dados_bd2$SEXO_PROPRIETARIO, useNA = "ifany")   # a mesma categoria aparece escrita de várias formas
# feminino 25, Feminino 1, FEMININO 1, masculino 21, Masculino 1, MASCULINO 1
table(dados_bd2$TIPO_VEICULO, useNA = "ifany")        # 1: 29 e 2: 21, ainda sem legenda

# Valores em branco (NA) nas variáveis quantitativas
sum(is.na(dados_bd2$IDADE_PROPRIETARIO))   # 1 comprador sem idade informada
sum(is.na(dados_bd2$VALOR_VEICULO))        # 1 veículo sem valor informado
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 1 commit com a mensagem " script - tarefa 1" e envie para o repositório Treino_Extensao


# Tarefa 2: Manipulação dos dados
# Padronizar as categorias SEXO_PROPRIETARIO para Masculino e Feminino
# Atribuir legendas para a variável TIPO_VEICULO, sendo 1: Carro e 2: Moto
# Criar uma nova variável em dados_bd2 F_IDADE categorizando as idades em: 22 a 34, 35 a 45


# ---------------------------------------------------------------------------
# --- SEXO_PROPRIETARIO: padronizar para Masculino e Feminino ---------------
# A variável foi digitada em caixas diferentes (feminino, Feminino, FEMININO, ...)
# tolower() uniformiza tudo em letras minúsculas e trimws() tira espaços em branco
sexo = tolower(trimws(dados_bd2$SEXO_PROPRIETARIO))
table(sexo, useNA = "ifany")   # agora só "feminino" (27) e "masculino" (23)

# Qualquer valor que não seja um dos dois vira NA
dados_bd2$SEXO_PROPRIETARIO = ifelse(sexo == "masculino", "Masculino",
                              ifelse(sexo == "feminino",  "Feminino", NA))

table(dados_bd2$SEXO_PROPRIETARIO, useNA = "ifany")   # Feminino: 27   Masculino: 23

# --- TIPO_VEICULO: 1 = Carro e 2 = Moto ------------------------------------
dados_bd2$TIPO_VEICULO = factor(dados_bd2$TIPO_VEICULO,
                                levels = c(1, 2),
                                labels = c("Carro", "Moto"))

table(dados_bd2$TIPO_VEICULO, useNA = "ifany")        # Carro: 29   Moto: 21

# --- F_IDADE: faixas etárias 22 a 34 e 35 a 45 -----------------------------
# right = FALSE faz os intervalos ficarem fechados à esquerda: [22, 35) e [35, 46)
# ou seja, 22 a 34 anos completos e 35 a 45 anos completos
dados_bd2$F_IDADE = cut(dados_bd2$IDADE_PROPRIETARIO,
                        breaks = c(22, 35, 46),
                        right  = FALSE,
                        labels = c("22 a 34", "35 a 45"))

table(dados_bd2$F_IDADE, useNA = "ifany")
# 22 a 34: 27   35 a 45: 22   NA: 1 (o comprador sem idade informada)

# Conferindo o banco depois das manipulações
str(dados_bd2)
head(dados_bd2)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 2 commit com a mensagem " script - tarefa 1 a 2" e envie para o repositório Treino_Extensao


# Tarefa 3: Leitura do banco de dados Tabela_PAM.csv (com o nome tabela_pam) e:
# agregar ao banco dados_bd2 as informações de VALOR_P10 e VALOR_P90
# criar a variável PAM (somente quando TIPO_VEICULO = "Carro"), de acordo com IDADE_PROPRIETARIO e SEXO_PROPRIETARIO, com as seguintes categorias:
# PAM = "PIC", se VALOR_VEICULO < VALOR_P10; "AIC", se VALOR_P10 <= VALOR_VEICULO <= VALOR_P90; "GIC", se VALOR_VEICULO > VALOR_P90


# ---------------------------------------------------------------------------
# Leitura da Tabela_PAM (arquivo também separado por ",")
tabela_pam = read.csv("Tabela_PAM - Tabela_PAM.csv")

# Verificando a leitura e a estrutura dos dados
dim(tabela_pam)    # 22 linhas e 4 colunas
str(tabela_pam)
head(tabela_pam)
# "IDADE_PROPRIETARIO" "SEXO_PROPRIETARIO" "VALOR_P10" "VALOR_P90"

# ATENÇÃO: a tabela só traz os percentis das idades de 25 a 35 anos
range(tabela_pam$IDADE_PROPRIETARIO)             # 25 e 35
table(tabela_pam$SEXO_PROPRIETARIO)              # Feminino: 11   Masculino: 11

# --- Agregando VALOR_P10 e VALOR_P90 a dados_bd2 ---------------------------
# O merge é feito pelo par (IDADE_PROPRIETARIO, SEXO_PROPRIETARIO)
# all.x = TRUE mantém todas as 50 linhas de dados_bd2, mesmo as que não têm
# correspondência na tabela (idades fora do intervalo de 25 a 35 anos)
# A variável ORDEM serve apenas para devolver as linhas à ordem original,
# porque o merge reordena o banco
dados_bd2$ORDEM = seq_len(nrow(dados_bd2))

dados_bd2 = merge(dados_bd2, tabela_pam,
                  by    = c("IDADE_PROPRIETARIO", "SEXO_PROPRIETARIO"),
                  all.x = TRUE)

dados_bd2 = dados_bd2[order(dados_bd2$ORDEM), ]
dados_bd2$ORDEM = NULL
row.names(dados_bd2) = NULL

# O merge também joga as colunas do "by" para a frente: devolvendo a ordem original
dados_bd2 = dados_bd2[, c("MUNICIPIO", "SEXO_PROPRIETARIO", "IDADE_PROPRIETARIO",
                          "TIPO_VEICULO", "VALOR_VEICULO", "F_IDADE",
                          "VALOR_P10", "VALOR_P90")]

nrow(dados_bd2)                    # continua com 50 linhas
sum(is.na(dados_bd2$VALOR_P10))    # 27 linhas sem percentis (idade fora de 25 a 35)

# --- Criando a variável PAM (somente para TIPO_VEICULO = "Carro") ----------
# O which() é usado para que os NA (de VALOR_VEICULO, de VALOR_P10 e de
# VALOR_P90) não gerem erro na atribuição por índice lógico
dados_bd2$PAM = NA

CARRO = dados_bd2$TIPO_VEICULO %in% "Carro"

dados_bd2$PAM[which(CARRO &
                    dados_bd2$VALOR_VEICULO < dados_bd2$VALOR_P10)] = "PIC"

dados_bd2$PAM[which(CARRO &
                    dados_bd2$VALOR_VEICULO >= dados_bd2$VALOR_P10 &
                    dados_bd2$VALOR_VEICULO <= dados_bd2$VALOR_P90)] = "AIC"

dados_bd2$PAM[which(CARRO &
                    dados_bd2$VALOR_VEICULO > dados_bd2$VALOR_P90)] = "GIC"

table(dados_bd2$PAM, useNA = "ifany")
# resultado: AIC: 9   GIC: 2   PIC: 3   NA: 36
# Fica NA quem comprou moto (21 compradores) e quem comprou carro mas está fora
# das idades de 25 a 35 anos cobertas pela Tabela_PAM, ou está sem idade / sem
# valor do veículo informado (15 compradores)

# Conferindo: PAM só foi preenchida para carros
table(dados_bd2$TIPO_VEICULO, dados_bd2$PAM, useNA = "ifany")

str(dados_bd2)
head(dados_bd2)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 3 commit com a mensagem " script - tarefa 1 a 3" e envie para o repositório Treino_Extensao

 
# Tarefa 4: Criar o banco de dados BANCO2_RJ, POR MUNICÍPIO, com as seguintes variáveis listadas abaixo. 
# Variáveis que se referem a medidas de posição e de dispersão devem ser calculadas sem considerar NAs

# Atenção: a 1a linha do banco deve ser da UF 33
# ANO: 2025
# NIVEL: UF ou MUNICIPIO
# CODIGO: código do municipio (ou da UF)
# TVV: total de veiculos vendidos
# TCV: total de carros vendidos
# TMV: total de motos vendidas
# TVVF: total de veículos vendidos para mulher
# TVVM: total de veículos vendidos para homem
# TVC_22_34: total de veiculos vendidos para pessoas na faixa etária de 22 a 34 anos
# TVC_35_45: total de veiculos vendidos para pessoas na faixa etária de 35 a 45 anos
# VMV: valor médio dos veículos vendidos
# DPV: desvio-padrão do valor dos veículos vendidos
# V_P25: percentil 25 do valor dos veículos vendidos
# V_P50: percentil 50 do valor dos veículos vendidos
# V_P75: percentil 75 do valor dos veículos vendidos
# TPIC: total de compradores com perfil PIC
# TAIC: total de compradores com perfil AIC
# TGIC: total de compradores com perfil GIC


# ---------------------------------------------------------------------------
# --- Indicadores de contagem, um por variável pedida acima -----------------
# Cada coluna é um vetor lógico: TRUE quando a linha entra na contagem
# O %in% é usado no lugar de == porque ele devolve FALSE (e não NA) nos NA
IND = data.frame(
  TVV       = rep(TRUE, nrow(dados_bd2)),                 # total de veículos vendidos
  TCV       = dados_bd2$TIPO_VEICULO      %in% "Carro",   # carros vendidos
  TMV       = dados_bd2$TIPO_VEICULO      %in% "Moto",    # motos vendidas
  TVVF      = dados_bd2$SEXO_PROPRIETARIO %in% "Feminino",   # vendidos para mulher
  TVVM      = dados_bd2$SEXO_PROPRIETARIO %in% "Masculino",  # vendidos para homem
  TVC_22_34 = dados_bd2$F_IDADE           %in% "22 a 34", # compradores de 22 a 34 anos
  TVC_35_45 = dados_bd2$F_IDADE           %in% "35 a 45", # compradores de 35 a 45 anos
  TPIC      = dados_bd2$PAM               %in% "PIC",     # perfil PIC
  TAIC      = dados_bd2$PAM               %in% "AIC",     # perfil AIC
  TGIC      = dados_bd2$PAM               %in% "GIC"      # perfil GIC
)

# --- Função das medidas de posição e de dispersão de VALOR_VEICULO ---------
# Todas com na.rm = TRUE, ou seja, calculadas sem considerar os NAs
medidas = function(x) {
  c(VMV   = mean(x, na.rm = TRUE),
    DPV   = sd(x, na.rm = TRUE),
    V_P25 = quantile(x, 0.25, na.rm = TRUE, names = FALSE),
    V_P50 = quantile(x, 0.50, na.rm = TRUE, names = FALSE),
    V_P75 = quantile(x, 0.75, na.rm = TRUE, names = FALSE))
}

# --- Municípios do RJ presentes no banco -----------------------------------
MUN  = sort(unique(dados_bd2$MUNICIPIO))
FMUN = factor(dados_bd2$MUNICIPIO, levels = MUN)
length(MUN)   # 11 municípios

# --- Contagens: 1a linha é a UF 33 (todo o estado) e depois os municípios ---
CONT = rbind(colSums(IND),
             sapply(IND, function(v) as.vector(tapply(v, FMUN, sum))))

# --- Medidas: 1a linha é a UF 33 e depois os municípios --------------------
MED = rbind(medidas(dados_bd2$VALOR_VEICULO),
            t(sapply(split(dados_bd2$VALOR_VEICULO, FMUN), medidas)))

# Valores em reais arredondados para 2 casas decimais
MED = round(MED, 2)

# --- Banco final, com a UF na 1a linha e na ordem de variáveis pedida ------
BANCO2_RJ = data.frame(
  ANO    = 2025,
  NIVEL  = c("UF", rep("MUNICIPIO", length(MUN))),
  CODIGO = c(33, MUN),
  CONT[, c("TVV", "TCV", "TMV", "TVVF", "TVVM", "TVC_22_34", "TVC_35_45")],
  MED[,  c("VMV", "DPV", "V_P25", "V_P50", "V_P75")],
  CONT[, c("TPIC", "TAIC", "TGIC")],
  row.names = NULL
)

# Conferindo o banco criado
dim(BANCO2_RJ)     # 12 linhas (1 UF + 11 municípios) e 18 colunas
names(BANCO2_RJ)   # a ordem deve ser a mesma da lista da Tarefa 4
str(BANCO2_RJ)
BANCO2_RJ

# Conferindo se a linha da UF é igual à soma das linhas dos municípios
BANCO2_RJ$TVV[1]  == sum(BANCO2_RJ$TVV[-1])    # deve ser TRUE
BANCO2_RJ$TPIC[1] == sum(BANCO2_RJ$TPIC[-1])   # deve ser TRUE

# Conferindo se os totais fecham entre si
BANCO2_RJ$TVV[1] == BANCO2_RJ$TCV[1]  + BANCO2_RJ$TMV[1]    # TRUE
BANCO2_RJ$TVV[1] == BANCO2_RJ$TVVF[1] + BANCO2_RJ$TVVM[1]   # TRUE

# OBSERVAÇÕES:
# 1. TVC_22_34 + TVC_35_45 dá 49 e não 50 porque um comprador está sem idade.
# 2. TPIC + TAIC + TGIC dá 14 e não 29 (o total de carros vendidos) porque a
#    Tabela_PAM só traz os percentis das idades de 25 a 35 anos: os demais
#    compradores de carro ficam sem perfil (PAM = NA) e não são contados.
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 4 commit com a mensagem " script - tarefa 1 a 4" e envie para o repositório Treino_Extensao


# Tarefa 5: Exportar o banco de dados BANCO2_RJ com o nome BANCO2_RJ.csv

# Ao terminar a Tarefa 5 commit com a mensagem "dados e script - Etapa 2" e envie para o repositório Treino_Extensao



##### ETAPA 3 - banco 3 - equivalente ao SIDRA ######
##### Você deve criar e estar na branch banco-3 antes de inserir os comandos #####
##### NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho ###

# Tarefa 1: Leitura do banco de dados banco 3 = SIDRA.csv com o nome de dados_bd3
# Ler o arquivo, verificar estrutura dos dados e dar uma olhada nos dados

# Ao terminar a Tarefa 1 commit com a mensagem " script - tarefa 1" e envie para o repositório Treino_Extensao


# Tarefa 2: Manipulação dos dados
# Criar a variável MUNICIPIOS = MUNICIPIO em dados_bd3, sendo que agora com 6 dígitos (em vez de 7 dígitos), desprezando o último dígito verificador

# Ao terminar a Tarefa 2 commit com a mensagem " script - tarefa 1 a 2" e envie para o repositório Treino_Extensao


# Tarefa 3: Criar o banco de dados BANCO3_RJ, POR MUNICÍPIO, com as seguintes variáveis listadas abaixo. 
# Atenção: a 1a linha do banco deve ser da UF 33
# ANO: 2025
# NIVEL: UF ou MUNICIPIO
# CODIGO: código do municipio (ou da UF)
# POPH: população total de habilitados
# POPHF: população total feminina de habilitadas
# POPHM: população total masculina de habilitadas

# Ao terminar a Tarefa 3 commit com a mensagem " script - tarefa 1 a 3" e envie para o repositório Treino_Extensao


# Tarefa 4: Exportar o banco de dados BANCO3_RJ com o nome BANCO3_RJ.csv

# Ao terminar a Tarefa 4 commit com a mensagem "dados e script - Etapa 3" e envie para o repositório Treino_Extensao


##### ETAPA 4 - banco 4 - equivalente ao ATLAS ######
##### Você deve criar e estar na branch banco-4 antes de inserir os comandos #####
##### NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho ###

# Tarefa 1: Leitura do banco de dados banco 4 = ATLAS.csv com o nome de dados_bd4 e do arquivo com tabela de códigos do IBGE
# códigos dos municípios - 2010.csv" com os códigos do IBGE para os municípios do Brasil
# Ler os arquivos, verificar estruturas dos dados e dar uma olhada nos dados

# Ao terminar a Tarefa 1 commit com a mensagem " script - tarefa 1" e envie para o repositório Treino_Extensao


# Tarefa 2: Manipulação dos dados
# Criar uma nova variável em dados_bd4 MUNICIPIOS atribuindo os códigos dos municípios, de forma a ficar
# coerente com os nomes dos municipios e códigos IBGE

# Ao terminar a Tarefa 2 commit com a mensagem " script - tarefa 1 a 2" e envie para o repositório Treino_Extensao


# Tarefa 3: Criar o banco de dados BANCO4_RJ, POR MUNICÍPIO, com as seguintes variáveis listadas abaixo. 
# Atenção: a 1a linha do banco deve ser da UF 33
# ANO: 2025
# NIVEL: UF ou MUNICIPIO
# CODIGO: código do municipio (ou da UF)
# QR_CA: qualidade da rodovia em 2020
# QRU: qualidade das rodovias urbanas
# QRR: qualidade das rodovias rurais


# Ao terminar a Tarefa 3 commit com a mensagem " script - tarefa 1 a 3" e envie para o repositório Treino_Extensao


# Tarefa 4: Exportar o banco de dados BANCO4_RJ com o nome BANCO4_RJ.csv

# Ao terminar a Tarefa 4 commit com a mensagem "dados e script - Etapa 4" e envie para o repositório Treino_Extensao



##### ETAPA 5 - banco 5 - equivalente ao SINISA ######
##### Você deve criar e estar na branch banco-5 antes de inserir os comandos #####
##### NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho ###

# Tarefa 1: Leitura do banco de dados banco 5 = SINISA.csv com o nome de dados_bd5 
# Ler os arquivos, verificar estruturas dos dados e dar uma olhada nos dados

# Ao terminar a Tarefa 1 commit com a mensagem " script - tarefa 1" e envie para o repositório Treino_Extensao


# Tarefa 2: Manipulação dos dados
# Observe que os números estão com ponto indicando milhar. Estes pontos devem ser extraídos para não confundir com decimal

# Ao terminar a Tarefa 2 commit com a mensagem " script - tarefa 1 a 2" e envie para o repositório Treino_Extensao


# Tarefa 3: Criar o banco de dados BANCO5_RJ, POR MUNICÍPIO, com as seguintes variáveis listadas abaixo. 
# Atenção: a 1a linha do banco deve ser da UF 33
# ANO: 2025
# NIVEL: UF ou MUNICIPIO
# CODIGO: código do municipio (ou da UF)
# NCR: número de carros registrados
# NMR: número de motos registradas

# Ao terminar a Tarefa 3 commit com a mensagem " script - tarefa 1 a 3" e envie para o repositório Treino_Extensao


# Tarefa 4: Exportar o banco de dados BANCO5_RJ com o nome BANCO5_RJ.csv

# Ao terminar a Tarefa 4 commit com a mensagem "dados e script - Etapa 5" e envie para o repositório Treino_Extensao



##### Merge para a branch main ######
##### Após terminar todas as 5 etapas acima você deve ir para a branch main e fazer merge de cada branch para o Git ajustar tudo


##### ETAPA 6 - criação do BDAM - equivalente ao BDEM ######
##### Você deve estar na branch main #####

# Tarefa 1: Concatenar (merge) os 5 arquivos gerados em cada uma das 5 etapas num único arquivo chamado BDAM_RJ, de modo que
# as variáveis fiquem dispostas da seguinte descrita abaixo

# Atenção: a 1a linha do banco deve ser da UF 33
# ANO: 2025
# NIVEL: UF ou MUNICIPIO
# CODIGO: código do municipio (ou da UF)
# POPH: população total de habilitados
# POPHF: população total feminina de habilitadas
# POPHM: população total masculina de habilitadas
# QR_CA: qualidade da rodovia em 2020
# QRU: qualidade das rodovias urbanas
# QRR: qualidade das rodovias rurais
# TVV: total de veiculos vendidos
# TCV: total de carros vendidos
# TMV: total de motos vendidas
# TVVF: total de veículos vendidos para mulher
# TVVM: total de veículos vendidos para homem
# TVC_22_34: total de veiculos vendidos para pessoas na faixa etária de 22 a 34 anos
# TVC_35_45: total de veiculos vendidos para pessoas na faixa etária de 35 a 45 anos
# VMV: valor médio dos veículos vendidos
# DPV: desvio-padrão do valor dos veículos vendidos
# V_P25: percentil 25 do valor dos veículos vendidos
# V_P50: percentil 50 do valor dos veículos vendidos
# V_P75: percentil 75 do valor dos veículos vendidos
# TV: total de veículos causadores de acidentes
# TC: total de carros causadores do acidente
# TM: total de motos causadoras do acidente
# TVCF: total de veículos causadores de acidentes com condutor mulher
# TVCM: total de veículos causadores de acidentes com condutor homem
# TC_22_34: total de condutores causadores de acidentes na faixa etária de 22 a 34 anos
# TC_35_45: total de condutores causadores de acidentes na faixa etária de 35 a 45 anos
# NMF: número médio de feridos
# DPF: desvio-padrão de feridos
# F_P25: percentil 25 do número de feridos
# F_P50: percentil 50 do número de feridos
# F_P75: percentil 75 do número de feridos
# TAFA: total de acidentes cuja causa foi falta de atenção
# TADS: total de acidentes cuja causa foi desrespeito à sinalização
# TADA: total de acidentes cuja causa foi o uso de drogas ou álcool
# TACO: total de acidentes cuja causa foi outros
# NCR: número de carros registrados
# NMR: número de motos registradas

# Ao terminar a Tarefa 1 commit com a mensagem " script - tarefa 1" e envie para o repositório Treino_Extensao


# Tarefa 2: Exportar o banco de dados BDAM_RJ com o nome BDAM_RJ.csv

# Ao terminar a Tarefa 2 commit com a mensagem "dados e script - Etapa 6" e envie para o repositório Treino_Extensao


