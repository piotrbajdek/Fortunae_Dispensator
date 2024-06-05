#!/usr/bin/env lua

--[[

# BSD 3-Clause No Military License

Copyright © 2024, Piotr Bajdek. All Rights Reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistribution of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistribution in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

YOU ACKNOWLEDGE THAT THIS SOFTWARE IS NOT DESIGNED, LICENSED OR INTENDED FOR USE IN THE DESIGN, CONSTRUCTION, OPERATION OR MAINTENANCE OF ANY MILITARY FACILITY.

]]

-- Parámetros de entrada
eficiencia = 0.8 -- Buenas inversiones / malas inversiones
ratio = 0.5 -- Ganancia promedio / pérdida promedio
numero_de_inversiones = 108
capital_inicial = 10000
inversiones_anuales = 36
probabilidad_de_ganancia = 0.95
impuesto = 0.19
moneda = "EUR"

-- Paso 0

fracaso = 1 - probabilidad_de_ganancia
neto = 1 - impuesto

-- Paso 1: Calcular la tasa de retorno esperada
tasa_de_retorno_esperada = ((ratio * eficiencia) - (1 - eficiencia)) / ratio

-- Paso 2: Calcular la desviación estándar
desviacion_estandar = math.sqrt((eficiencia * ratio) ^ 2 + (1 - eficiencia) ^ 2)

-- Paso 3: Aplicar la desigualdad de Chernoff
epsilon = -1 -- Queremos que el capital final sea mayor que el inicial
mu = numero_de_inversiones * tasa_de_retorno_esperada
probabilidad_exito = math.exp(-mu * epsilon ^ 2 / 3)
porcentaje_maximo_capital = mu * epsilon / (numero_de_inversiones * math.log(fracaso))

-- Paso 4: Simular las inversiones y calcular el valor final del capital
valor_final_capital = capital_inicial
for i = 1, numero_de_inversiones do
	monto_inversion = valor_final_capital * porcentaje_maximo_capital
	resultado_inversion = tasa_de_retorno_esperada
	valor_final_capital = valor_final_capital + monto_inversion * resultado_inversion

	-- Disminuir el capital por impuestos (anualmente)
	if i % inversiones_anuales == 0 then
		valor_final_capital = valor_final_capital * neto
	end

	-- Disminuir el capital por impuestos (anualmente)
	if i % (inversiones_anuales * 2) == 0 then
		valor_final_capital = valor_final_capital * neto
	end

	-- Disminuir el capital por impuestos (anualmente)
	if i % (inversiones_anuales * 3) == 0 then
		valor_final_capital = valor_final_capital * neto
	end

	-- Disminuir el capital por impuestos (anualmente)
	if i % (inversiones_anuales * 4) == 0 then
		valor_final_capital = valor_final_capital * neto
	end

	-- Disminuir el capital por impuestos (anualmente)
	if i % (inversiones_anuales * 5) == 0 then
		valor_final_capital = valor_final_capital * neto
	end

	-- Disminuir el capital por impuestos (anualmente)
	if i % (inversiones_anuales * 6) == 0 then
		valor_final_capital = valor_final_capital * neto
	end

	-- Disminuir el capital por impuestos (anualmente)
	if i % (inversiones_anuales * 7) == 0 then
		valor_final_capital = valor_final_capital * neto
	end

	-- Disminuir el capital por impuestos (anualmente)
	if i % (inversiones_anuales * 8) == 0 then
		valor_final_capital = valor_final_capital * neto
	end

	-- Disminuir el capital por impuestos (anualmente)
	if i % (inversiones_anuales * 9) == 0 then
		valor_final_capital = valor_final_capital * neto
	end

	-- Disminuir el capital por impuestos (anualmente)
	if i % (inversiones_anuales * 10) == 0 then
		valor_final_capital = valor_final_capital * neto
	end
end

-- Paso 5: Calcular la desviación estándar del valor final del capital
desviacion_estandar_final = capital_inicial
	* desviacion_estandar
	* math.sqrt(numero_de_inversiones)
	* porcentaje_maximo_capital

-- Paso 6: Función de densidad de probabilidad de la distribución normal
function normpdf(x, mu, sigma)
	return (1 / (sigma * math.sqrt(2 * math.pi))) * math.exp(-(x - mu) ^ 2 / (2 * sigma ^ 2))
end

-- Paso 7: Encontrar el valor final del capital más probable
valor_mas_probable = valor_final_capital
densidad_maxima = normpdf(valor_mas_probable, valor_final_capital, desviacion_estandar_final)

for x = valor_final_capital - 10 * desviacion_estandar_final, valor_final_capital + 10 * desviacion_estandar_final, fracaso do
	densidad = normpdf(x, valor_final_capital, desviacion_estandar_final)
	if densidad > densidad_maxima then
		densidad_maxima = densidad
		valor_mas_probable = x
	end
end

print("Buenas inversiones / malas inversiones = ", eficiencia)
print("Ganancia promedio / pérdida promedio =  ", ratio)
print("Impuesto =                              ", impuesto * 100 .. "%")
print("")

if probabilidad_exito <= fracaso then
	porcentaje_maximo_capital = mu * epsilon / (numero_de_inversiones * math.log(fracaso))
	print(
		string.format(
			"Para tener al menos %.1f%% de probabilidad de aumentar el capital después de %d inversiones (%.2f años), deberías invertir como máximo %.2f%% del capital en cada inversión.",
			probabilidad_de_ganancia * 100,
			numero_de_inversiones,
			numero_de_inversiones / inversiones_anuales,
			porcentaje_maximo_capital * 100
		)
	)
	print(
		string.format(
			"Con un capital inicial de %d %s, esto significa invertir no más de %.2f %s.",
			capital_inicial,
			moneda,
			capital_inicial * porcentaje_maximo_capital,
			moneda
		)
	)
	print(
		string.format(
			"El valor final del capital más probable después de %d inversiones: %.2f %s",
			numero_de_inversiones,
			valor_mas_probable,
			moneda
		)
	)
else
	print(
		string.format(
			"Lamentablemente, no se puede garantizar una probabilidad de %.1f%% de aumento del capital con los parámetros dados.",
			probabilidad_de_ganancia * 100
		)
	)
end
