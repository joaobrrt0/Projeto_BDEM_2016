# script roteiro do BDEM - no repositório Projeto_BDEM_2016
# Antes de começar a fazer qualquer coisa:
# a) Coloque todos os arquivos postados no Classroom (já descompactados) dentro do repositório local Projeto_BDEM_2016
# b) commit este roteiro com a mensagem "dados, arquivos de texto e script roteiro BDEM" e envie para o repositório Projeto_BDEM_2016
# c) salve o script com outro nome (script_BDEM.R) e commit com a mensagem "script BDEM" e envie para o repositório Projeto_BDEM_2016

# Ao inserir os comandos em cada Tarefa de cada Etapa, mantenha as linhas de comentários e orientações colocadas pela professora


##################################
# ETAPA 1: BANCO DE DADOS DO SIM
##################################
# Você deve criar e estar na branch SIM antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1. Leitura do banco de dados SIM_2016 com 1309774 linhas e 87 colunas com o nome de dados_sim
# Verificar se a leitura foi feita corretamente e a estrutura dos dados


# ---------------------------------------------------------------------------
# UF de trabalho: PERNAMBUCO (PE) - código 26
# Definir a pasta de trabalho como sendo o repositório local Projeto_BDEM_2016
# setwd("C:/Users/User/Desktop/Projeto_BDEM_2016")

# Leitura do banco de dados: o arquivo tem separador ";" (por isso read.csv2)
# A leitura demora alguns minutos porque o arquivo tem cerca de 440 MB
dados_sim = read.csv2("SIM_2016.csv")

# Verificando se a leitura foi feita corretamente
dim(dados_sim)     # esperado: 1309774 linhas e 87 colunas
nrow(dados_sim)    # 1309774
ncol(dados_sim)    # 87

# Verificando a estrutura dos dados
str(dados_sim)
names(dados_sim)
head(dados_sim)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SIM - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Reduzir dados_sim apenas para as colunas que serão utilizadas, nomeando este novo banco de dados como dados_sim_1
# As colunas serão: 1, 3, 9, 10, 11, 14, 17, 35, 47
# Nomes das respectivas variáveis: CONTADOR, TIPOBITO, IDADE, SEXO, RACACOR, ESC2010, CODMUNRES, TPMORTEOCO, CAUSABAS


# ---------------------------------------------------------------------------
# Seleção das colunas 1, 3, 9, 10, 11, 14, 17, 35, 47
dados_sim_1 = dados_sim[, c(1, 3, 9, 10, 11, 14, 17, 35, 47)]

# Conferindo se as colunas selecionadas são as variáveis pedidas
names(dados_sim_1)
# "CONTADOR" "TIPOBITO" "IDADE" "SEXO" "RACACOR" "ESC2010" "CODMUNRES" "TPMORTEOCO" "CAUSABAS"

dim(dados_sim_1)   # 1309774 linhas e 9 colunas
str(dados_sim_1)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SIM - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Reduzir dados_sim_1 apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sim_2
# Códigos das UF: 11: RO, 12: AC, 13: AM, 14: RR, 15: PA, 16: AP, 17: TO, 21: MA, 22: PI, 23: CE, 24: RN
# 25: PB, 26: PE, 27: AL, 28: SE, 29: BA, 31: MG, 32: ES, 33: RJ, 35: SP, 41: PR, 42: SC, 43: RS
# 50: MS, 51: MT, 52: GO, 53: DF

# observar abaixo o número de óbitos por UF de residência para certificar-se que seu banco de dados está correto
# 11:8344      12:3763     13:16799    14:2157      15:38557     16:2995     17:7490
# 21:34362     22:19187    23:54276    24:21922     25:28041     26:66928    27:20769    28:13516     29:88094
# 31:135257    32:22868    33:141089   35:296359
# 41:74740     42:40270    43:87583
# 50:16749     51:17535    52:38074    53:12050 


# ---------------------------------------------------------------------------
# A UF de trabalho é PERNAMBUCO, cujo código é 26
# CODMUNRES tem 6 dígitos e os dois primeiros identificam a UF de residência
# O which() é usado para que eventuais NA em CODMUNRES não gerem linhas vazias
dados_sim_2 = dados_sim_1[which(substr(dados_sim_1$CODMUNRES, 1, 2) == "26"), ]

# Conferindo com o número de óbitos de PE informado no roteiro
nrow(dados_sim_2)   # esperado: 66928 óbitos (26: PE)

# Conferindo que sobraram apenas municípios de PE
table(substr(dados_sim_2$CODMUNRES, 1, 2))   # 26: 66928

str(dados_sim_2)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SIM - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Verificar em dados_sim_2 a frequência das categorias das seguintes variáveis:
# TIPOBITO, SEXO, RACACOR, ESC2010, TPMORTEOCO, CAUSABAS
# Avalie também os valores das variável IDADE (não estranhe mas idade é composta de um dígito inicial que indica a unidade de medida)
# Unidades de medida a serem consideradas em IDADE: 0: minutos, 1: horas, 2: dias, 3: meses, 4: anos, 5: idade maior que 100 anos
# Atenção: a unidade de medida de IDADE no DICIONÀRIO do SIM está errada
# O propósito das avaliações acima é verificar se as categorias estão de acordo com o dicionário do SIM ou se aparecem categorias estranhas


# ---------------------------------------------------------------------------
# Frequência das categorias das variáveis qualitativas
table(dados_sim_2$TIPOBITO, useNA = "ifany")
# resultado: 2 (Não fetal): 66928 -> não há óbito fetal em PE em 2016

table(dados_sim_2$SEXO, useNA = "ifany")
# resultado: 0: 36    1: 37078    2: 29814
# o código 0 não é categoria válida de sexo: no dicionário 0 e 9 são "ignorado"

table(dados_sim_2$RACACOR, useNA = "ifany")
# resultado: 1: 21268   2: 3732   3: 147   4: 40293   5: 176   e 1312 em branco (NA)

table(dados_sim_2$ESC2010, useNA = "ifany")
# resultado: 0: 18060   1: 19948   2: 9228   3: 6603   4: 425   5: 2058   9: 6200
# e 4406 em branco (NA); o código 9 é "ignorado"

table(dados_sim_2$TPMORTEOCO, useNA = "ifany")
# resultado: 1: 41   2: 8   4: 50   5: 22   8: 2520   9: 544   e 63743 em branco (NA)
# o campo só é preenchido em caso de óbito de mulher em idade fértil
# o código 9 é "ignorado"

# CAUSABAS é o código da CID-10 da causa básica, portanto tem muitas categorias
length(table(dados_sim_2$CAUSABAS))                               # número de códigos diferentes
head(sort(table(dados_sim_2$CAUSABAS), decreasing = TRUE), 10)    # 10 causas mais frequentes
sum(dados_sim_2$CAUSABAS == "", na.rm = TRUE)                     # códigos em branco: 0

# Avaliação dos valores da variável IDADE
summary(dados_sim_2$IDADE)

# IDADE tem 3 dígitos: o primeiro é a unidade de medida e os dois últimos a quantidade
# Unidades: 0: minutos, 1: horas, 2: dias, 3: meses, 4: anos, 5: idade maior que 100 anos
# ATENÇÃO: a unidade de medida de IDADE no DICIONÁRIO do SIM está errada
# Como IDADE foi lida como número, a unidade é obtida pela divisão inteira por 100
table(dados_sim_2$IDADE %/% 100, useNA = "ifany")
# resultado: 0: 191   1: 283   2: 824   3: 523   4: 64298   5: 614   9: 195
# a unidade 9 não consta da lista acima: corresponde a idade ignorada (999)

# Quantidade de unidades (os dois últimos dígitos) dentro de cada unidade de medida
tapply(dados_sim_2$IDADE %% 100, dados_sim_2$IDADE %/% 100, range)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SIM - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5. Atribuir para cada variável de dados_sim_2 como sendo NA a categoria de "Não informado ou Ignorado", 
# geralmente com código 9
# Verifique o dicionário do SIM para identificar qual o código das categorias de cada variável
# Em variáveis quantitativas como IDADE verificar se existem valores como 9999 para NA


# ---------------------------------------------------------------------------
# TIPOBITO: 1-Fetal e 2-Não fetal; não possui categoria "ignorado"

# SEXO: pelo dicionário, I, 0 e 9 são "ignorado"
dados_sim_2$SEXO[dados_sim_2$SEXO %in% c(0, 9)] = NA

# RACACOR: 9 é "ignorado"
dados_sim_2$RACACOR[dados_sim_2$RACACOR %in% c(9)] = NA

# ESC2010: 9 é "ignorado"
dados_sim_2$ESC2010[dados_sim_2$ESC2010 %in% c(9)] = NA

# TPMORTEOCO: 9 é "ignorado"
dados_sim_2$TPMORTEOCO[dados_sim_2$TPMORTEOCO %in% c(9)] = NA

# IDADE: a unidade de medida 9 corresponde a idade ignorada (valores 9xx, como 999)
# o which() evita erro caso já existam NA em IDADE
dados_sim_2$IDADE[which(dados_sim_2$IDADE %/% 100 == 9)] = NA

# CAUSABAS: não tem código de "ignorado"; apenas os registros em branco viram NA
dados_sim_2$CAUSABAS[dados_sim_2$CAUSABAS %in% ""] = NA

# Conferindo o resultado da atribuição de NA
table(dados_sim_2$SEXO, useNA = "ifany")
table(dados_sim_2$RACACOR, useNA = "ifany")
table(dados_sim_2$ESC2010, useNA = "ifany")
table(dados_sim_2$TPMORTEOCO, useNA = "ifany")
table(dados_sim_2$IDADE %/% 100, useNA = "ifany")

# Total de NA em cada variável do banco
colSums(is.na(dados_sim_2))
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 5 commit com a mensagem "script BDEM - SIM - tarefas 1 a 5" e envie para o repositório Projeto_BDEM_2016


# Tarefa 6. Atribuir legendas para as categorias das variáveis qualitativas investigadas na tarefa 4.
# Exemplo: dados_sim_2$TIPOBITO = factor(dados_sim_2$TIPOBITO, levels = c(1,2), labels = c("Fetal", "Não fetal")

