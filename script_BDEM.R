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


# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Verificar em dados_sinasc_2 a frequência das categorias das seguintes variáveis: LOCNASC, ESTCIVMAE, GESTACAO, GRAVIDEZ, PARTO,
# SEXO, RACACOR, IDANOMAL, ESCMAE2010, RACACORMAE, TPAPRESENT, TPROBSON, PARIDADE, KOTELCHUCK
# Avalie também os valores das variáveis quantitativas de IDADEMAE, SEMAGESTAC, APGAR5 e PESO


# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5. Atribuir para cada variável de dados_sinasc_2 como sendo NA a categoria de "Não informado ou Ignorado", 
# geralmente com código 9
# Verifique o dicionário do SINASC para identificar qual o código das categorias de cada variável
# KOTELCHUCK = 9 significa "Não informado"   TPROBSON = 11 significa "Não classificado por falta de informação"
# Em variáveis quantitativas como IDADEMAE verificar se existem valores como 9999 para NA


# Ao terminar a Tarefa 5 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 5" e envie para o repositório Projeto_BDEM_2016


# Tarefa 6. Atribuir legendas para as categorias das variáveis qualitativas investigadas na tarefa 4.
# Exemplo: dados_sinasc_2$KOTELCHUCK = factor(dados_sinasc_2$KOTELCHUCK, levels = c(1,2,3,4,5), 
# labels = c("Não realizou pré-natal", "Inadequado", "Intermediário", "Adequado",  
# "Mais que adequado")

# ATENçÃO: 1. Na hora de escrever os labels, somente a primeira letra da legenda é maiúscula. Exemplo para SEXO: Feminino e Masculino
#          2. Nesta Tarefa 6 não crie novas variáveis dentro do banco de dados


# Ao terminar a Tarefa 6 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 6" e envie para o repositório Projeto_BDEM_2016


# Tarefa 7. Categorizar as variáveis IDADEMAE, PESO e APGAR5 e criar variáveis referentes ao deslocamento materno (peregrinação) e estado civil
# nova variável: dados_sinasc_2$F_PESO com PESO: < 2500: Baixo peso, >=2500 e < 4000: Peso normal, >= 4000: Macrossomia
# nova variável dados_sinasc_2$F_IDADE com IDADEMAE: <15, 15-19, 20-24, 25-29, 30-34, 35-39, 40-44, 45-49, 50+
# nova variável dados_sinasc_2$F_APGAR5 com APGAR5: < 7: Baixo, >= 7: Normal
# Atenção para casos de NA em IDADEMAE, PESO e APGAR5
# nova variável: dados_sinasc_2$PEREG: Não: CODMUNNASC igual a CODMUNRES, Sim: CODMUNNASC diferente de CODMUNRES
# nova variável: dados_sinasc_2$ESTCIV: Sem companheiro: ESTCIVMAE 1, 3 ou 4, Com companheiro: ESTCIVMAE 2 ou 5
# Ao categorizar as variáveis, garantir que sejam transformadas em tipo fator


# Ao terminar a Tarefa 7 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 7" e envie para o repositório Projeto_BDEM_2016


# Tarefa 8. Agregar ao banco de dados_sinasc_2 as informações PESO_P10 e PESO_P90 a partir de Tabela_PIG_Brasil.csv
# a Tabela PIG informa P10 e P90 dos pesos, de acordo com a idade gestacional
# Criar nova variável referente ao peso, de acordo com a idade gestacional, conforme indicado abaixo
# nova variável apenas para casos de GRAVIDEZ Única: dados_sinasc_2$F_PIG: PIG: PESO < PESO_P10, AIG: PESO_P10 <= PESO <= PESO_P90, GIG: PESO > PESO_P90
# Atenção para casos de NA em SEMAGESTAC, PESO ou SEXO. Lembre-se também que em dados_sinasc_2 SEXO está como fator com as categorias Feminino e Masculino.


# Ao terminar a Tarefa 8 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 8" e envie para o repositório Projeto_BDEM_2016


# Tarefa 9. Criar um banco de dados, de nome SINASC_UF.csv (Exemplo: SINASC_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 9 - SINASC.pdf”
# Atenção: a ordem das variáveis do arquivo deve ser respeitada


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
 