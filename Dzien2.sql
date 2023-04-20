

select * from zawodnicy

select * from trenerzy

select * from zawody


-- jeden zawodnik mo¿e byæ trenowany przez jednego trenera 
-- jeden trener mo¿e trenowaæ wielu zawodników 
-- czyli to jest typ relacji "jeden do wielu"

-- jeden zawodnik mo¿e uczestniczyæ w wielu zawodach
-- jedne zawody mog¹ dotyczyæ wielu zawodników 
-- czyli tutaj mamy typ relacji "wiele do wielu"

-- mo¿e wyst¹piæ jeszcze trzeci typ relacji "jeden do jednego" 

select * from uczestnictwa

-- tabelka ³¹cz¹ca mo¿e siê nazywaæ Zawodnicy_Zawody


select * from zawodnicy

select * from trenerzy 



select * 
from zawodnicy inner join  trenerzy  on zawodnicy.id_trenera = trenerzy.id_trenera

select * 
from zawodnicy left join  trenerzy  on zawodnicy.id_trenera = trenerzy.id_trenera

select * 
from zawodnicy right join  trenerzy  on zawodnicy.id_trenera = trenerzy.id_trenera

select * 
from trenerzy left join zawodnicy   on zawodnicy.id_trenera = trenerzy.id_trenera


select * 
from zawodnicy full outer join  trenerzy  on zawodnicy.id_trenera = trenerzy.id_trenera


select imie, nazwisko
from zawodnicy

select zawodnicy.imie, zawodnicy.nazwisko
from zawodnicy


select zawodnicy.imie, trenerzy.imie_t , zawodnicy.id_trenera
from zawodnicy inner join  trenerzy  on zawodnicy.id_trenera = trenerzy.id_trenera

-- aliasy 

select z.imie
from zawodnicy z

select z.imie, t.imie_t , z.id_trenera
from zawodnicy z inner join  trenerzy t on z.id_trenera = t.id_trenera


-- znajdz pary trener-zawodnik, takie, ¿e pierwsza literka zawodnika jest
-- taka sama jak pierwsza literka ternera 


select *
from zawodnicy z join trenerzy t on left(z.imie,1) = left(t.imie_t,1)
 

-- Wypisz zawodników, tylko tych, którzy posiadaj¹ trenera o nazwisku o d³ugosci krótszej ni¿ 7

select *
from zawodnicy z join trenerzy t on z.id_trenera = t.id_trenera
where len(t.nazwisko_t) < 7


-- wypisz pary zawodnikow i trenerów, których nazwisko zaczyna siê na tak¹ litere
 -- oraz ustal, ¿e trener ma trenowaæ danego zawodnika 

select *
from zawodnicy z join trenerzy t on left(z.imie,1) = left(t.imie_t,1) and 
								    z.id_trenera = t.id_trenera

select *
from zawodnicy z join trenerzy t on left(z.imie,1) = left(t.imie_t,1) 
where  z.id_trenera = t.id_trenera

select *
from zawodnicy z join trenerzy t on z.id_trenera = t.id_trenera  
where  left(z.imie,1) = left(t.imie_t,1)

select *
from zawodnicy z , trenerzy t 
where z.id_trenera = t.id_trenera and left(z.imie,1) = left(t.imie_t,1)


-- mo¿emy ³¹czyæ dowoln¹ liczbê tabelek 

select *
from zawodnicy z , trenerzy t , skocznie s


-- po³¹cz zawody z zawodnikami czyli tak naprawdê
-- trzeba polaczyc zawody z uczestnictwami i z zawodnikami 


select *
from zawodnicy z left join uczestnictwa u on z.id_zawodnika = u.id_zawodnika
			     left join zawody zw on zw.id_zawodow = u.id_zawodow
				-- left join.. ewentualnie dorzucamy kolejne tabelki 

-- str 29 

-- 3 

select *
from zawodnicy where id_trenera is null

select *
from zawodnicy 
where
	1=1 
	--or kraj = 'pol'
	--or wzrost > 10
	--or waga < 20