# ATENçÃO: 1. Na hora de escrever os labels, somente a PRIMEIRA LETRA da legenda é maiúscula. Exemplo para SEXO: Feminino e Masculino
#          2. Nesta Tarefa 6 não crie novas variáveis dentro do banco de dados


# ---------------------------------------------------------------------------
dados_sim_2$TIPOBITO = factor(dados_sim_2$TIPOBITO,
                              levels = c(1, 2),
                              labels = c("Fetal", "Não fetal"))

dados_sim_2$SEXO = factor(dados_sim_2$SEXO,
                          levels = c(1, 2),
                          labels = c("Masculino", "Feminino"))

dados_sim_2$RACACOR = factor(dados_sim_2$RACACOR,
                             levels = c(1, 2, 3, 4, 5),
                             labels = c("Branca", "Preta", "Amarela", "Parda", "Indígena"))

dados_sim_2$ESC2010 = factor(dados_sim_2$ESC2010,
                             levels = c(0, 1, 2, 3, 4, 5),
                             labels = c("Sem escolaridade", "Fundamental I", "Fundamental II",
                                        "Médio", "Superior incompleto", "Superior completo"))

dados_sim_2$TPMORTEOCO = factor(dados_sim_2$TPMORTEOCO,
                                levels = c(1, 2, 3, 4, 5, 8),
                                labels = c("Na gravidez", "No parto", "No abortamento",
                                           "Até 42 dias após o término do parto",
                                           "De 43 dias a 1 ano após o término da gestação",
                                           "Não ocorreu nestes períodos"))

# CAUSABAS não recebe legenda: ela já é o próprio código da CID-10 da causa básica
# IDADE também não recebe legenda porque é uma variável quantitativa

# Conferindo as legendas atribuídas
table(dados_sim_2$TIPOBITO, useNA = "ifany")
table(dados_sim_2$SEXO, useNA = "ifany")
table(dados_sim_2$RACACOR, useNA = "ifany")
table(dados_sim_2$ESC2010, useNA = "ifany")
table(dados_sim_2$TPMORTEOCO, useNA = "ifany")

str(dados_sim_2)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 6 commit com a mensagem "script BDEM - SIM - tarefas 1 a 6" e envie para o repositório Projeto_BDEM_2016


# Tarefa 7. Criar um banco de dados, de nome SIM_UF.csv (Exemplo: SIM_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 7 - SIM.pdf”
# Atenção: a ordem das variáveis do arquivo deve ser respeitada


# ---------------------------------------------------------------------------
# O banco tem 1 linha da UF (CODMUNRES = 26) seguida de 1 linha por município
# As variáveis auxiliares abaixo são criadas FORA de dados_sim_2

# --- Idade em dias e em anos -----------------------------------------------
# IDADE tem 3 dígitos: o 1o é a unidade de medida e os 2 últimos a quantidade
# 0: minutos, 1: horas, 2: dias, 3: meses, 4: anos, 5: idade maior que 100 anos
UNIDADE = dados_sim_2$IDADE %/% 100
QUANT   = dados_sim_2$IDADE %%  100

IDADE_DIAS = ifelse(UNIDADE == 0, 0,
             ifelse(UNIDADE == 1, 0,
             ifelse(UNIDADE == 2, QUANT,
             ifelse(UNIDADE == 3, QUANT * 30,
             ifelse(UNIDADE == 4, QUANT * 365,
             ifelse(UNIDADE == 5, (100 + QUANT) * 365, NA))))))

IDADE_ANOS = ifelse(UNIDADE %in% c(0, 1, 2, 3), 0,
             ifelse(UNIDADE == 4, QUANT,
             ifelse(UNIDADE == 5, 100 + QUANT, NA)))

# --- Capítulos da CID-10 a partir de CAUSABAS ------------------------------
CB_LETRA  = substr(dados_sim_2$CAUSABAS, 1, 1)
CB_NUMERO = as.numeric(substr(dados_sim_2$CAUSABAS, 2, 3))

EXTERNA = CB_LETRA %in% c("V", "W", "X", "Y")            # V01-Y98
NATURAL = !EXTERNA & !is.na(dados_sim_2$CAUSABAS)        # todas as demais

CAP_I = NATURAL & CB_LETRA %in% c("A", "B")              # A00-B99
CAP_N = NATURAL & (CB_LETRA %in% "C" |                   # C00-D48 e D50-D89
                   (CB_LETRA %in% "D" &
                    ((CB_NUMERO >= 0 & CB_NUMERO <= 48) |
                     (CB_NUMERO >= 50 & CB_NUMERO <= 89))))
CAP_C = NATURAL & CB_LETRA %in% "I"                      # I00-I99
CAP_R = NATURAL & CB_LETRA %in% "J"                      # J00-J99
CAP_O = NATURAL & !CAP_I & !CAP_N & !CAP_C & !CAP_R      # demais causas naturais

# --- Registros completos ---------------------------------------------------
# TORC precisa das 87 variáveis, então usa dados_sim (e não dados_sim_2)
dados_sim_87 = dados_sim[which(substr(dados_sim$CODMUNRES, 1, 2) == "26"), ]

# a ordem das linhas é a mesma de dados_sim_2, pois os dois vieram do mesmo filtro
identical(dados_sim_87$CONTADOR, dados_sim_2$CONTADOR)   # deve ser TRUE

# campos em branco também contam como "não informado"
for (v in names(dados_sim_87)) {
  dados_sim_87[[v]][dados_sim_87[[v]] %in% ""] = NA
}

COMPLETO_87 = complete.cases(dados_sim_87)
COMPLETO_9  = complete.cases(dados_sim_2)

sum(COMPLETO_87)   # resultado: 0 (ver observação no fim da Tarefa 7)
sum(COMPLETO_9)    # resultado: 2297

# --- Grupos usados em várias variáveis -------------------------------------
NEONATAL = !is.na(IDADE_DIAS) & IDADE_DIAS >= 0 & IDADE_DIAS <= 27
FERTIL   = !is.na(IDADE_ANOS) & IDADE_ANOS >= 15 & IDADE_ANOS <= 49

MATERNO_P = dados_sim_2$TPMORTEOCO %in% c("Na gravidez", "No parto",
                                          "No abortamento",
                                          "Até 42 dias após o término do parto")
MATERNO   = MATERNO_P |
            dados_sim_2$TPMORTEOCO %in% "De 43 dias a 1 ano após o término da gestação"

# --- Indicadores, um por variável do arquivo "Variáveis - Tarefa 7 - SIM" ---
IND = data.frame(
  TO           = rep(TRUE, nrow(dados_sim_2)),                  #  4 total de óbitos
  TORC         = COMPLETO_87,                                   #  5 completos nas 87 variáveis
  TORCR        = COMPLETO_9,                                    #  6 completos nas variáveis selecionadas
  TO_NN        = EXTERNA,                                       #  7 causas externas
  TO_N         = NATURAL,                                       #  8 causas naturais
  TO_CB_I      = CAP_I,                                         #  9 infecciosas e parasitárias
  TO_CB_N      = CAP_N,                                         # 10 neoplasias e doenças do sangue
  TO_CB_C      = CAP_C,                                         # 11 aparelho circulatório
  TO_CB_R      = CAP_R,                                         # 12 aparelho respiratório
  TO_CB_O      = CAP_O,                                         # 13 outras causas naturais
  TO_M         = dados_sim_2$SEXO %in% "Masculino",             # 14 óbitos masculinos
  TO_F         = dados_sim_2$SEXO %in% "Feminino",              # 15 óbitos femininos
  TO_F_IF      = dados_sim_2$SEXO %in% "Feminino" & FERTIL,     # 16 femininos em idade fértil
  TO_FT        = dados_sim_2$TIPOBITO %in% "Fetal",             # 17 óbitos fetais
  TO_NT        = NEONATAL,                                      # 18 neonatais (0 a 27 dias)
  TO_NT_P      = !is.na(IDADE_DIAS) & IDADE_DIAS <= 6,          # 19 neonatais precoces (0 a 6 dias)
  TO_NT_T      = !is.na(IDADE_DIAS) &
                 IDADE_DIAS >= 7 & IDADE_DIAS <= 27,            # 20 neonatais tardios (7 a 27 dias)
  TO_PNT       = !is.na(IDADE_DIAS) &
                 IDADE_DIAS >= 28 & IDADE_DIAS <= 364,          # 21 pós-neonatais (28 a 364 dias)
  TONT_B       = NEONATAL & dados_sim_2$RACACOR %in% "Branca",  # 22 neonatais brancos
  TONT_PT      = NEONATAL & dados_sim_2$RACACOR %in% "Preta",   # 23 neonatais pretos
  TONT_A       = NEONATAL & dados_sim_2$RACACOR %in% "Amarela", # 24 neonatais amarelos
  TONT_PD      = NEONATAL & dados_sim_2$RACACOR %in% "Parda",   # 25 neonatais pardos
  TONT_I       = NEONATAL & dados_sim_2$RACACOR %in% "Indígena",# 26 neonatais indígenas
  TO_MT        = MATERNO,                                       # 27 maternos (precoces e tardios)
  TO_MT_DG     = dados_sim_2$TPMORTEOCO %in% "Na gravidez",     # 28 maternos na gestação
  TO_MT_PT     = dados_sim_2$TPMORTEOCO %in% "No parto",        # 29 maternos no parto
  TO_MT_AB     = dados_sim_2$TPMORTEOCO %in% "No abortamento",  # 30 maternos no abortamento
  TO_MT_42     = dados_sim_2$TPMORTEOCO %in%
                 "Até 42 dias após o término do parto",         # 31 maternos até 42 dias
  TO_MT_43     = dados_sim_2$TPMORTEOCO %in%
                 "De 43 dias a 1 ano após o término da gestação",# 32 maternos tardios
  TO_MT_P      = MATERNO_P,                                     # 33 maternos precoces
  TO_MT_P_I    = MATERNO_P & FERTIL,                            # 34 maternos precoces em idade fértil
  TO_MT_P_ES   = MATERNO_P & dados_sim_2$ESC2010 %in%
                 "Sem escolaridade",                            # 35 maternos precoces sem escolaridade
  TO_MT_P_EFI  = MATERNO_P & dados_sim_2$ESC2010 %in%
                 "Fundamental I",                               # 36 maternos precoces fundamental I
  TO_MT_P_EFII = MATERNO_P & dados_sim_2$ESC2010 %in%
                 "Fundamental II",                              # 37 maternos precoces fundamental II
  TO_MT_P_EM   = MATERNO_P & dados_sim_2$ESC2010 %in% "Médio",  # 38 maternos precoces médio
  TO_MT_P_ESI  = MATERNO_P & dados_sim_2$ESC2010 %in%
                 "Superior incompleto",                         # 39 maternos precoces superior incompleto
  TO_MT_P_ESC  = MATERNO_P & dados_sim_2$ESC2010 %in%
                 "Superior completo"                            # 40 maternos precoces superior completo
)

