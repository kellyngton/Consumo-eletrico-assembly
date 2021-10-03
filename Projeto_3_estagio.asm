##
 # CALCULADORA DE CONSUMO
 #
 #@author kellyngton luiz da costa dias
 # @version 1.0
 # @since 30/03/2020 
 # TODO: While e/ou for 
 # if e/ou else 
 # input do usuário e escrita na tela
 # Propósito do programa
##
		
       		.data
entradaEletro:	.asciiz	"Quantos eletrodomésticos deseja calcular o consumo? \n"		#MSG numero de loops
numImpossivel:	.asciiz	"Número de eletrodomestico Impossivel \n"				#MSG caso passe um número negativo ou nulo
entradaPotencia:.asciiz "Informe a potencia do aparelho \n"				#MSG
horasConsumidas:.asciiz	"Iforme a quantidade de horas  usadas \n"				#MSG
divisor:	.float 1000
quantDiasMes:	.float 30
saidaValorTotal:.asciiz "O consumo mensal é de: \n"
saidaFimProg:	.asciiz	"\n FIM DO PROGRAMA!!! \n"						#Syscall
		.text
		.globl inicio 
inicio:
		#Quantidade para LOOP WHILE
		li $v0,4	#Comando pra printar na tela
		la $a0, entradaEletro
		syscall		#Executa
		
		li $v0,5	#Input do usuário LOOP WHIle
		syscall		#Executa
		
		move $t1, $v0	#CONTADOR DO PROGRAMA   		
		blez $t1, valorNotFound	#if entradaEletro <= 0
while:
potencia:	
		li $v0, 4	#Comando pra printar na tela
		la $a0, entradaPotencia
		syscall		#Executa
		
		li $v0, 6	#Imput do usuário POTENCIA
		syscall		#Executa
		
		mov.s $f2, $f0	#Move o valor da potencia para o registrador de precisão simples COPROC1->$F2

consumo:			#Quantidade de horas consumidas
		li $v0, 4	#Comando pra printar na tela
		la $a0, horasConsumidas
		syscall		#Executa

		li $v0, 6	#Imput do usuário HORAS CONSUMIDAS
		syscall		#Executa
		
		mov.s $f4, $f0	#Move o valor do consumo para o registrado de precisão simples COPROCC1->$F4

calculo:
		mul.s $f6, $f2, $f4	#Pontencia*consumo
		
		lwc1 $f8, divisor	#coloca a constante da divisao no resgistrador $t8
		div.s $f10, $f6,$f8 	#(Potencia*consumo)/1000
		
		lwc1 $f14, quantDiasMes #coloa a constante para a multiplicação no registrador $f14
		mul.s $f16, $f10,$f14 	#((Potencia* Consumo)*30)
		
		add.s $f1, $f1, $f16	#consumoTotal += calculoMensal	
		
		sub $t1, $t1, 1		#Atualiza o contador		
		
		bgt $t1,$zero, while	#Volta pro LOOP caso a entradaEletro seja > 0

valorTotal:			#TODO: implementar
		mov.s $f12, $f1		#Move o resultado total para o $f12
		li $v0, 4		#Printa na tela
		la $a0, saidaValorTotal	
		syscall			#Execute
		
		li $v0, 2	#printa um float na tela é sempre o #$f12
		syscall		#executa
		b fim

valorNotFound:			#Se o valor do loop for <= 0
		li $v0, 4
		la $a0, numImpossivel
		syscall		#Executa
		
		b inicio	#Pula para o início do programa

fim:
		li $v0, 4	#Comando para pintar na tela
		la $a0, saidaFimProg
		syscall		#Executa