--4 

select  t.imie_t + ' ' + t.nazwisko_t + ' - ' +z.imie + ' ' + z.nazwisko  
from zawodnicy z right join trenerzy t on z.id_trenera = t.id_trenera

-- 5 

select *
from trenerzy t left join zawodnicy z on z.id_trenera = t.id_trenera
where z.id_zawodnika is null

-- 6 

select *
from trenerzy t left join zawodnicy z on z.id_trenera = t.id_trenera
where z.id_zawodnika is not null

select *
from trenerzy t join zawodnicy z on z.id_trenera = t.id_trenera

select distinct t.*
from trenerzy t join zawodnicy z on z.id_trenera = t.id_trenera

--7 

-- zawody -- skocznie -- miasta 

select zw.nazwa, s.nazwa_skoczni, m.nazwa_miasta
from zawody zw join skocznie s on s.id_skoczni = zw.id_skoczni
			   join miasta m on m.id_miasta = s.id_miasta

-- miasta -- skocznie --  zawody

select zw.nazwa, s.nazwa_skoczni, m.nazwa_miasta
from miasta m join skocznie s on s.id_miasta= m.id_miasta
			   join zawody zw on zw.id_skoczni = s.id_skoczni

-- 8 

select z.imie + ' ' + z.nazwisko, zw.nazwa
from zawody zw join skocznie s on s.id_skoczni = zw.id_skoczni
			   join zawodnicy z on z.kraj = s.kraj_skoczni

-- 9 

select *
from zawodnicy z join trenerzy t on z.data_ur > t.data_ur_t
									and z.id_trenera = t.id_trenera

-- 10 

select z1.imie + ' ' + z1.nazwisko + ' (' + format(z1.wzrost,'0') + ' cm) jest wy¿szy ni¿ ' +
	   z2.imie + ' ' + z2.nazwisko + ' (' + format(z2.wzrost,'0') + ' cm)' 
from zawodnicy z1 join zawodnicy z2 on z1.kraj = z2.kraj and z1.wzrost>z2.wzrost


-- wypisz trenerów i ich zawodników urodzonych w tym samym miesi¹cu 

select *
from zawodnicy z join trenerzy t on z.id_trenera = t.id_trenera
								and month(z.data_ur) = MONTH(t.data_ur_t)

--wypisz pary zawodnikow urodzonych tego samego dnia tygodnia 
-- dzieñ tygodnia mozesz znalezc uzywajac funkcji format(data,'ddd')

select z1.nazwisko, format(z1.data_ur,'dddd','pl'),  z2.nazwisko, format(z2.data_ur,'dddd','pl')
from zawodnicy z1 join zawodnicy z2 on format(z1.data_ur,'dddd') =format(z2.data_ur,'dddd') 
						         -- and z1.id_zawodnika <> z2.id_zawodnika
								  and z1.id_zawodnika > z2.id_zawodnika

--wypisz trenerów i miasta  jakie Ci trenerzy odwiedzili w swojej karierze 
-- trener trenuje zawodnikow, ktorzy uczestnicza w zawodach, te zawody odbywaja 
-- sie na pewnych skoczniach a te skocznie znajduja sie w pewnych miastach 

select distinct t.imie_t + ' ' + t.nazwisko_t + ' ' + m.nazwa_miasta
from trenerzy t join zawodnicy z on z.id_trenera = t.id_trenera
				join uczestnictwa u on u.id_zawodnika = z.id_zawodnika
				join zawody zw on zw.id_zawodow = u.id_zawodow
				join skocznie s on s.id_skoczni = zw.id_skoczni
				join miasta m on m.id_miasta = s.id_miasta


-- wypisz pary zawodników i posortuj ich zgodnie z ró¿nic¹ w BMI
-- czyli na górze bêd¹ pary zawodników o zblizonym BMI 