# --- Linha da UF (CODMUNRES = 26) ------------------------------------------
linha_uf = data.frame(ANO = 2016, NIVEL = "UF", CODMUNRES = 26,
                      t(colSums(IND)))

# --- Linhas dos municípios --------------------------------------------------
MUN  = sort(unique(dados_sim_2$CODMUNRES))
FMUN = factor(dados_sim_2$CODMUNRES, levels = MUN)

linhas_municipio = data.frame(ANO = 2016, NIVEL = "MUNICIPIO", CODMUNRES = MUN)
for (v in names(IND)) {
  linhas_municipio[[v]] = as.vector(tapply(IND[[v]], FMUN, sum))
}

# --- Banco final, com a UF na 1a linha --------------------------------------
SIM_PE = rbind(linha_uf, linhas_municipio)

# Conferindo o banco criado
dim(SIM_PE)      # 187 linhas (1 UF + 186 municípios) e 40 colunas
names(SIM_PE)    # a ordem deve ser a mesma do arquivo da Tarefa 7
str(SIM_PE)
head(SIM_PE[, 1:8])

# Conferindo se a linha da UF é igual à soma dos municípios
SIM_PE$TO[1] == sum(SIM_PE$TO[-1])    # deve ser TRUE

# Resultados obtidos para a linha da UF (26 - PE):
# TO 66928        TORC 0            TORCR 2297        TO_NN 9114
# TO_N 57814      TO_CB_I 3377      TO_CB_N 9086      TO_CB_C 18765
# TO_CB_R 8525    TO_CB_O 18061     TO_M 37078        TO_F 29814
# TO_F_IF 3316    TO_FT 0           TO_NT 1279        TO_NT_P 967
# TO_NT_T 312     TO_PNT 542        TONT_B 217        TONT_PT 14
# TONT_A 1        TONT_PD 941       TONT_I 10         TO_MT 121
# TO_MT_DG 41     TO_MT_PT 8        TO_MT_AB 0        TO_MT_42 50
# TO_MT_43 22     TO_MT_P 99        TO_MT_P_I 83      TO_MT_P_ES 3
# TO_MT_P_EFI 15  TO_MT_P_EFII 37   TO_MT_P_EM 24     TO_MT_P_ESI 1
# TO_MT_P_ESC 1

# OBSERVAÇÕES:
# 1. TORC dá 0 em todos os municípios. Não é erro do script: 6 das 87 variáveis
#    do SIM (ESTABDESCR, CB_PRE, NUDIASOBIN, NUDIASINF, DTCONCASO e FONTESINF)
#    estão vazias em TODOS os registros do arquivo, logo nenhum óbito pode ter
#    registro completo nas 87 variáveis.
# 2. O arquivo da Tarefa 7 fala em "14 variáveis selecionadas do SIM" para o
#    TORCR, mas a Tarefa 2 do roteiro seleciona 9 colunas. Aqui foram usadas as
#    9 variáveis de dados_sim_2.
# 3. PE tem 185 municípios, mas aparecem 186 códigos: o código 260000
#    ("município ignorado") tem 301 óbitos e foi mantido para que a soma dos
#    municípios continue batendo com o total da UF.
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 7 commit com a mensagem "script BDEM - SIM - tarefas 1 a 7" e envie para o repositório Projeto_BDEM_2016


# Tarefa 8. Exportar o banco de dados com o nome SIM_UF.csv (Exemplo: SIM_RJ.csv)

# ---------------------------------------------------------------------------
# Exportação usando ";" como separador, igual aos arquivos lidos com read.csv2
write.csv2(SIM_PE, "SIM_PE.csv", row.names = FALSE)

# Conferindo o arquivo exportado
file.exists("SIM_PE.csv")
confere = read.csv2("SIM_PE.csv")
dim(confere)        # 187 linhas e 40 colunas
head(confere[, 1:8])
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 8 fazer um commit com o comentário "dados SIM_UF 2016 e script - SIM - tarefas 1 a 8"  e envie para o repositório Projeto_BDEM_2016



####################################
# ETAPA 2: BANCO DE DADOS DO SINASC
####################################
# Você deve criar e estar na branch SINASC antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1. Leitura do banco de dados SINASC_2016 com 2857800 linhas e 61 colunas com o nome de dados_sinasc
# Verificar se a leitura foi feita corretamente e a estrutura dos dados
# Por uma questão de padronização coloque todos os nomes das variáveis em letra maiúscula,
# usando o comando names(dados_sinasc) = toupper(names(dados_sinasc))


# ---------------------------------------------------------------------------
# UF de trabalho: PERNAMBUCO (PE) - código 26
# Leitura do banco de dados: o arquivo tem separador ";" (por isso read.csv2)
# A leitura demora alguns minutos porque o arquivo tem cerca de 635 MB
dados_sinasc = read.csv2("SINASC_2016.csv")

# Padronização: todos os nomes das variáveis em letra maiúscula
names(dados_sinasc) = toupper(names(dados_sinasc))

# Verificando se a leitura foi feita corretamente
dim(dados_sinasc)     # esperado: 2857800 linhas e 61 colunas
nrow(dados_sinasc)    # 2857800
ncol(dados_sinasc)    # 61

# Verificando a estrutura dos dados
str(dados_sinasc)
names(dados_sinasc)
head(dados_sinasc)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SINASC - tarefa 1" e envie para o repositório Projeto_BDEM_2016

# Tarefa 2. Reduzir dados_sinasc apenas para as colunas que serão utilizadas, nomeando este novo banco de dados como dados_sinasc_1
# As colunas serão 3, 4, 5, 6, 11, 12, 13, 14, 18, 20, 21, 22, 23, 34, 37, 43, 47, 58, 59, 60, 61
# Nomes das respectivas variáveis: CODMUNNASC, LOCNASC, IDADEMAE, ESTCIVMAE, CODMUNRES, GESTACAO, GRAVIDEZ, PARTO, 
# SEXO, APGAR5, RACACOR, PESO, IDANOMAL, ESCMAE2010, RACACORMAE, SEMAGESTAC, TPAPRESENT, TPROBSON, PARIDADE, KOTELCHUCK, CONTADOR


# ---------------------------------------------------------------------------
# Seleção das colunas 3, 4, 5, 6, 11, 12, 13, 14, 18, 20, 21, 22, 23, 34, 37,
# 43, 47, 58, 59, 60 e 61
dados_sinasc_1 = dados_sinasc[, c(3, 4, 5, 6, 11, 12, 13, 14, 18, 20, 21, 22,
                                  23, 34, 37, 43, 47, 58, 59, 60, 61)]

# Conferindo se as colunas selecionadas são as variáveis pedidas
names(dados_sinasc_1)
# "CODMUNNASC" "LOCNASC" "IDADEMAE" "ESTCIVMAE" "CODMUNRES" "GESTACAO"
# "GRAVIDEZ" "PARTO" "SEXO" "APGAR5" "RACACOR" "PESO" "IDANOMAL" "ESCMAE2010"
# "RACACORMAE" "SEMAGESTAC" "TPAPRESENT" "TPROBSON" "PARIDADE" "KOTELCHUCK"
# "CONTADOR"

dim(dados_sinasc_1)   # 2857800 linhas e 21 colunas
str(dados_sinasc_1)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Reduzir dados_sinasc_1 apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sinasc_2
# Códigos das UF: 11: RO, 12: AC, 13: AM, 14: RR, 15: PA, 16: AP, 17: TO, 21: MA, 22: PI, 23: CE, 24: RN
# 25: PB, 26: PE, 27: AL, 28: SE, 29: BA, 31: MG, 32: ES, 33: RJ, 35: SP, 41: PR, 42: SC, 43: RS
# 50: MS, 51: MT, 52: GO, 53: DF 

# observar abaixo o número de nascimentos por UF de residência para certificar-se que seu banco de dados está correto
# 11: 26602     12: 15773     13: 76703     14: 11376     15: 137681    16: 15521      17: 23870
# 21: 110493    22: 46986     23: 126246    24: 45366     25: 56083     26: 130733     27: 48164     28: 32218     29: 199830
# 31: 253520    32: 53413     33: 219129    35: 601437     
# 41: 155066    42: 95313     43: 141411
# 50: 42432     51: 53531     52: 95563     53: 43340 


# ---------------------------------------------------------------------------
# A UF de trabalho é PERNAMBUCO, cujo código é 26
# CODMUNRES tem 6 dígitos e os dois primeiros identificam a UF de residência
# O which() é usado para que eventuais NA em CODMUNRES não gerem linhas vazias
dados_sinasc_2 = dados_sinasc_1[which(substr(dados_sinasc_1$CODMUNRES, 1, 2) == "26"), ]

# Conferindo com o número de nascimentos de PE informado no roteiro
nrow(dados_sinasc_2)   # esperado: 130733 nascimentos (26: PE)

# Conferindo que sobraram apenas municípios de PE
table(substr(dados_sinasc_2$CODMUNRES, 1, 2))   # 26: 130733

str(dados_sinasc_2)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Verificar em dados_sinasc_2 a frequência das categorias das seguintes variáveis: LOCNASC, ESTCIVMAE, GESTACAO, GRAVIDEZ, PARTO,
# SEXO, RACACOR, IDANOMAL, ESCMAE2010, RACACORMAE, TPAPRESENT, TPROBSON, PARIDADE, KOTELCHUCK
# Avalie também os valores das variáveis quantitativas de IDADEMAE, SEMAGESTAC, APGAR5 e PESO


