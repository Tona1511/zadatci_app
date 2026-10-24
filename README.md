# Vježba 2 – Asinkroni dohvat podataka

## Podaci o studentu

**Ime i prezime:** Antonio Dujmović  
**Projekt:** zadatci_app  
**Grana:** vjezba-02  
**Operacijski sustav:** Windows 11  
**Razvojno okruženje:** Visual Studio Code, Android Studio  
**Uređaj za testiranje:** Android Emulator Pixel 6

## Verzije alata

## Verzije alata

- Flutter: 3.47.7 (stable)
- Dart: 3.13.5
- DevTools: 2.60.0

## Opis projekta

U ovoj vježbi izrađena je Flutter aplikacija za prikaz popisa zadataka. Aplikacija koristi model Zadatak, pretvara JSON podatke u Dart objekte te simulira asinkroni dohvat podataka pomoću Future.delayed.

Aplikacija prikazuje četiri stanja: učitavanje, uspješan dohvat zadataka, pogrešku s mogućnošću ponovnog pokušaja i prazan popis.

## Provedene izmjene

- Izrađen model Zadatak s metodama fromJson, toJson i kopiraj.
- Izrađen repozitorij za simulaciju asinkronog dohvata podataka.
- Dodana obrada pogrešaka i mogućnost ponovnog pokušaja.
- Izrađen Flutter zaslon s popisom zadataka.
- Dodana razumljiva poruka pogreške na hrvatskom jeziku.
- Dodan prikaz broja završenih zadataka.
- Dodan RefreshIndicator za osvježavanje popisa povlačenjem prema dolje.

## Provjera razumijevanja 1 – Model Zadatak

Polja modela označena su kao final kako se njihove vrijednosti ne bi mijenjale nakon stvaranja objekta. Metoda kopiraj vraća novi objekt s odabranim izmjenama, dok postojeći objekt ostaje nepromijenjen.

Ako u JSON-u nedostaje polje zavrsen, operator ?? postavlja zadanu vrijednost false.

Ako je polje naslov null, izraz `json['naslov'] as String` izaziva pogrešku jer se null ne može pretvoriti u nenullabilni String.

## Provjera razumijevanja 2 – Future i iznimke

Future predstavlja rezultat asinkrone operacije koji će biti dostupan u budućnosti.

Future.delayed simulira mrežno kašnjenje prije vraćanja podataka.

Ako se iznimka iz Futurea ne obradi, asinkrona operacija završava pogreškom koja se može prikazati kao neobrađena iznimka.

U aplikaciji se pogreške obrađuju kako bi korisnik dobio razumljivu poruku i mogućnost ponovnog pokušaja.

## Provjera razumijevanja 3 – FutureBuilder

Future se stvara izvan metode build kako se dohvat podataka ne bi ponovno pokretao pri svakom ponovnom iscrtavanju zaslona.

Tri osnovna stanja prikaza podataka su:

1. Učitavanje – prikazuje se indikator učitavanja.
2. Pogreška – prikazuje se poruka pogreške i gumb Pokušaj ponovno.
3. Uspjeh – prikazuje se popis zadataka ili poruka Nema zadataka ako je popis prazan.

## Pokretanje i provjera

Pokretanje aplikacije:

`flutter run`

Provjera modela:

`dart run bin/model_provjera.dart`

Provjera repozitorija:

`dart run bin/repozitorij_provjera.dart`

Statička analiza:

`flutter analyze`

## Zaključak

U ovoj vježbi naučio sam koristiti Dart modele, JSON serijalizaciju, asinkrono programiranje i prikaz različitih stanja u Flutter aplikaciji. Uspješno sam testirao prikaz zadataka, obradu pogreške, prazan popis i osvježavanje podataka.