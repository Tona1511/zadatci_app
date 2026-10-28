import 'package:flutter/material.dart';

import 'forma_ekran.dart';
import 'repozitorij.dart';
import 'zadatak.dart';

void main() => runApp(const MojaAplikacija());

class MojaAplikacija extends StatelessWidget {
  const MojaAplikacija({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moji zadatci',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ZadatciZaslon(),
    );
  }
}

class ZadatciZaslon extends StatefulWidget {
  const ZadatciZaslon({super.key});

  @override
  State<ZadatciZaslon> createState() => _ZadatciZaslonState();
}

class _ZadatciZaslonState extends State<ZadatciZaslon> {
  final ZadatakRepozitorij _repo = ZadatakRepozitorij(
    neuspjeha: 0,
    prazno: false,
  );

  bool _ucitava = true;
  String? _pogreska;
  List<Zadatak> _zadatci = [];

  @override
  void initState() {
    super.initState();
    _dohvatiZadatke();
  }

  // Dohvaćanje zadataka iz repozitorija.
  Future<void> _dohvatiZadatke() async {
    setState(() {
      _ucitava = true;
      _pogreska = null;
    });

    try {
      final rezultat = await _repo.dohvati();

      if (!mounted) return;

      setState(() {
        _zadatci = rezultat;
        _ucitava = false;
      });
    } on ZadatciException catch (e) {
      if (!mounted) return;

      setState(() {
        _pogreska = e.poruka;
        _ucitava = false;
      });
    }
  }

  // Otvaranje forme i dodavanje novog zadatka.
  Future<void> _dodaj() async {
    final novi = await Navigator.push<Zadatak>(
      context,
      MaterialPageRoute(builder: (_) => FormaEkran(postojeci: _zadatci)),
    );

    // Ako je korisnik odustao ili zaslon više ne postoji.
    if (!mounted || novi == null) return;

    setState(() {
      _zadatci.add(novi);
    });

    // Potvrda uspješnog dodavanja.
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Dodano: ${novi.naslov}')));
  }

  @override
  Widget build(BuildContext context) {
    Widget sadrzaj;

    // Stanje učitavanja.
    if (_ucitava) {
      sadrzaj = const Center(child: CircularProgressIndicator());

      // Stanje pogreške.
    } else if (_pogreska != null) {
      sadrzaj = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Došlo je do pogreške pri dohvaćanju zadataka. '
              'Pokušajte ponovno.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _dohvatiZadatke,
              child: const Text('Pokušaj ponovno'),
            ),
          ],
        ),
      );

      // Prazan popis.
    } else if (_zadatci.isEmpty) {
      sadrzaj = const Center(child: Text('Nema zadataka.'));

      // Prikaz zadataka.
    } else {
      final brojZavrsenih = _zadatci.where((zadatak) => zadatak.zavrsen).length;

      sadrzaj = Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Završeno: $brojZavrsenih od ${_zadatci.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _dohvatiZadatke,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _zadatci.length,
                itemBuilder: (context, index) {
                  final zadatak = _zadatci[index];

                  return ListTile(
                    leading: Icon(
                      zadatak.zavrsen
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                    ),
                    title: Text(zadatak.naslov),
                    subtitle: Text(zadatak.zavrsen ? 'Gotovo' : 'U tijeku'),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Moji zadatci')),
      floatingActionButton: FloatingActionButton(
        onPressed: _dodaj,
        tooltip: 'Novi zadatak',
        child: const Icon(Icons.add),
      ),
      body: sadrzaj,
    );
  }
}