# ---------------------------------------------------------------------------
# Frequência das categorias das variáveis qualitativas
table(dados_sinasc_2$LOCNASC, useNA = "ifany")
# resultado: 1: 129893   2: 272   3: 376   4: 189   9: 3
# a categoria 5 (aldeia indígena) não aparece em PE; o código 9 é "ignorado"

table(dados_sinasc_2$ESTCIVMAE, useNA = "ifany")
# resultado: 1: 55842   2: 37114   3: 313   4: 1118   5: 35276   9: 317
# e 753 em branco (NA)

table(dados_sinasc_2$GESTACAO, useNA = "ifany")
# resultado: 1: 81   2: 660   3: 1336   4: 12812   5: 108319   6: 4691   9: 7
# e 2827 em branco (NA)

table(dados_sinasc_2$GRAVIDEZ, useNA = "ifany")
# resultado: 1: 128209   2: 2291   3: 57   9: 1   e 175 em branco (NA)

table(dados_sinasc_2$PARTO, useNA = "ifany")
# resultado: 1: 64911   2: 65679   9: 2   e 141 em branco (NA)

table(dados_sinasc_2$SEXO, useNA = "ifany")
# resultado: 0: 25   1: 66785   2: 63923
# o código 0 não é categoria válida de sexo: no dicionário 0 é "ignorado"

table(dados_sinasc_2$RACACOR, useNA = "ifany")
# resultado: 1: 23971   2: 5330   3: 349   4: 98445   5: 953
# e 1685 em branco (NA); não aparece o código 9

table(dados_sinasc_2$IDANOMAL, useNA = "ifany")
# resultado: 1: 1517   2: 128679   9: 220   e 317 em branco (NA)

table(dados_sinasc_2$ESCMAE2010, useNA = "ifany")
# resultado: 0: 1011   1: 10834   2: 38830   3: 60984   4: 5407   5: 12237
# 9: 497   e 933 em branco (NA)

table(dados_sinasc_2$RACACORMAE, useNA = "ifany")
# resultado: 1: 23945   2: 5329   3: 349   4: 98292   5: 952
# e 1866 em branco (NA)

table(dados_sinasc_2$TPAPRESENT, useNA = "ifany")
# resultado: 1: 124977   2: 4800   3: 243   9: 175   e 538 em branco (NA)

table(dados_sinasc_2$TPROBSON, useNA = "ifany")
# resultado: 1: 30417   2: 13366   3: 31614   4: 7989   5: 24649   6: 1755
# 7: 2380   8: 2303   9: 243   10: 12616   11: 3401
# atenção: aqui o 9 é o grupo 9 de Robson, e não "ignorado"
# quem indica falta de informação é o código 11

table(dados_sinasc_2$PARIDADE, useNA = "ifany")
# resultado: 0: 52578   1: 78155   (0: nulípara, 1: multípara)

table(dados_sinasc_2$KOTELCHUCK, useNA = "ifany")
# resultado: 1: 717   2: 31530   3: 9935   4: 11387   5: 71218   9: 5946
# o código 9 é "não informado"

# Avaliação dos valores das variáveis quantitativas
summary(dados_sinasc_2$IDADEMAE)
# resultado: mínimo 12 e máximo 60 anos, sem valores em branco
# não existem valores como 99 ou 9999 para NA

summary(dados_sinasc_2$SEMAGESTAC)
# resultado: mínimo 19 e máximo 45 semanas, com 2839 NA
# não existem valores como 99 ou 9999 para NA

summary(dados_sinasc_2$APGAR5)
# resultado: mínimo 0 e máximo 99, com 910 NA
# o Apgar vai de 0 a 10, então o valor 99 (8 registros) é "ignorado"
table(dados_sinasc_2$APGAR5, useNA = "ifany")

summary(dados_sinasc_2$PESO)
# resultado: mínimo 100 e máximo 6665 gramas, com 14 NA
# não existem valores como 9999 para NA
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5. Atribuir para cada variável de dados_sinasc_2 como sendo NA a categoria de "Não informado ou Ignorado", 
# geralmente com código 9
# Verifique o dicionário do SINASC para identificar qual o código das categorias de cada variável
# KOTELCHUCK = 9 significa "Não informado"   TPROBSON = 11 significa "Não classificado por falta de informação"
# Em variáveis quantitativas como IDADEMAE verificar se existem valores como 9999 para NA


# ---------------------------------------------------------------------------
# Variáveis em que o código 9 significa "Não informado ou Ignorado"
dados_sinasc_2$LOCNASC[dados_sinasc_2$LOCNASC %in% c(9)]       = NA
dados_sinasc_2$ESTCIVMAE[dados_sinasc_2$ESTCIVMAE %in% c(9)]   = NA
dados_sinasc_2$GESTACAO[dados_sinasc_2$GESTACAO %in% c(9)]     = NA
dados_sinasc_2$GRAVIDEZ[dados_sinasc_2$GRAVIDEZ %in% c(9)]     = NA
dados_sinasc_2$PARTO[dados_sinasc_2$PARTO %in% c(9)]           = NA
dados_sinasc_2$RACACOR[dados_sinasc_2$RACACOR %in% c(9)]       = NA
dados_sinasc_2$IDANOMAL[dados_sinasc_2$IDANOMAL %in% c(9)]     = NA
dados_sinasc_2$ESCMAE2010[dados_sinasc_2$ESCMAE2010 %in% c(9)] = NA
dados_sinasc_2$RACACORMAE[dados_sinasc_2$RACACORMAE %in% c(9)] = NA
dados_sinasc_2$TPAPRESENT[dados_sinasc_2$TPAPRESENT %in% c(9)] = NA
dados_sinasc_2$KOTELCHUCK[dados_sinasc_2$KOTELCHUCK %in% c(9)] = NA

# SEXO: pelo dicionário, I, 0 e 9 são "ignorado"
dados_sinasc_2$SEXO[dados_sinasc_2$SEXO %in% c(0, 9)] = NA

# TPROBSON: 11 significa "Não classificado por falta de informação"
# aqui o 9 NÃO é ignorado: é o grupo 9 de Robson
dados_sinasc_2$TPROBSON[dados_sinasc_2$TPROBSON %in% c(11)] = NA

# PARIDADE: 0 (nulípara) e 1 (multípara) são as únicas categorias válidas
# em PE não aparece o código 9, mas a linha fica para o caso de aparecer
dados_sinasc_2$PARIDADE[dados_sinasc_2$PARIDADE %in% c(9)] = NA

# APGAR5: o índice vai de 0 a 10, logo 99 é "ignorado"
dados_sinasc_2$APGAR5[dados_sinasc_2$APGAR5 %in% c(99)] = NA

# IDADEMAE, SEMAGESTAC e PESO: foram conferidos na Tarefa 4 e não têm
# valores como 99 ou 9999 indicando NA, então nada é alterado

# Conferindo o resultado da atribuição de NA
table(dados_sinasc_2$LOCNASC, useNA = "ifany")
table(dados_sinasc_2$SEXO, useNA = "ifany")
table(dados_sinasc_2$TPROBSON, useNA = "ifany")
table(dados_sinasc_2$KOTELCHUCK, useNA = "ifany")
summary(dados_sinasc_2$APGAR5)   # agora o máximo passa a ser 10

# Total de NA em cada variável do banco
colSums(is.na(dados_sinasc_2))
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 5 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 5" e envie para o repositório Projeto_BDEM_2016


# Tarefa 6. Atribuir legendas para as categorias das variáveis qualitativas investigadas na tarefa 4.
# Exemplo: dados_sinasc_2$KOTELCHUCK = factor(dados_sinasc_2$KOTELCHUCK, levels = c(1,2,3,4,5), 
# labels = c("Não realizou pré-natal", "Inadequado", "Intermediário", "Adequado",  
# "Mais que adequado")

# ATENçÃO: 1. Na hora de escrever os labels, somente a primeira letra da legenda é maiúscula. Exemplo para SEXO: Feminino e Masculino
#          2. Nesta Tarefa 6 não crie novas variáveis dentro do banco de dados


# ---------------------------------------------------------------------------
dados_sinasc_2$LOCNASC = factor(dados_sinasc_2$LOCNASC,
                                levels = c(1, 2, 3, 4, 5),
                                labels = c("Hospital",
                                           "Outros estabelecimentos de saúde",
                                           "Domicílio", "Outros",
                                           "Aldeia indígena"))

dados_sinasc_2$ESTCIVMAE = factor(dados_sinasc_2$ESTCIVMAE,
                                  levels = c(1, 2, 3, 4, 5),
                                  labels = c("Solteira", "Casada", "Viúva",
                                             "Separada judicialmente/divorciada",
                                             "União estável"))

dados_sinasc_2$GESTACAO = factor(dados_sinasc_2$GESTACAO,
                                 levels = c(1, 2, 3, 4, 5, 6),
                                 labels = c("Menos de 22 semanas",
                                            "22 a 27 semanas",
                                            "28 a 31 semanas",
                                            "32 a 36 semanas",
                                            "37 a 41 semanas",
                                            "42 semanas e mais"))

dados_sinasc_2$GRAVIDEZ = factor(dados_sinasc_2$GRAVIDEZ,
                                 levels = c(1, 2, 3),
                                 labels = c("Única", "Dupla", "Tripla ou mais"))

dados_sinasc_2$PARTO = factor(dados_sinasc_2$PARTO,
                              levels = c(1, 2),
                              labels = c("Vaginal", "Cesário"))

dados_sinasc_2$SEXO = factor(dados_sinasc_2$SEXO,
                             levels = c(1, 2),
                             labels = c("Masculino", "Feminino"))

dados_sinasc_2$RACACOR = factor(dados_sinasc_2$RACACOR,
                                levels = c(1, 2, 3, 4, 5),
                                labels = c("Branca", "Preta", "Amarela",
                                           "Parda", "Indígena"))

dados_sinasc_2$IDANOMAL = factor(dados_sinasc_2$IDANOMAL,
                                 levels = c(1, 2),
                                 labels = c("Sim", "Não"))

