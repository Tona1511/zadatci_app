# Vježba 2 – Asinkroni dohvat podataka

## Podaci o studentu

**Ime i prezime:** Antonio Dujmović  
**Projekt:** zadatci_app  
**Grana:** vjezba-02  
**Operacijski sustav:** Windows 11  
**Razvojno okruženje:** Visual Studio Code, Android Studio  
**Uređaj za testiranje:** Android Emulator Pixel 6

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

---

# Vježba 3 – Forma i popis (mini zadatak M1)

## Osnovni podaci

- **Projekt:** zadatci_app
- **Grana:** vjezba-03
- **Razvojno okruženje:** Visual Studio Code, Flutter i Dart
- **Uređaj za testiranje:** Android Emulator Pixel 6

## Opis vježbe

U Vježbi 3 proširio sam postojeću Flutter aplikaciju za prikaz zadataka. Dodao sam mogućnost unosa novih zadataka pomoću zasebnog zaslona s formom.

Korisnik pritiskom na gumb + otvara zaslon „Novi zadatak”, unosi naslov, može označiti zadatak kao završen i spremiti ga.

## Implementirane funkcionalnosti

- Dodan FloatingActionButton za otvaranje forme.
- Izrađena datoteka `lib/forma_ekran.dart`.
- Dodan obrazac Form s poljem TextFormField.
- Implementirana validacija praznog naslova i naslova kraćeg od tri znaka.
- Dodana opcija „Već završen” pomoću CheckboxListTile.
- Implementirana navigacija pomoću Navigator.push i Navigator.pop.
- Nakon spremanja novi zadatak prikazuje se na popisu.
- Dodana SnackBar potvrda o uspješnom spremanju.
- Zadržane su funkcionalnosti iz Vježbe 2.

## Objašnjenje važnih dijelova koda

**Form i GlobalKey**

Form povezuje polja za unos, a GlobalKey<FormState> omogućuje pokretanje provjere unosa pozivom metode `validate()`.

**Validacija naslova**

Metoda `_provjeriNaslov()` uklanja razmake na početku i kraju teksta pomoću `trim()`. Ako je naslov prazan, vraća poruku „Unesite naslov”. Ako ima manje od tri znaka, vraća poruku „Naslov mora imati najmanje 3 znaka”. Za ispravan unos vraća `null`.

**Navigator.push i Navigator.pop**

`Navigator.push()` otvara novi zaslon s formom. Nakon uspješnog spremanja `Navigator.pop(context, zadatak)` zatvara formu i vraća novi objekt Zadatak prethodnom zaslonu.

**Provjera mounted**

Nakon povratka s forme provjerava se `mounted` kako aplikacija ne bi pokušala pozvati `setState()` ako je zaslon u međuvremenu uklonjen.

**SnackBar**

ScaffoldMessenger prikazuje kratku potvrdu „Dodano” nakon uspješnog spremanja zadatka.

## Testiranje

Uspješno sam provjerio sljedeće slučajeve:

1. Gumb + otvara novi zaslon.
2. Prazan naslov prikazuje poruku „Unesite naslov”.
3. Naslov od dva znaka prikazuje poruku „Naslov mora imati najmanje 3 znaka”.
4. Ispravan naslov omogućuje spremanje.
5. Novi zadatak pojavljuje se na popisu.
6. Nakon spremanja prikazuje se SnackBar potvrda.

Statička analiza pokrenuta je naredbom `flutter analyze` i završila je bez pronađenih problema.

## Dokazi

U mapi `dokazi` nalaze se snimke zaslona:

- `vjezba3_popis.png`
- `vjezba3_forma.png`
- `vjezba3_validacija.png`

## Zaključak

U Vježbi 3 naučio sam izraditi Flutter formu, provjeravati korisnički unos, otvarati i zatvarati zaslone pomoću Navigatora te ažurirati popis zadataka nakon spremanja. Također sam naučio prikazati korisniku potvrdu uspješne radnje pomoću SnackBara.