select z1.nazwisko, z1.waga/power(z1.wzrost/100.0,2) bmi1, 
	   z2.nazwisko, z2.waga/power(z2.wzrost/100.0,2) bmi2, 
	   abs(z1.waga/power(z1.wzrost/100.0,2)-z2.waga/power(z2.wzrost/100.0,2)) roznica
from zawodnicy z1, zawodnicy z2 
where z1.id_zawodnika > z2.id_zawodnika
order by roznica

select z1.nazwisko, z1.waga/power(z1.wzrost/100.0,2) bmi1, 
	   z2.nazwisko, z2.waga/power(z2.wzrost/100.0,2) bmi2, 
	   abs(z1.waga/power(z1.wzrost/100.0,2)-z2.waga/power(z2.wzrost/100.0,2)) roznica
from zawodnicy z1 join zawodnicy z2 on z1.id_zawodnika > z2.id_zawodnika
order by roznica


-- grupowanie danych 

select * from zawodnicy

select distinct kraj
from zawodnicy

select kraj, avg(wzrost), sum(wzrost), min(waga), count(wzrost), count(id_trenera), count(id_zawodnika),
		count(*)
from zawodnicy
group by kraj

-- jezeli grupuje po kolumnie X to tê kolumnê moge wysietliæ 
-- pozosta³e kolumny muszê zagregowaæ 

 -- str 31 

 --1 
 select kraj, count(id_zawodnika)
 from zawodnicy
 group by kraj

 --2 

 
 select kraj, max(wzrost)
 from zawodnicy
 group by kraj

 --3 

 select kraj, count(id_zawodnika)
 from zawodnicy 
 where wzrost > 180
 group by kraj

 -- 4 
 select kraj, avg(wzrost) sr
 from zawodnicy 
 group by kraj
 order by sr

 -- 5 

 select kraj, sum(iif(wzrost>180,1,0)) wys, sum(iif(wzrost<175,1,0)) nis
 from zawodnicy
 group by kraj

 select kraj, count(iif(wzrost>180,'x',null)) wys, count(iif(wzrost<175,'x',null)) nis
 from zawodnicy
 group by kraj


 select kraj, avg(wzrost)
 from zawodnicy
 group by rollup(kraj)

 select avg(wzrost) from zawodnicy


  -- dla kazdego zawodnika, wypisz pore roku w jakiej sie urodzil 
  -- pory roku ustal na podstawie numerów miesiecy :
  -- zima: 12,1,2 wisona: 3,4,5, lato: 6,7,8 jesien: 9,10,11

  select imie, nazwisko, 
	case
		when MONTH(data_ur) in (12,1,2) then 'zima'
		when MONTH(data_ur) in (3,4,5) then 'wisona'
		when MONTH(data_ur) in (6,7,8) then 'lato'
		when MONTH(data_ur) in (9,10,11) then 'jesien'
	end 
  from zawodnicy

  --sprawdz ilu zawodników urodzi³o siê w danej porze roku 

  select  
	case
		when MONTH(data_ur) in (12,1,2) then 'zima'
		when MONTH(data_ur) in (3,4,5) then 'wisona'
		when MONTH(data_ur) in (6,7,8) then 'lato'
		when MONTH(data_ur) in (9,10,11) then 'jesien'
	end [pora roku], count(id_zawodnika) ile
  from zawodnicy
  group by case
		when MONTH(data_ur) in (12,1,2) then 'zima'
		when MONTH(data_ur) in (3,4,5) then 'wisona'
		when MONTH(data_ur) in (6,7,8) then 'lato'
		when MONTH(data_ur) in (9,10,11) then 'jesien'
	end 

	-- a teraz dorzucimy groupowanie po kraju


  select kraj, 
	case
		when MONTH(data_ur) in (12,1,2) then 'zima'
		when MONTH(data_ur) in (3,4,5) then 'wisona'
		when MONTH(data_ur) in (6,7,8) then 'lato'
		when MONTH(data_ur) in (9,10,11) then 'jesien'
	end [pora roku], count(id_zawodnika) ile
  from zawodnicy
  group by cube( kraj, case
		when MONTH(data_ur) in (12,1,2) then 'zima'
		when MONTH(data_ur) in (3,4,5) then 'wisona'
		when MONTH(data_ur) in (6,7,8) then 'lato'
		when MONTH(data_ur) in (9,10,11) then 'jesien'
	end )