dados_sinasc_2$ESCMAE2010 = factor(dados_sinasc_2$ESCMAE2010,
                                   levels = c(0, 1, 2, 3, 4, 5),
                                   labels = c("Sem escolaridade",
                                              "Fundamental I", "Fundamental II",
                                              "Médio", "Superior incompleto",
                                              "Superior completo"))

dados_sinasc_2$RACACORMAE = factor(dados_sinasc_2$RACACORMAE,
                                   levels = c(1, 2, 3, 4, 5),
                                   labels = c("Branca", "Preta", "Amarela",
                                              "Parda", "Indígena"))

dados_sinasc_2$TPAPRESENT = factor(dados_sinasc_2$TPAPRESENT,
                                   levels = c(1, 2, 3),
                                   labels = c("Cefálico", "Pélvica ou podálica",
                                              "Transversa"))

dados_sinasc_2$TPROBSON = factor(dados_sinasc_2$TPROBSON,
                                 levels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
                                 labels = c("Grupo 1", "Grupo 2", "Grupo 3",
                                            "Grupo 4", "Grupo 5", "Grupo 6",
                                            "Grupo 7", "Grupo 8", "Grupo 9",
                                            "Grupo 10"))

dados_sinasc_2$PARIDADE = factor(dados_sinasc_2$PARIDADE,
                                 levels = c(0, 1),
                                 labels = c("Nulípara", "Multípara"))

dados_sinasc_2$KOTELCHUCK = factor(dados_sinasc_2$KOTELCHUCK,
                                   levels = c(1, 2, 3, 4, 5),
                                   labels = c("Não realizou pré-natal",
                                              "Inadequado", "Intermediário",
                                              "Adequado", "Mais que adequado"))

# IDADEMAE, APGAR5, PESO e SEMAGESTAC não recebem legenda: são quantitativas
# CODMUNNASC, CODMUNRES e CONTADOR também não: são códigos identificadores

# Conferindo as legendas atribuídas
table(dados_sinasc_2$LOCNASC, useNA = "ifany")
table(dados_sinasc_2$ESTCIVMAE, useNA = "ifany")
table(dados_sinasc_2$GESTACAO, useNA = "ifany")
table(dados_sinasc_2$GRAVIDEZ, useNA = "ifany")
table(dados_sinasc_2$PARTO, useNA = "ifany")
table(dados_sinasc_2$SEXO, useNA = "ifany")
table(dados_sinasc_2$RACACOR, useNA = "ifany")
table(dados_sinasc_2$IDANOMAL, useNA = "ifany")
table(dados_sinasc_2$ESCMAE2010, useNA = "ifany")
table(dados_sinasc_2$RACACORMAE, useNA = "ifany")
table(dados_sinasc_2$TPAPRESENT, useNA = "ifany")
table(dados_sinasc_2$TPROBSON, useNA = "ifany")
table(dados_sinasc_2$PARIDADE, useNA = "ifany")
table(dados_sinasc_2$KOTELCHUCK, useNA = "ifany")

str(dados_sinasc_2)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 6 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 6" e envie para o repositório Projeto_BDEM_2016


# Tarefa 7. Categorizar as variáveis IDADEMAE, PESO e APGAR5 e criar variáveis referentes ao deslocamento materno (peregrinação) e estado civil
# nova variável: dados_sinasc_2$F_PESO com PESO: < 2500: Baixo peso, >=2500 e < 4000: Peso normal, >= 4000: Macrossomia
# nova variável dados_sinasc_2$F_IDADE com IDADEMAE: <15, 15-19, 20-24, 25-29, 30-34, 35-39, 40-44, 45-49, 50+
# nova variável dados_sinasc_2$F_APGAR5 com APGAR5: < 7: Baixo, >= 7: Normal
# Atenção para casos de NA em IDADEMAE, PESO e APGAR5
# nova variável: dados_sinasc_2$PEREG: Não: CODMUNNASC igual a CODMUNRES, Sim: CODMUNNASC diferente de CODMUNRES
# nova variável: dados_sinasc_2$ESTCIV: Sem companheiro: ESTCIVMAE 1, 3 ou 4, Com companheiro: ESTCIVMAE 2 ou 5
# Ao categorizar as variáveis, garantir que sejam transformadas em tipo fator


# ---------------------------------------------------------------------------
# O cut() já devolve fator e mantém NA como NA, atendendo à atenção do roteiro
# right = FALSE faz o intervalo ser fechado à esquerda e aberto à direita

# F_PESO: < 2500 Baixo peso, >= 2500 e < 4000 Peso normal, >= 4000 Macrossomia
dados_sinasc_2$F_PESO = cut(dados_sinasc_2$PESO,
                            breaks = c(-Inf, 2500, 4000, Inf),
                            right  = FALSE,
                            labels = c("Baixo peso", "Peso normal", "Macrossomia"))

# F_IDADE: faixas etárias da mãe
dados_sinasc_2$F_IDADE = cut(dados_sinasc_2$IDADEMAE,
                             breaks = c(-Inf, 15, 20, 25, 30, 35, 40, 45, 50, Inf),
                             right  = FALSE,
                             labels = c("<15", "15-19", "20-24", "25-29", "30-34",
                                        "35-39", "40-44", "45-49", "50+"))

# F_APGAR5: < 7 Baixo, >= 7 Normal
dados_sinasc_2$F_APGAR5 = cut(dados_sinasc_2$APGAR5,
                              breaks = c(-Inf, 7, Inf),
                              right  = FALSE,
                              labels = c("Baixo", "Normal"))

# PEREG: deslocamento materno (peregrinação)
# Não: nasceu no município de residência; Sim: nasceu em outro município
dados_sinasc_2$PEREG = factor(ifelse(dados_sinasc_2$CODMUNNASC ==
                                     dados_sinasc_2$CODMUNRES, "Não", "Sim"),
                              levels = c("Não", "Sim"))

# ESTCIV: ESTCIVMAE já é fator, então a comparação é feita pelas legendas
# Sem companheiro: solteira, viúva ou separada; Com companheiro: casada ou união estável
dados_sinasc_2$ESTCIV = factor(
  ifelse(dados_sinasc_2$ESTCIVMAE %in% c("Solteira", "Viúva",
                                         "Separada judicialmente/divorciada"),
         "Sem companheiro",
  ifelse(dados_sinasc_2$ESTCIVMAE %in% c("Casada", "União estável"),
         "Com companheiro", NA)),
  levels = c("Sem companheiro", "Com companheiro"))

# Conferindo as variáveis criadas
table(dados_sinasc_2$F_PESO, useNA = "ifany")
# resultado: Baixo peso: 10204   Peso normal: 112988   Macrossomia: 7527   NA: 14

table(dados_sinasc_2$F_IDADE, useNA = "ifany")
# resultado: <15: 1298   15-19: 25751   20-24: 35486   25-29: 30788
# 30-34: 22944   35-39: 11370   40-44: 2924   45-49: 159   50+: 13

table(dados_sinasc_2$F_APGAR5, useNA = "ifany")
# resultado: Baixo: 1575   Normal: 128240   NA: 918

table(dados_sinasc_2$PEREG, useNA = "ifany")
# resultado: Não: 61838   Sim: 68895

table(dados_sinasc_2$ESTCIV, useNA = "ifany")
# resultado: Sem companheiro: 57273   Com companheiro: 72390   NA: 1070

# Conferindo que todas as novas variáveis são do tipo fator
class(dados_sinasc_2$F_PESO)
class(dados_sinasc_2$F_IDADE)
class(dados_sinasc_2$F_APGAR5)
class(dados_sinasc_2$PEREG)
class(dados_sinasc_2$ESTCIV)

str(dados_sinasc_2)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 7 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 7" e envie para o repositório Projeto_BDEM_2016


# Tarefa 8. Agregar ao banco de dados_sinasc_2 as informações PESO_P10 e PESO_P90 a partir de Tabela_PIG_Brasil.csv
# a Tabela PIG informa P10 e P90 dos pesos, de acordo com a idade gestacional
# Criar nova variável referente ao peso, de acordo com a idade gestacional, conforme indicado abaixo
# nova variável apenas para casos de GRAVIDEZ Única: dados_sinasc_2$F_PIG: PIG: PESO < PESO_P10, AIG: PESO_P10 <= PESO <= PESO_P90, GIG: PESO > PESO_P90
# Atenção para casos de NA em SEMAGESTAC, PESO ou SEXO. Lembre-se também que em dados_sinasc_2 SEXO está como fator com as categorias Feminino e Masculino.


# ---------------------------------------------------------------------------
# Leitura da Tabela PIG: este arquivo é separado por vírgula, por isso read.csv
tabela_pig = read.csv("Tabela_PIG_Brasil - Tabela_PIG_Brasil.csv")

str(tabela_pig)
head(tabela_pig)
# a tabela tem SEMAGESTAC (de 22 a 42), SEXO, PESO_P10 e PESO_P90
# SEXO já vem escrito como "Masculino" e "Feminino", igual às legendas da Tarefa 6

# Deixando SEXO como fator com os mesmos níveis de dados_sinasc_2 para o merge
tabela_pig$SEXO = factor(tabela_pig$SEXO, levels = c("Masculino", "Feminino"))

# Agregando PESO_P10 e PESO_P90 por idade gestacional e sexo
# all.x = TRUE mantém todos os nascimentos, inclusive os sem correspondência
dados_sinasc_2 = merge(dados_sinasc_2, tabela_pig,
                       by = c("SEMAGESTAC", "SEXO"),
                       all.x = TRUE, sort = FALSE)

# o merge embaralha as linhas; ordenando por CONTADOR o banco fica determinístico
dados_sinasc_2 = dados_sinasc_2[order(dados_sinasc_2$CONTADOR), ]

nrow(dados_sinasc_2)              # continua 130733
summary(dados_sinasc_2$PESO_P10)
summary(dados_sinasc_2$PESO_P90)

# F_PIG, apenas para os casos de GRAVIDEZ Única
# PESO_P10 e PESO_P90 saem NA quando SEMAGESTAC ou SEXO é NA e também quando
# SEMAGESTAC está fora da faixa de 22 a 42 semanas coberta pela Tabela PIG,
# então testar PESO_P10 já cobre as três situações de NA pedidas no roteiro
UNICA  = dados_sinasc_2$GRAVIDEZ %in% "Única"
VALIDO = UNICA & !is.na(dados_sinasc_2$PESO) & !is.na(dados_sinasc_2$PESO_P10)

