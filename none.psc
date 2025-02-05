Algoritmo none
	Definir numero, mayor, menor Como Real
	Definir i Como Entero
	Escribir 'ingrese numero'
	Leer numero
	mayor <- numero
	menor <- numero
	Para i<-1 Hasta 4 Con Paso 1 Hacer
		Escribir 'ingrese numero'
		Leer numero
		Si numero>mayor Entonces
			mayor <- numero
		FinSi
		Si numero<menor Entonces
			menor <- numero
		FinSi
	FinPara
	Escribir 'numero es menor ', menor
	Escribir 'numero es mayor ', mayor
FinAlgoritmo
