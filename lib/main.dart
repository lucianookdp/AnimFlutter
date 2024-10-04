import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Widget principal que inicializa o app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exemplos de Animação',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 85, 60, 40), // Cor marrom principal
        scaffoldBackgroundColor: const Color.fromARGB(255, 243, 236, 218), // Fundo claro
      ),
      home: const ExemplosAnimacao(),
    );
  }
}

// Tela que contém as animações
class ExemplosAnimacao extends StatefulWidget {
  const ExemplosAnimacao({super.key});

  @override
  _ExemplosAnimacaoState createState() => _ExemplosAnimacaoState();
}

class _ExemplosAnimacaoState extends State<ExemplosAnimacao> {
  // Variáveis e listas para controlar as animações

  // Controle do AnimatedSwitcher (Mandamentos)
  int _currentVerseIndex = 0;
  final List<String> _verses = [
    "Amar a Deus sobre todas as coisas.",
    "Não tomar o Seu santo Nome em vão.",
    "Guardar os domingos e dias santos.",
    "Honrar pai e mãe.",
    "Não matar.",
    "Não pecar contra a castidade.",
    "Não furtar.",
    "Não levantar falso testemunho.",
    "Não desejar a mulher do próximo.",
    "Não cobiçar as coisas alheias.",
  ];

  // Controle do AnimatedCrossFade (Carros)
  bool _mostrarPrimeiro = true;

  // Controle do AnimatedAlign (Mover Botão)
  int _posicaoAlign = 0; // 0: topo esquerdo, 1: centro, 2: canto inferior direito

  // Função para alternar o texto do AnimatedSwitcher
  void _toggleText() {
    setState(() {
      _currentVerseIndex = (_currentVerseIndex + 1) % _verses.length;
    });
  }

  // Função para alternar os widgets no AnimatedCrossFade
  void _alternarCrossFade() {
    setState(() {
      _mostrarPrimeiro = !_mostrarPrimeiro;
    });
  }

  // Função para mover o botão no AnimatedAlign
  void _alternarPosicaoAlign() {
    setState(() {
      _posicaoAlign = (_posicaoAlign + 1) % 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplos de Animação'),
        backgroundColor: const Color.fromARGB(255, 85, 60, 40), // Cor marrom escura
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              // ANIMAÇÃO 1: AnimatedSwitcher (Alterna entre textos dos mandamentos)
              const Text(
                'Exemplo de AnimatedSwitcher',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Contêiner com fundo amarelado e borda dourada
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 250, 229, 189),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color.fromARGB(255, 177, 142, 96),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4), // Sombra suave
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Exibe o texto do mandamento com animação de fade e escala
                    AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      child: Text(
                        _verses[_currentVerseIndex],
                        key: ValueKey<int>(_currentVerseIndex),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 85, 60, 40), // Texto marrom escuro
                        ),
                        textAlign: TextAlign.center,
                      ),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _toggleText,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        backgroundColor: const Color.fromARGB(255, 150, 111, 73), // Botão marrom médio
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Próximo Mandamento'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              
              // ANIMAÇÃO 2: AnimatedCrossFade (Alterna entre dois carros: Porsche e Ferrari)
              const Text(
                'Exemplo de AnimatedCrossFade',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Contêiner com fundo neutro e sombra leve
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 235, 222, 205),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 85, 60, 40).withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4), // Sombra leve
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Animação que alterna entre Porsche e Ferrari
                    AnimatedCrossFade(
                      firstChild: _buildFirstCar(),
                      secondChild: _buildSecondCar(),
                      crossFadeState: _mostrarPrimeiro
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(seconds: 1),
                      sizeCurve: Curves.easeInOutCubic,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _alternarCrossFade,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 150, 111, 73), // Botão marrom médio
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                        ),
                      ),
                      child: const Text(
                        'Alternar Carro',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // ANIMAÇÃO 3: AnimatedAlign (Botão que se move entre posições)
              const Text(
                'Exemplo de AnimatedAlign',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Contêiner com gradiente suave e sombra
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color.fromARGB(255, 230, 210, 170), Color.fromARGB(255, 190, 160, 120)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4), // Sombra
                    ),
                  ],
                ),
                height: 200,
                child: Stack(
                  children: [
                    // Botão que se move entre 3 posições diferentes
                    AnimatedAlign(
                      alignment: _posicaoAlign == 0
                          ? Alignment.topLeft
                          : _posicaoAlign == 1
                              ? Alignment.center
                              : Alignment.bottomRight,
                      duration: const Duration(seconds: 1),
                      child: ElevatedButton(
                        onPressed: _alternarPosicaoAlign,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 85, 60, 40), // Botão marrom escuro
                          padding: const EdgeInsets.all(10),
                        ),
                        child: const Text('Mover!', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Primeiro Widget (Porsche) do AnimatedCrossFade
  Widget _buildFirstCar() {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 230, 201, 147), Color.fromARGB(255, 216, 207, 166)], // Gradiente dourado claro
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 116, 86, 23).withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 3), // Sombra leve
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'Porsche',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }

  // Segundo Widget (Ferrari) do AnimatedCrossFade
  Widget _buildSecondCar() {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 177, 142, 96), Color.fromARGB(255, 116, 86, 23)], // Gradiente marrom dourado
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 116, 86, 23).withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 3), // Sombra leve
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'Ferrari',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}