-- 1) podaj ilosci zawodnikow wyzszych niz 175 w poszczególnych krajach 

select kraj, count(id_zawodnika)
from zawodnicy 
where wzrost > 175
group by kraj

-- 2) podaj ilosci zawodnikow w poszczegolnych krajach, gdzie srednia wzrostu jest wyzsza niz 175 cm

select kraj, count(id_zawodnika)
from zawodnicy
--where wzrost > 175
group by kraj
having avg(wzrost)>175

-- where to filtorwanie PRZED grupowaniem. To filtorwanie dziala na poszczególnych rekordach
-- having to filtrowanie PO grupowaniu. To filtorwanie dziala na poszczegolnych grupach 

/* select, from, where , group by , having , order by */

--1) wypisz liste trenerów, wraz z informacj¹ ilu zawodników dany trener trenuje 

select t.imie_t + ' ' + t.nazwisko_t, COUNT(z.id_zawodnika) [ilu trenuje]
from trenerzy t left join zawodnicy z on z.id_trenera = t.id_trenera
group by t.imie_t + ' ' + t.nazwisko_t
order by [ilu trenuje] desc

--2) wypisz zawodnikow wraz z informacja ile razy startowali w zawodach

select z.imie + ' '+ z.nazwisko, COUNT(u.id_zawodnika)
from zawodnicy z join uczestnictwa u on z.id_zawodnika=u.id_zawodnika
group by z.imie, z.nazwisko

--3) wypisz tylko te miasta, w których startowa³o przynajmniej 5 zawodników

select m.nazwa_miasta, COUNT(u.id_zawodnika)
from  uczestnictwa u join zawody zw on zw.id_zawodow = u.id_zawodow
				 join skocznie s on s.id_skoczni = zw.id_skoczni
				 join miasta m on m.id_miasta = s.id_miasta
group by m.nazwa_miasta
having COUNT(u.id_zawodnika) > 4

--4) wypisz trenerow, którzy trenuj¹ przynajmniej 2 zawodników, których wzrost wynosi ponizej 175cm

select t.imie_t + ' '+ t.nazwisko_t, count(z.id_zawodnika)
from trenerzy t join zawodnicy z on z.id_trenera = t.id_trenera
where z.wzrost < 175 
group by t.id_trenera, t.imie_t, t.nazwisko_t
having count(z.id_zawodnika)>1

--5) zrób zestawienie w którym wyswietlisz dla kazdego kraju
		-- maksymalny punkt k skoczni oraz informacje jaki jest maksymalny 
		-- punkt k dla wszystkich krajów jednoczeœnie 
		-- nie uwzgledniaj pustych wierszy 
select * from skocznie	

select kraj_skoczni, max(k)
from skocznie 
where id_skoczni is not null
group by rollup(kraj_skoczni)

-- 6) sprawdz ile razy trener polakow odzwiedzi³ miasta, które nie zawieraj¹ litery 'o'

select t.imie_t + ' ' + t.nazwisko_t + ' ' + m.nazwa_miasta, count(zw.id_zawodow)
from trenerzy t join zawodnicy z on z.id_trenera = t.id_trenera
				join uczestnictwa u on u.id_zawodnika = z.id_zawodnika
				join zawody zw on zw.id_zawodow = u.id_zawodow
				join skocznie s on s.id_skoczni = zw.id_skoczni
				join miasta m on m.id_miasta = s.id_miasta
where m.nazwa_miasta not like '%o%' and z.kraj = 'pol'
group by t.id_trenera, t.imie_t, t.nazwisko_t,  m.nazwa_miasta


--7) podaj ile skoczni znajduje sie w danym miescie, miasta wyswietl bez cudzys³owów

