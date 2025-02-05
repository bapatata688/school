
Algoritmo sin_titulo
	Definir c  Como Caracter
	Definir  a, b, restar, agregar, empate, f, resultado Como Real
	Escribir "cuantos partidos gano?"
	Leer a
	agregar = a * 5
	Escribir "cuantos partidos perdio?"
	leer b
	restar = b -b -b
	Escribir "empato partidos? (si/no)"
	leer c
	si c = "si" Entonces
		Escribir "cuantos empato? "
		leer f
		empate = f * 2
		total = empate + agregar
		resultado = empate + agregar - b
		Escribir "---partidos ganados:---" " ---partidos perdidos:---"
		Escribir "---" "!!!!! ", a " !!!!" "---" "   ---" "!!!!! ", b " !!!!!" "----"
		escribir "---puntos ganados---"  " ---puntos perdidos---"
		Escribir "---" "!!!!! ", total " !!!!!" "---" " ---" "!!!!! ",restar " !!!!!" "---"
		Escribir "-----" "!!" "total de puntos: ", resultado "!!" "-----"
	SiNo
		resultado = agregar - b
		Escribir "---partidos ganados:---" " ---partidos perdidos:---"
		Escribir "---" "!!!!! ", a " !!!!" "---" "   ---" "!!!!! ", b " !!!!!" "----"
		escribir "---puntos ganados---"  " ---puntos perdidos---"
		Escribir "---" "!!!!! ", agregar " !!!!!" "---" " ---" "!!!!! ",restar " !!!!!" "---"
		Escribir "-----" "!!" "total de puntos:", resultado "!!" "-----"
	FinSi
FinAlgoritmo