dados_sinasc_2$F_PIG = factor(
  ifelse(!VALIDO, NA,
  ifelse(dados_sinasc_2$PESO <  dados_sinasc_2$PESO_P10, "PIG",
  ifelse(dados_sinasc_2$PESO <= dados_sinasc_2$PESO_P90, "AIG", "GIG"))),
  levels = c("PIG", "AIG", "GIG"))

# Conferindo a variável criada
table(dados_sinasc_2$F_PIG, useNA = "ifany")
# resultado: PIG: 8083   AIG: 100557   GIG: 14952   NA: 7141
# os NA são as 2524 gestações não únicas mais 4617 gestações únicas sem
# PESO, SEXO ou SEMAGESTAC válidos para a Tabela PIG

class(dados_sinasc_2$F_PIG)       # "factor"
str(dados_sinasc_2)
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 8 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 8" e envie para o repositório Projeto_BDEM_2016


# Tarefa 9. Criar um banco de dados, de nome SINASC_UF.csv (Exemplo: SINASC_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 9 - SINASC.pdf”
# Atenção: a ordem das variáveis do arquivo deve ser respeitada


# ---------------------------------------------------------------------------
# O banco tem 1 linha da UF (CODMUNRES = 26) seguida de 1 linha por município

# --- Municípios e fator usado nas agregações -------------------------------
MUN  = sort(unique(dados_sinasc_2$CODMUNRES))
FMUN = factor(dados_sinasc_2$CODMUNRES, levels = MUN)

# --- Registros completos ---------------------------------------------------
# TNRC precisa das 61 variáveis, então usa dados_sinasc (e não dados_sinasc_2)
dados_sinasc_61 = dados_sinasc[which(substr(dados_sinasc$CODMUNRES, 1, 2) == "26"), ]

# campos em branco também contam como "não informado"
for (v in names(dados_sinasc_61)) {
  dados_sinasc_61[[v]][dados_sinasc_61[[v]] %in% ""] = NA
}

# ordenando por CONTADOR para as linhas ficarem alinhadas com dados_sinasc_2
dados_sinasc_61 = dados_sinasc_61[order(dados_sinasc_61$CONTADOR), ]
identical(dados_sinasc_61$CONTADOR, dados_sinasc_2$CONTADOR)   # deve ser TRUE

COMPLETO_61 = complete.cases(dados_sinasc_61)
COMPLETO_21 = complete.cases(dados_sinasc_2[, names(dados_sinasc_1)])

sum(COMPLETO_61)   # resultado: 0 (ver observação no fim da Tarefa 9)
sum(COMPLETO_21)   # resultado: 118373

# --- Indicadores de contagem, um por variável do arquivo da Tarefa 9 -------
IND = data.frame(
  TN        = rep(TRUE, nrow(dados_sinasc_2)),                  #  4
  TNRC      = COMPLETO_61,                                      #  5
  TNRCR     = COMPLETO_21,                                      #  6
  TGI_15    = dados_sinasc_2$F_IDADE %in% "<15",                #  7
  TGI_15_19 = dados_sinasc_2$F_IDADE %in% "15-19",              #  8
  TGI_20_24 = dados_sinasc_2$F_IDADE %in% "20-24",              #  9
  TGI_25_29 = dados_sinasc_2$F_IDADE %in% "25-29",              # 10
  TGI_30_34 = dados_sinasc_2$F_IDADE %in% "30-34",              # 11
  TGI_35_39 = dados_sinasc_2$F_IDADE %in% "35-39",              # 12
  TGI_40_44 = dados_sinasc_2$F_IDADE %in% "40-44",              # 13
  TGI_45_49 = dados_sinasc_2$F_IDADE %in% "45-49",              # 14
  TGI_50    = dados_sinasc_2$F_IDADE %in% "50+",                # 15
  TGIF      = !is.na(dados_sinasc_2$IDADEMAE) &
              dados_sinasc_2$IDADEMAE >= 15 &
              dados_sinasc_2$IDADEMAE <= 49,                    # 16
  EM_S      = dados_sinasc_2$ESCMAE2010 %in% "Sem escolaridade",     # 22
  EM_FI     = dados_sinasc_2$ESCMAE2010 %in% "Fundamental I",        # 23
  EM_FII    = dados_sinasc_2$ESCMAE2010 %in% "Fundamental II",       # 24
  EM_M      = dados_sinasc_2$ESCMAE2010 %in% "Médio",                # 25
  EM_SI     = dados_sinasc_2$ESCMAE2010 %in% "Superior incompleto",  # 26
  EM_SC     = dados_sinasc_2$ESCMAE2010 %in% "Superior completo",    # 27
  TGRC_B    = dados_sinasc_2$RACACORMAE %in% "Branca",          # 28
  TGRC_PT   = dados_sinasc_2$RACACORMAE %in% "Preta",           # 29
  TGRC_A    = dados_sinasc_2$RACACORMAE %in% "Amarela",         # 30
  TGRC_PD   = dados_sinasc_2$RACACORMAE %in% "Parda",           # 31
  TGRC_I    = dados_sinasc_2$RACACORMAE %in% "Indígena",        # 32
  TGSC      = dados_sinasc_2$ESTCIV %in% "Sem companheiro",     # 33
  TGCC      = dados_sinasc_2$ESTCIV %in% "Com companheiro",     # 34
  TGPRI     = dados_sinasc_2$PARIDADE %in% "Nulípara",          # 35 primípara
  TGNPRI    = dados_sinasc_2$PARIDADE %in% "Multípara",         # 36 não primípara
  TGU       = dados_sinasc_2$GRAVIDEZ %in% "Única",             # 37
  TGG       = dados_sinasc_2$GRAVIDEZ %in% c("Dupla",
                                             "Tripla ou mais"), # 38
  TGD_22    = dados_sinasc_2$GESTACAO %in% "Menos de 22 semanas",  # 39
  TGD_22_27 = dados_sinasc_2$GESTACAO %in% "22 a 27 semanas",      # 40
  TGD_28_31 = dados_sinasc_2$GESTACAO %in% "28 a 31 semanas",      # 41
  TGD_32_36 = dados_sinasc_2$GESTACAO %in% "32 a 36 semanas",      # 42
  TGD_37_41 = dados_sinasc_2$GESTACAO %in% "37 a 41 semanas",      # 43
  TGD_42    = dados_sinasc_2$GESTACAO %in% "42 semanas e mais",    # 44
  TGD_PRT   = dados_sinasc_2$GESTACAO %in% c("Menos de 22 semanas",
                                             "22 a 27 semanas",
                                             "28 a 31 semanas",
                                             "32 a 36 semanas"),   # 45 pré-termo
  TGD_AT    = dados_sinasc_2$GESTACAO %in% "37 a 41 semanas",      # 46 a termo
  TGD_PST   = dados_sinasc_2$GESTACAO %in% "42 semanas e mais",    # 47 pós-termo
  TKC_NR    = dados_sinasc_2$KOTELCHUCK %in% "Não realizou pré-natal", # 53
  TKC_ID    = dados_sinasc_2$KOTELCHUCK %in% "Inadequado",        # 54
  TKC_IT    = dados_sinasc_2$KOTELCHUCK %in% "Intermediário",     # 55
  TKC_AD    = dados_sinasc_2$KOTELCHUCK %in% "Adequado",          # 56
  TKC_MAD   = dados_sinasc_2$KOTELCHUCK %in% "Mais que adequado", # 57
  TGPRG_S   = dados_sinasc_2$PEREG %in% "Sim",                  # 58
  TGPRG_N   = dados_sinasc_2$PEREG %in% "Não",                  # 59
  TPV       = dados_sinasc_2$PARTO %in% "Vaginal",              # 60
  TPC       = dados_sinasc_2$PARTO %in% "Cesário",              # 61
  TRAP_C    = dados_sinasc_2$TPAPRESENT %in% "Cefálico",            # 62
  TRAP_P    = dados_sinasc_2$TPAPRESENT %in% "Pélvica ou podálica", # 63
  TRAP_T    = dados_sinasc_2$TPAPRESENT %in% "Transversa",          # 64
  TGROB_1   = dados_sinasc_2$TPROBSON %in% "Grupo 1",           # 65
  TGROB_2   = dados_sinasc_2$TPROBSON %in% "Grupo 2",           # 66
  TGROB_3   = dados_sinasc_2$TPROBSON %in% "Grupo 3",           # 67
  TGROB_4   = dados_sinasc_2$TPROBSON %in% "Grupo 4",           # 68
  TGROB_5   = dados_sinasc_2$TPROBSON %in% "Grupo 5",           # 69
  TGROB_6   = dados_sinasc_2$TPROBSON %in% "Grupo 6",           # 70
  TGROB_7   = dados_sinasc_2$TPROBSON %in% "Grupo 7",           # 71
  TGROB_8   = dados_sinasc_2$TPROBSON %in% "Grupo 8",           # 72
  TGROB_9   = dados_sinasc_2$TPROBSON %in% "Grupo 9",           # 73
  TGROB_10  = dados_sinasc_2$TPROBSON %in% "Grupo 10",          # 74
  TNLOC_H   = dados_sinasc_2$LOCNASC %in% "Hospital",                         # 75
  TNLOC_ES  = dados_sinasc_2$LOCNASC %in% "Outros estabelecimentos de saúde", # 76
  TNLOC_D   = dados_sinasc_2$LOCNASC %in% "Domicílio",                        # 77
  TNLOC_O   = dados_sinasc_2$LOCNASC %in% "Outros",                           # 78
  TNLOC_AI  = dados_sinasc_2$LOCNASC %in% "Aldeia indígena",                  # 79
  TRS_M     = dados_sinasc_2$SEXO %in% "Masculino",             # 80
  TRS_F     = dados_sinasc_2$SEXO %in% "Feminino",              # 81
  TRRC_B    = dados_sinasc_2$RACACOR %in% "Branca",             # 82
  TRRC_PT   = dados_sinasc_2$RACACOR %in% "Preta",              # 83
  TRRC_A    = dados_sinasc_2$RACACOR %in% "Amarela",            # 84
  TRRC_PD   = dados_sinasc_2$RACACOR %in% "Parda",              # 85
  TRRC_I    = dados_sinasc_2$RACACOR %in% "Indígena",           # 86
  TRP_BP    = dados_sinasc_2$F_PESO %in% "Baixo peso",          # 87
  TRP_N     = dados_sinasc_2$F_PESO %in% "Peso normal",         # 88
  TRP_M     = dados_sinasc_2$F_PESO %in% "Macrossomia",         # 89
  TRPIG_P   = dados_sinasc_2$F_PIG %in% "PIG",                  # 95
  TRPIG_A   = dados_sinasc_2$F_PIG %in% "AIG",                  # 96
  TRPIG_G   = dados_sinasc_2$F_PIG %in% "GIG",                  # 97
  TRAPG5_B  = dados_sinasc_2$F_APGAR5 %in% "Baixo",             # 98
  TRAPG5_N  = dados_sinasc_2$F_APGAR5 %in% "Normal",            # 99
  TRAC      = dados_sinasc_2$IDANOMAL %in% "Sim",               # 102
  TRSAC     = dados_sinasc_2$IDANOMAL %in% "Não"                # 103
)

