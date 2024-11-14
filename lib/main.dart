import 'package:flutter/material.dart';
import 'contact_field_abad_oriol.dart'; // Primera pantalla del asistente
import 'contact_field_2_abad_oriol.dart'; // Segunda pantalla del asistente
import 'contact_field_3_abad_oriol.dart'; // Tercera pantalla del asistente

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asistent',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // Pantalla inicial azul
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a la siguiente pantalla al hacer click
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WizardScreen()),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'M08',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'B',
                style: TextStyle(
                  fontSize: 150,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Form',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WizardScreen extends StatefulWidget {
  const WizardScreen({super.key});

  @override
  State<WizardScreen> createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      setState(() => _currentPage++);
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _submitForm();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _submitForm() {
    // Acción final cuando se presiona "FINALIZAR"
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Completat"),
        content: const Text("Formulari enviat!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
            },
            child: const Text("Tancar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salesians Sarrià 24/25'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Column(
        children: [
          // Barra de progreso que indica la sección actual
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProgressIndicator("Pers.", 0),
                _buildProgressIndicator("Contact", 1),
                _buildProgressIndicator("Upload", 2),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                ContactField(),
                ContactScreen(),
                UploadScreen(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  ElevatedButton(
                    onPressed: _previousPage,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text('ENRERE'),
                  ),
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(_currentPage == 2 ? 'FINALITZAR' : 'CONTINUAR'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(String label, int pageIndex) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: _currentPage == pageIndex ? Colors.blue : Colors.grey,
          child: Text('${pageIndex + 1}', style: const TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: _currentPage == pageIndex ? Colors.blue : Colors.grey),
        ),
      ],
    );
  }
}