select SUBSTRING(m.nazwa_miasta,2,len(m.nazwa_miasta)-2), count(s.id_skoczni)
from miasta m join skocznie s on m.id_miasta = s.id_miasta
group by m.nazwa_miasta

-- do tej pory poznaliœmy 
-- 1) join 2) group by 3) podzapytania 

select imie, nazwisko, w from
	(select imie, nazwisko, kraj, waga+1 w
	from zawodnicy) p
where w > 60


 -- stworz zapytanie, ktore wyswietla imie ,nazwisko i bmi
  -- przefiltruj dane po bmi > 20. (wykorzystaj podzapytania) 

select imie, nazwisko, bmi from
	(select imie, nazwisko, kraj, waga/power(wzrost/100.0,2) bmi
	from zawodnicy) p
where bmi > 20

-- podzapytanie zdefiniowalismy w sekcji FROM

-- mozemy takze zdefinowac podzapytanie w sekcji SELECT 

--np obok kazdego zawodnika, podaj jego wzrost oraz informacje o ile jego wzrost jest mniejszy
-- od masymlanego wzrostu wszystkich zawodnikow 

select max(wzrost) from zawodnicy

select imie, nazwisko, wzrost, (select max(wzrost) from zawodnicy) - wzrost roznica
from zawodnicy
order by roznica desc

-- mozemy takze definiowac w sekcji WHERE 
-- np: podaj zawodnikow tylko tych, którzy s¹ cie¿si od œredniej wagi wszystkich zawodników 


select avg(waga) from zawodnicy

select *, (select avg(waga) from zawodnicy) [srednia wartosc]
from zawodnicy
where waga > (select avg(waga) from zawodnicy)  

select * from
	(select *, (select avg(waga) from zawodnicy) sr
	from zawodnicy) t 
where waga > sr

-- 3 rodzaje podzapytania
-- 1) w sekcji from: w nawiasy i musze nadac alias 
-- 2) w sekcji select : w nawiasy i mozna podac alias ale nie zawsze 
-- 3) w sekcji where: w nawiasy i nie mozna podac aliasu

-- podzapytania mog¹ byæ u¿ywane obok operatorów: in, between 

-- podaj zawodnikow ktorych waga jest taka sama jak waga dowolnego polaka 

select * 
from zawodnicy
where waga in (select waga from zawodnicy where kraj = 'pol') and kraj <> 'pol'

-- podaj zawodnikow, ktorych waga jest wieksza od wszystkich Wag polakow

select *
from zawodnicy
where waga > all (select waga from zawodnicy where kraj = 'pol')

select *
from zawodnicy 
where waga > (select max(waga) from zawodnicy where kraj = 'pol')

-- podaj zawodnikow, ktorych waga jest wieksza od dowolnej wagi z polakow (przynajmniej jednej z)

select *
from zawodnicy
where waga > any (select waga from zawodnicy where kraj = 'pol') and kraj <> 'pol'

select *
from zawodnicy 
where waga > (select min(waga) from zawodnicy where kraj = 'pol')


-- rózny od:  <>   lub !=


-- str 37 
 

 --1 
 
 select top 1 * from zawodnicy order by wzrost desc

 select *
 from zawodnicy where wzrost = (select max(wzrost) from zawodnicy)

-- 2 
select *
from zawodnicy where wzrost > (select wzrost from zawodnicy where nazwisko = 'MA£YSZ')

--3 
select *
from zawodnicy where waga > (select waga from zawodnicy where nazwisko = 'MA£YSZ')

--4 
select * from zawodnicy
order by wzrost desc


select *
from zawodnicy where wzrost > 
	(select wzrost from zawodnicy where waga = (select max(waga) from zawodnicy ))

--5

select *
from zawodnicy where data_ur < (select data_ur from trenerzy where nazwisko = 'Kuttin')

--6 

select *
from zawodnicy
where wzrost = (select wzrost from zawodnicy where nazwisko = 'AHONEN')
  and nazwisko != 'AHONEN'

--7 

select *
from zawodnicy where waga >  (select avg(waga) from zawodnicy)


