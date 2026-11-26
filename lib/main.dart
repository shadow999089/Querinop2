import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String _supabaseUrl = 'https://itrlwbszlmjiyswgeent.supabase.co';
const String _supabaseAnonKey = 'sb_publishable_hRJSKVcGXfem9J0fa07Hgg_NS2iFVY-';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await Supabase.initialize(
  url: _supabaseUrl,
  publishableKey: _supabaseAnonKey,
);

  runApp(const MeuAppTrabalho());
}

class MeuAppTrabalho extends StatelessWidget {
  const MeuAppTrabalho({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabalho Final P2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF424242),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const TelaEspelho(),
    );
  }
}

class TelaEspelho extends StatelessWidget {
  const TelaEspelho({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1. Reflexão no Espelho')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 260,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF9E9E9E), width: 2),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.smart_toy,
                      size: 65,
                      color: Color(0xFF424242),
                    ),
                    SizedBox(width: 12),
                    Icon(
                      Icons.compare_arrows,
                      size: 30,
                      color: Color(0xFF757575),
                    ),
                    SizedBox(width: 12),
                    Icon(
                      Icons.smart_toy_outlined,
                      size: 65,
                      color: Color(0xFF757575),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'A Grande Preparação',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Representando todas as IAs, Gemini encara seu próprio reflexo no espelho antes do grande confronto.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF616161)),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF424242),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TelaCorredor(),
                    ),
                  );
                },
                child: const Text('Ir para o Rinque ->'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaCorredor extends StatelessWidget {
  const TelaCorredor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. Caminho da Arena')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 260,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF9E9E9E), width: 2),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_walk,
                      size: 75,
                      color: Color(0xFF424242),
                    ),
                    SizedBox(height: 8),
                    Icon(Icons.stadium, size: 40, color: Color(0xFF757575)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Rumo ao Rinque',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Caminhando pelo corredor frio e escuro, Gemini pensa: tenho que vencer. As IAs são melhores que os cérebros; vencendo, iremos deixá-los mais dependentes.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF616161)),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF424242),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TelaQuedaDeBraco(),
                    ),
                  );
                },
                child: const Text('Iniciar Confronto ->'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaQuedaDeBraco extends StatefulWidget {
  const TelaQuedaDeBraco({super.key});

  @override
  State<TelaQuedaDeBraco> createState() => _TelaQuedaDeBracoState();
}

class _TelaQuedaDeBracoState extends State<TelaQuedaDeBraco> {
  final SupabaseClient _supabase = Supabase.instance.client;
  final TextEditingController _comentarioController = TextEditingController();
  final List<String> _comentarios = [];
  bool _carregando = true;
  bool _enviando = false;

  @override
  void initState() {
    super.initState();
    _carregarComentarios();
  }

  Future<void> _carregarComentarios() async {
    try {
      final response = await _supabase
          .from('comentarios')
          .select('texto')
          .order('id', ascending: true);

      final lista = (response as List)
          .map((item) => item['texto'].toString())
          .toList();

      if (!mounted) return;
      setState(() {
        _comentarios
          ..clear()
          ..addAll(lista);
        _carregando = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _carregando = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar comentários: $e')),
      );
    }
  }

  Future<void> _adicionarComentario() async {
    final texto = _comentarioController.text.trim();
    if (texto.isEmpty || _enviando) return;

    setState(() {
      _enviando = true;
    });

    try {
      await _supabase.from('comentarios').insert({'texto': texto});

      if (!mounted) return;
      _comentarioController.clear();
      await _carregarComentarios();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar comentário: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _enviando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3. O Grande Duelo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 190,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF9E9E9E), width: 2),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.smart_toy, size: 60, color: Color(0xFF424242)),
                  SizedBox(width: 16),
                  Icon(Icons.handshake, size: 45, color: Color(0xFF212121)),
                  SizedBox(width: 16),
                  Icon(Icons.psychology, size: 60, color: Color(0xFF424242)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Gemini vs. Cérebro de Einstein',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Quem vence essa queda de braço que decidirá o destino da humanidade? Mostre qual é o seu apoio abaixo:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _comentarioController,
                    onSubmitted: (_) => _adicionarComentario(),
                    decoration: const InputDecoration(
                      hintText: 'Escreva um comentário...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF424242),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  onPressed: _enviando ? null : _adicionarComentario,
                  child: _enviando
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Enviar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Comentários:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF424242),
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (_carregando)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CircularProgressIndicator(color: Color(0xFF424242)),
              )
            else if (_comentarios.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Nenhum comentário ainda. Seja o primeiro a apoiar!',
                  style: TextStyle(color: Color(0xFF616161)),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _comentarios.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    elevation: 1,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: const Icon(
                        Icons.person_outline,
                        color: Color(0xFF616161),
                      ),
                      title: Text(
                        _comentarios[index],
                        style: const TextStyle(color: Color(0xFF212121)),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}