# --- Funções para as medidas de posição e de dispersão ---------------------
# todas calculadas sem considerar os NA
p25 = function(x) as.numeric(quantile(x, 0.25, na.rm = TRUE))
p50 = function(x) as.numeric(quantile(x, 0.50, na.rm = TRUE))
p75 = function(x) as.numeric(quantile(x, 0.75, na.rm = TRUE))
md  = function(x) mean(x, na.rm = TRUE)
dp  = function(x) sd(x, na.rm = TRUE)

# --- Linha da UF (CODMUNRES = 26) ------------------------------------------
linha_uf = data.frame(
  ANO = 2016, NIVEL = "UF", CODMUNRES = 26,
  t(colSums(IND)),
  IM_P25   = p25(dados_sinasc_2$IDADEMAE),    # 17
  IM_P50   = p50(dados_sinasc_2$IDADEMAE),    # 18
  IM_P75   = p75(dados_sinasc_2$IDADEMAE),    # 19
  IM_MD    = md(dados_sinasc_2$IDADEMAE),     # 20
  IM_DP    = dp(dados_sinasc_2$IDADEMAE),     # 21
  DG_P25   = p25(dados_sinasc_2$SEMAGESTAC),  # 48
  DG_P50   = p50(dados_sinasc_2$SEMAGESTAC),  # 49
  DG_P75   = p75(dados_sinasc_2$SEMAGESTAC),  # 50
  DG_MD    = md(dados_sinasc_2$SEMAGESTAC),   # 51
  DG_DP    = dp(dados_sinasc_2$SEMAGESTAC),   # 52
  PESO_P25 = p25(dados_sinasc_2$PESO),        # 90
  PESO_P50 = p50(dados_sinasc_2$PESO),        # 91
  PESO_P75 = p75(dados_sinasc_2$PESO),        # 92
  PESO_MD  = md(dados_sinasc_2$PESO),         # 93
  PESO_DP  = dp(dados_sinasc_2$PESO),         # 94
  APG5_MD  = md(dados_sinasc_2$APGAR5),       # 100
  APG5_DP  = dp(dados_sinasc_2$APGAR5)        # 101
)

# --- Linhas dos municípios --------------------------------------------------
linhas_municipio = data.frame(ANO = 2016, NIVEL = "MUNICIPIO", CODMUNRES = MUN)

for (v in names(IND)) {
  linhas_municipio[[v]] = as.vector(tapply(IND[[v]], FMUN, sum))
}

est_mun = function(x, f) as.vector(tapply(x, FMUN, f))

linhas_municipio$IM_P25   = est_mun(dados_sinasc_2$IDADEMAE, p25)
linhas_municipio$IM_P50   = est_mun(dados_sinasc_2$IDADEMAE, p50)
linhas_municipio$IM_P75   = est_mun(dados_sinasc_2$IDADEMAE, p75)
linhas_municipio$IM_MD    = est_mun(dados_sinasc_2$IDADEMAE, md)
linhas_municipio$IM_DP    = est_mun(dados_sinasc_2$IDADEMAE, dp)
linhas_municipio$DG_P25   = est_mun(dados_sinasc_2$SEMAGESTAC, p25)
linhas_municipio$DG_P50   = est_mun(dados_sinasc_2$SEMAGESTAC, p50)
linhas_municipio$DG_P75   = est_mun(dados_sinasc_2$SEMAGESTAC, p75)
linhas_municipio$DG_MD    = est_mun(dados_sinasc_2$SEMAGESTAC, md)
linhas_municipio$DG_DP    = est_mun(dados_sinasc_2$SEMAGESTAC, dp)
linhas_municipio$PESO_P25 = est_mun(dados_sinasc_2$PESO, p25)
linhas_municipio$PESO_P50 = est_mun(dados_sinasc_2$PESO, p50)
linhas_municipio$PESO_P75 = est_mun(dados_sinasc_2$PESO, p75)
linhas_municipio$PESO_MD  = est_mun(dados_sinasc_2$PESO, md)
linhas_municipio$PESO_DP  = est_mun(dados_sinasc_2$PESO, dp)
linhas_municipio$APG5_MD  = est_mun(dados_sinasc_2$APGAR5, md)
linhas_municipio$APG5_DP  = est_mun(dados_sinasc_2$APGAR5, dp)

# --- Banco final, com a UF na 1a linha e as colunas na ordem do arquivo ----
SINASC_PE = rbind(linha_uf, linhas_municipio)

ORDEM = c("ANO", "NIVEL", "CODMUNRES",
          "TN", "TNRC", "TNRCR",
          "TGI_15", "TGI_15_19", "TGI_20_24", "TGI_25_29", "TGI_30_34",
          "TGI_35_39", "TGI_40_44", "TGI_45_49", "TGI_50", "TGIF",
          "IM_P25", "IM_P50", "IM_P75", "IM_MD", "IM_DP",
          "EM_S", "EM_FI", "EM_FII", "EM_M", "EM_SI", "EM_SC",
          "TGRC_B", "TGRC_PT", "TGRC_A", "TGRC_PD", "TGRC_I",
          "TGSC", "TGCC", "TGPRI", "TGNPRI",
          "TGU", "TGG",
          "TGD_22", "TGD_22_27", "TGD_28_31", "TGD_32_36", "TGD_37_41",
          "TGD_42", "TGD_PRT", "TGD_AT", "TGD_PST",
          "DG_P25", "DG_P50", "DG_P75", "DG_MD", "DG_DP",
          "TKC_NR", "TKC_ID", "TKC_IT", "TKC_AD", "TKC_MAD",
          "TGPRG_S", "TGPRG_N", "TPV", "TPC",
          "TRAP_C", "TRAP_P", "TRAP_T",
          "TGROB_1", "TGROB_2", "TGROB_3", "TGROB_4", "TGROB_5",
          "TGROB_6", "TGROB_7", "TGROB_8", "TGROB_9", "TGROB_10",
          "TNLOC_H", "TNLOC_ES", "TNLOC_D", "TNLOC_O", "TNLOC_AI",
          "TRS_M", "TRS_F",
          "TRRC_B", "TRRC_PT", "TRRC_A", "TRRC_PD", "TRRC_I",
          "TRP_BP", "TRP_N", "TRP_M",
          "PESO_P25", "PESO_P50", "PESO_P75", "PESO_MD", "PESO_DP",
          "TRPIG_P", "TRPIG_A", "TRPIG_G",
          "TRAPG5_B", "TRAPG5_N",
          "APG5_MD", "APG5_DP",
          "TRAC", "TRSAC")

length(ORDEM)                          # 103 variáveis
setdiff(ORDEM, names(SINASC_PE))       # deve ser character(0)
setdiff(names(SINASC_PE), ORDEM)       # deve ser character(0)

SINASC_PE = SINASC_PE[, ORDEM]

# Conferindo o banco criado
dim(SINASC_PE)     # 187 linhas (1 UF + 186 municípios) e 103 colunas
names(SINASC_PE)
str(SINASC_PE)
head(SINASC_PE[, 1:8])

# Conferindo se a linha da UF é igual à soma dos municípios
SINASC_PE$TN[1] == sum(SINASC_PE$TN[-1])    # deve ser TRUE

# Resultados obtidos para a linha da UF (26 - PE):
# TN 130733          TNRC 0             TNRCR 118373
# TGI_15 1298        TGI_15_19 25751    TGI_20_24 35486    TGI_25_29 30788
# TGI_30_34 22944    TGI_35_39 11370    TGI_40_44 2924     TGI_45_49 159
# TGI_50 13          TGIF 129422
# IM_P25 20          IM_P50 25          IM_P75 30          IM_MD 25.62
# IM_DP 6.62
# EM_S 1011          EM_FI 10834        EM_FII 38830       EM_M 60984
# EM_SI 5407         EM_SC 12237
# TGRC_B 23945       TGRC_PT 5329       TGRC_A 349         TGRC_PD 98292
# TGRC_I 952
# TGSC 57273         TGCC 72390         TGPRI 52578        TGNPRI 78155
# TGU 128209         TGG 2348
# TGD_22 81          TGD_22_27 660      TGD_28_31 1336     TGD_32_36 12812
# TGD_37_41 108319   TGD_42 4691        TGD_PRT 14889      TGD_AT 108319
# TGD_PST 4691
# DG_P25 38          DG_P50 39          DG_P75 40          DG_MD 38.51
# DG_DP 2.30
# TKC_NR 717         TKC_ID 31530       TKC_IT 9935        TKC_AD 11387
# TKC_MAD 71218
# TGPRG_S 68895      TGPRG_N 61838      TPV 64911          TPC 65679
# TRAP_C 124977      TRAP_P 4800        TRAP_T 243
# TGROB_1 30417      TGROB_2 13366      TGROB_3 31614      TGROB_4 7989
# TGROB_5 24649      TGROB_6 1755       TGROB_7 2380       TGROB_8 2303
# TGROB_9 243        TGROB_10 12616
# TNLOC_H 129893     TNLOC_ES 272       TNLOC_D 376        TNLOC_O 189
# TNLOC_AI 0
# TRS_M 66785        TRS_F 63923
# TRRC_B 23971       TRRC_PT 5330       TRRC_A 349         TRRC_PD 98445
# TRRC_I 953
# TRP_BP 10204       TRP_N 112988       TRP_M 7527
# PESO_P25 2930      PESO_P50 3245      PESO_P75 3550      PESO_MD 3212.28
# PESO_DP 560.29
# TRPIG_P 8083       TRPIG_A 100557     TRPIG_G 14952
# TRAPG5_B 1575      TRAPG5_N 128240    APG5_MD 9.45       APG5_DP 0.92
# TRAC 1517          TRSAC 128679

