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

-- Wejściowe parametry
efektywnosc = 0.9 -- Dobre inwestycje / złe inwestycje
ratio = 0.5 -- Średni zysk / średnia strata
liczba_inwestycji = 108
poczatkowy_kapital = 10000
inwestycji_rocznie = 36
prawdopodobienstwo_zysku = 0.95
koszta_transakcyjne = 0.01
podatek = 0.19
waluta = "PLN"

-- Krok 0

sukces = 1 - prawdopodobienstwo_zysku
netto = 1 - podatek

-- Krok 1: Obliczenie oczekiwanej stopy zwrotu z uwzględnieniem kosztów transakcyjnych
oczekiwana_stopa_zwrotu = efektywnosc * (ratio * (1 - koszta_transakcyjne))
	- (1 - efektywnosc) * (1 + koszta_transakcyjne)

-- Krok 2: Obliczenie odchylenia standardowego z uwzględnieniem kosztów transakcyjnych
odchylenie_standardowe =
	math.sqrt(efektywnosc * (ratio * (1 - koszta_transakcyjne)) ^ 2 + (1 - efektywnosc) * (1 + koszta_transakcyjne) ^ 2)

-- Krok 3: Zastosowanie nierówności Chernoffa
epsilon = -1 -- Chcemy, aby końcowy kapitał był większy niż początkowy
mu = liczba_inwestycji * oczekiwana_stopa_zwrotu
prawdopodobienstwo_powodzenia = math.exp(-mu * epsilon ^ 2 / 3)
maksymalny_procent_kapitalu = mu * epsilon / (liczba_inwestycji * math.log(sukces))

-- Krok 4: Symulacja inwestycji i obliczenie końcowej wartości kapitału
koncowa_wartosc_kapitalu = poczatkowy_kapital
for i = 1, liczba_inwestycji do
	kwota_inwestycji = koncowa_wartosc_kapitalu * maksymalny_procent_kapitalu
	wynik_inwestycji = (efektywnosc * ratio * (1 - koszta_transakcyjne))
		- ((1 - efektywnosc) * (1 + koszta_transakcyjne))
	koncowa_wartosc_kapitalu = koncowa_wartosc_kapitalu + kwota_inwestycji * wynik_inwestycji

	-- Pomniejszanie kapitału o podatek (co roku)
	if i % inwestycji_rocznie == 0 then
		koncowa_wartosc_kapitalu = koncowa_wartosc_kapitalu * netto
	end

	-- Pomniejszanie kapitału o podatek (co roku)
	if i % (inwestycji_rocznie * 2) == 0 then
		koncowa_wartosc_kapitalu = koncowa_wartosc_kapitalu * netto
	end

	-- Pomniejszanie kapitału o podatek (co roku)
	if i % (inwestycji_rocznie * 3) == 0 then
		koncowa_wartosc_kapitalu = koncowa_wartosc_kapitalu * netto
	end

	-- Pomniejszanie kapitału o podatek (co roku)
	if i % (inwestycji_rocznie * 4) == 0 then
		koncowa_wartosc_kapitalu = koncowa_wartosc_kapitalu * netto
	end

	-- Pomniejszanie kapitału o podatek (co roku)
	if i % (inwestycji_rocznie * 5) == 0 then
		koncowa_wartosc_kapitalu = koncowa_wartosc_kapitalu * netto
	end

	-- Pomniejszanie kapitału o podatek (co roku)
	if i % (inwestycji_rocznie * 6) == 0 then
		koncowa_wartosc_kapitalu = koncowa_wartosc_kapitalu * netto
	end

	-- Pomniejszanie kapitału o podatek (co roku)
	if i % (inwestycji_rocznie * 7) == 0 then
		koncowa_wartosc_kapitalu = koncowa_wartosc_kapitalu * netto
	end

	-- Pomniejszanie kapitału o podatek (co roku)
	if i % (inwestycji_rocznie * 8) == 0 then
		koncowa_wartosc_kapitalu = koncowa_wartosc_kapitalu * netto
	end

	-- Pomniejszanie kapitału o podatek (co roku)
	if i % (inwestycji_rocznie * 9) == 0 then
		koncowa_wartosc_kapitalu = koncowa_wartosc_kapitalu * netto
	end

	-- Pomniejszanie kapitału o podatek (co roku)
	if i % (inwestycji_rocznie * 10) == 0 then
		koncowa_wartosc_kapitalu = koncowa_wartosc_kapitalu * netto
	end
end

-- Krok 5: Obliczenie odchylenia standardowego końcowej wartości kapitału
odchylenie_standardowe_koncowe = poczatkowy_kapital
	* odchylenie_standardowe
	* math.sqrt(liczba_inwestycji)
	* maksymalny_procent_kapitalu

-- Krok 6: Funkcja gęstości prawdopodobieństwa rozkładu normalnego
function normpdf(x, mu, sigma)
	return (1 / (sigma * math.sqrt(2 * math.pi))) * math.exp(-(x - mu) ^ 2 / (2 * sigma ^ 2))
end

-- Krok 7: Znalezienie najbardziej prawdopodobnej końcowej wartości kapitału
najbardziej_prawdopodobna_wartosc = koncowa_wartosc_kapitalu
najwieksza_gestosc =
	normpdf(najbardziej_prawdopodobna_wartosc, koncowa_wartosc_kapitalu, odchylenie_standardowe_koncowe)

for x = koncowa_wartosc_kapitalu - 10 * odchylenie_standardowe_koncowe, koncowa_wartosc_kapitalu + 10 * odchylenie_standardowe_koncowe, sukces do
	gestosc = normpdf(x, koncowa_wartosc_kapitalu, odchylenie_standardowe_koncowe)
	if gestosc > najwieksza_gestosc then
		najwieksza_gestosc = gestosc
		najbardziej_prawdopodobna_wartosc = x
	end
end

print("Dobre inwestycje / złe inwestycje = ", efektywnosc)
print("Średni zysk / średnia strata =  ", ratio)
print("Podatek =                       ", podatek * 100 .. "%")
print("")

if prawdopodobienstwo_powodzenia <= sukces then
	maksymalny_procent_kapitalu = mu * epsilon / (liczba_inwestycji * math.log(sukces))
	print(
		string.format(
			"Aby mieć co najmniej %.1f%% prawdopodobieństwo wzrostu kapitału po %d inwestycjach (%.2f latach), powinieneś inwestować maksymalnie %.2f%% kapitału przy każdej inwestycji.",
			prawdopodobienstwo_zysku * 100,
			liczba_inwestycji,
			liczba_inwestycji / inwestycji_rocznie,
			maksymalny_procent_kapitalu * 100
		)
	)
	print(
		string.format(
			"Przy początkowym kapitale %d %s, oznacza to zainwestowanie nie więcej niż %.2f %s.",
			poczatkowy_kapital,
			waluta,
			poczatkowy_kapital * maksymalny_procent_kapitalu,
			waluta
		)
	)
	print(
		string.format(
			"Najbardziej prawdopodobna końcowa wartość kapitału po %d inwestycjach: %.2f %s",
			liczba_inwestycji,
			najbardziej_prawdopodobna_wartosc,
			waluta
		)
	)
else
	print(
		string.format(
			"Niestety, nie można zagwarantować %.1f%% prawdopodobieństwa wzrostu kapitału przy podanych parametrach.",
			prawdopodobienstwo_zysku * 100
		)
	)
end