--8 
select *
from zawodnicy where waga >  (select avg(waga) from zawodnicy where kraj = 'pol')

-- 9 
-- rozw 1:
select imie, nazwisko, waga, sr
from zawodnicy z join
	(select kraj, avg(waga) sr
	from zawodnicy 
	group by kraj) t on z.kraj = t.kraj
where waga > sr

-- rozw 2: 

select imie, nazwisko, waga, sr
from
	(select *, (select avg(waga) from zawodnicy where kraj=z.kraj ) sr
	from zawodnicy z) t  
where waga> sr

-- 10 

select k.kraj, COUNT(z.id_zawodnika) 
from
	(select distinct kraj from zawodnicy) k left join zawodnicy z on z.kraj =k.kraj and z.wzrost>180
group by k.kraj

-- chcemy wyswietlic liste zawodnikow, którzy maj¹ przypisanego trenera 
-- uzyj exists oraz podzapytania skorelowanego 


select *
from zawodnicy z
where exists (select * from trenerzy t where t.id_trenera = z.id_trenera)


--  wypisz zawodniów, którzy startowali rzadziej ni¿ œrednia startów w ich dru¿ynie 


-- krok 1: 
 -- zeby policzyc srednia liczbe startow to potrzebujemy najpierw poznac 
 -- jaka jest suma startow w danej druzynie 


 select kraj, count(u.id_uczestnictwa) [liczbaStartow]
 from zawodnicy z join uczestnictwa u on z.id_zawodnika = u.id_zawodnika
 group by kraj

 -- krok 2: 
 -- potrzebujemy takze wiedziec ile jest zawodnikow w danej druznie 

 select kraj, count(id_zawodnika) [liczbaZawodnikow]
 from zawodnicy
 group by kraj

 -- krok 3: 
 -- teraz musimy polaczyc ze sob¹ te dwie tableki 

 select ls.kraj, ls.liczbaStartow, lz.liczbaZawodnikow, convert(decimal, ls.liczbaStartow)/lz.liczbaZawodnikow 
 from
	 (select kraj, count(u.id_uczestnictwa) [liczbaStartow]
	 from zawodnicy z join uczestnictwa u on z.id_zawodnika = u.id_zawodnika
	 group by kraj) ls
join
	 (select kraj, count(id_zawodnika) [liczbaZawodnikow]
	 from zawodnicy
	 group by kraj) lz
on ls.kraj = lz.kraj

-- teraz mamy policzona srednia liczbe startow dla danej druzyny 

-- krok 4:
-- teraz dla kazdego zawodnika musimy policzyc ile razy on startowal 

select z.imie + ' ' + z.nazwisko [zaw], z.kraj , count(u.id_uczestnictwa) [liczbaStartow]
from zawodnicy z join uczestnictwa u on z.id_zawodnika = u.id_zawodnika
group by z.id_zawodnika, z.imie, z.nazwisko, kraj

-- krok 5:

-- teraz ostatecznie laczymy obydwie tableki 

select *
from
	(select z.imie + ' ' + z.nazwisko [zaw], z.kraj , count(u.id_uczestnictwa) [liczbaStartow]
	from zawodnicy z join uczestnictwa u on z.id_zawodnika = u.id_zawodnika
	group by z.id_zawodnika, z.imie, z.nazwisko, kraj) t1
join
	(select ls.kraj, ls.liczbaStartow, lz.liczbaZawodnikow, convert(decimal, ls.liczbaStartow)/lz.liczbaZawodnikow [srls]
	 from
		 (select kraj, count(u.id_uczestnictwa) [liczbaStartow]
		 from zawodnicy z join uczestnictwa u on z.id_zawodnika = u.id_zawodnika
		 group by kraj) ls
	join
		 (select kraj, count(id_zawodnika) [liczbaZawodnikow]
		 from zawodnicy
		 group by kraj) lz
	on ls.kraj = lz.kraj) t2
on t1.kraj = t2.kraj
where t1.liczbaStartow< t2.srls