# OBSERVAÇÕES:
# 1. TNRC dá 0 em todos os municípios. Não é erro do script: a variável
#    DTRECORIGA está vazia em TODOS os registros do arquivo do SINASC, logo
#    nenhum nascimento pode ter registro completo nas 61 variáveis.
# 2. O arquivo da Tarefa 9 fala em "22 variáveis selecionadas do SINASC" para
#    o TNRCR, mas a Tarefa 2 do roteiro seleciona 21 colunas. Aqui foram usadas
#    as 21 variáveis de dados_sinasc_1.
# 3. TGPRI usa PARIDADE igual a Nulípara: no SINASC, nulípara é a mãe que ainda
#    não tinha tido parto, ou seja, é justamente a primípara deste nascimento.
# 4. PE tem 185 municípios, mas aparecem 186 códigos: o código 260000
#    ("município ignorado") foi mantido para que a soma dos municípios continue
#    batendo com o total da UF.
# ---------------------------------------------------------------------------

# Ao terminar a Tarefa 9 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 9" e envie para o repositório Projeto_BDEM_2016


# Tarefa 10. Exportar o banco de dados com o nome SINASC_UF.csv (Exemplo: SINASC_RJ.csv)
# Ao terminar a Tarefa 10 commit com o comentário "dados SINASC_UF 2016 e script - SIM - tarefas 1 a 10"  e envie para o repositório Projeto_BDEM_2016



####################################
# ETAPA 3: BANCOS DE DADOS DO SIDRA
####################################
# Você deve criar e estar na branch SIDRA antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler os bancos de dados abaixo listados com os respectivos nomes
# dados_sidra_1 para população residente estimada - UF e municípios - 2016 - SIDRA - tabela_6579.csv
# dados_sidra_2 para população residente censo 2010 - UF e municípios - total e por sexo - SIDRA - tabela_1552.csv
# dados_sidra_3 para população residente censo 2010 - por faixa etária - UF - SIDRA - tabela_1552.csv
# dados_sidra_4 para população residente censo 2010 - por faixa etária e sexo - municípios - SIDRA - tabela_1552.csv
# Atenção que agora os arquivos têm nomes e códigos (com 7 dígitos) dos municípios (e alguns UF)

# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados


# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SIDRA - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Criar uma nova variável de nome CODUF com os códigos da UF nos bancos dados_sidra_1, dados_sidra_2, dados_sidra_4


# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Selecionar em dados_sidra_ 1 a dados_sidra_4 a UF de responsabilidade do aluno 
# e chamar os bancos de dados, respectivamente por sidra_1, sidra_2, sidra_3 e sidra_4


# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4: Criar um banco de dados, de nome SIDRA_UF.csv (Exemplo: SIDRA_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 4 - SIDRA.pdf”

# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5:Exportar o banco de dados com o nome SIDRA_UF.csv (Exemplo: SIDRA_RJ.csv)
# Ao terminar a Tarefa 5 commit com o comentário "dados SIDRA_UF 2016 e script - SIDRA - tarefas 1 a 5"  e envie para o repositório Projeto_BDEM_2016


####################################
# ETAPA 4: BANCOS DE DADOS DO ATLAS
####################################
# Você deve criar e estar na branch ATLAS antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler os bancos de dados abaixo listados com os respectivos nomes
# codigos_IBGE_2010 para códigos dos municípios - 2010.csv
# dados_atlas_1 para IDHM - 2010 (CENSO) e 2016 (PNAD) - total e por sexo - UF - Atlas Brasil.csv
# dados_atlas_2 para IDHM - 2010 - municípios - Atlas Brasil.csv
# Atenção que agora alguns arquivos só têm os nomes dos municípios e das UFs, mas não têm os códigos

# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - ATLAS - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2: Manipular o banco de dados e criar o banco de dados ATLAS_UF

# Criar o banco UF_codigo tipo tabela de correspondência
UF_codigo = data.frame(
  UF = c("Rondônia","Acre","Amazonas","Roraima","Pará","Amapá","Tocantins",
         "Maranhão","Piauí","Ceará","Rio Grande do Norte","Paraíba",
         "Pernambuco","Alagoas","Sergipe","Bahia","Minas Gerais",
         "Espírito Santo","Rio de Janeiro","São Paulo","Paraná",
         "Santa Catarina","Rio Grande do Sul","Mato Grosso do Sul",
         "Mato Grosso","Goiás","Distrito Federal"),
  
  SIGLA = c("RO","AC","AM","RR","PA","AP","TO",
            "MA","PI","CE","RN","PB","PE","AL",
            "SE","BA","MG","ES","RJ","SP",
            "PR","SC","RS","MS","MT","GO","DF"),
  
  CODUF = c(11,12,13,14,15,16,17,
            21,22,23,24,25,26,27,
            28,29,31,32,33,35,
            41,42,43,50,51,52,53)
)

# Retirar de dados_atlas_1 a linha do Brasil e adicionar (com merge by UF) as colunas de UF_codigo

# Criar o banco linha_estado somente com as linhas da UF e com as seguintes colunas:
# ANO=2016, NIVEL=UF, CODMUNRES, IDHM_A, IDHM_CA, IDHM_CA_M e IDHM_CA_F 

# Selecionar de linha_estado a UF da responsabilidade do aluno por CODMUNRES

# Criar em dados_atlas_2 a coluna com UF

# Retirar (UF) da variável município

# Acrescentar em codigos_IBGE_2010 a variável CODUF baseado nos dois primeiros dígitos de CODMUNRES

# Acrescentar a codigos_IBGE_2010 as variáveis de UF_codigo (merge by CODUF)

# Associar dados_atlas_2 a codigos_IBGE_2010 e nomear o novo arquivo por atlas_municipio
# Neste caso o merge será by.x = c("município","UF") e by.y = c("município","SIGLA")

# Remover de atlas_municipio a coluna UF.y criada no merge

# Selecionar somente a UF de responsabilidade do aluno através dos dois primeiros dógitos de CODMUNRES

# Criar banco ATLAS_MUNICIPIO com as linhas dos municípios e com as seguintes variáveis:
# ANO=2016, NIVEL=MUNICIPIO, CODMUNRES, IDHM_A=NA, IDHM_CA, IDHM_CA_M=NA, IDHM_CA_F=NA

# Criar banco final ATLAS_UF "juntando" os bancos linha_estado e ATLAS_MUNICIPIO


# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - ATLAS - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Exportar o banco de dados com o nome ATLAS_UF.csv (Exemplo: ATLAS_RJ.csv)
# Ao terminar a Tarefa 3 commit com o comentário "dados ATLAS_UF 2016 e script - ATLAS - tarefas 1 a 3"  e envie para o repositório Projeto_BDEM_2016



####################################
# ETAPA 5: BANCOS DE DADOS DO SINISA
####################################
# Você deve criar e estar na branch SINISA antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler o bancos de dados abaixo listado com os respectivo nome
# dados_sinisa para agua e esgoto - município - 2016.csv
# Atenção que o arquivo tem códigos e nomes de municípios e muitos NAs. 
# Repare que os valores estão com o milhar indicado por ponto, o que não deve acontecer para o R não entender como decimal

# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados
# Remover a pontuação de milhar e converter para formato numérico

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SINISA - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Reduzir dados_sinisa apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sinisa_1

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SINISA - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Criar um banco de dados, de nome SINISA_UF.csv (Exemplo: SINISA_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 3 - SINISA.pdf”

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SINISA - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Exportar o banco de dados com o nome SINISA_UF.csv (Exemplo: SINISA_RJ.csv)
# Ao terminar a Tarefa 4 commit com o comentário "dados SINISA_UF 2016 e script - SINISA - tarefas 1 a 4"  e enviar para o repositório Projeto_BDEM_2016



################################
# ETAPA 6: CRIAÇÃO DE BDEM_UF
################################
# Você deve estar agora em main e antes de inserir qualquer comando desta ETAPA
# deverá fazer os merges de cada uma das 5 branches. A cada merge pode fazer o comentário "merge da branch TAL"
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Agregar os arquivos SIDRA_UF, ATLAS_UF, SINASC_UF, SIM_UF, SINISA_UF no banco BDEM_UF (Exemplo: BDEM_RJ)
# Leitura dos 5 bancos de dados expeortados das etapas anteriores

# Agregação dos bancos
# Lembre-se que SIDRA e ATLAS tem CODMUNRES com 7 dígitos e SINASC, SIM e SINISA com 6 dígitos
# Além disso dentro do merge all = TRUE garante a manutenção de qualquer município presente em um dos bancos envolvidos no merge


# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - BDEM - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2: Inserir os seguintes indicadores epidemiológicos (com apenas dias casas decimais) no BDEM_UF:
# TFG: Taxa de fecundidade geral
# TMG: Taxa de mortalidade geral
# RMM: Razão de mortalidade materna
# TMM: Taxa de mortalidade materna
# TMM_P: Taxa de mortalidade materna em até 42 dias
# TMN: Taxa de mortalidade neonatal
# TMN_P: Taxa de mortalidade neonatal precoce
# TMN_T: Taxa de mortalidade neonatal tardia
# TMI: Taxa de mortalidade infantil

# Conferir o banco BDEM_UF após inserção dos indicadores

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - BDEM - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3: Exportar o banco de dados com o nome BDEM_UF.csv (Exemplo: BDEM_RJ.csv)
# Ao terminar a Tarefa 3 commit com o comentário "dados BDEM_UF 2016 e script - BDEM - tarefas 1 a 3"  e enviar para o repositório Projeto_BDEM_2016
 