import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormA - Abad Oriol',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
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

class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulari Exemple"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: <Widget>[
              FormTitle(title: 'Formulari de Registre'),
              FormLabelGroup(label: 'Gènere'),
              FormBuilderRadioGroup<String>(
                name: 'gender',
                decoration: InputDecoration(labelText: 'Selecciona el gènere'),
                options: [
                  FormBuilderFieldOption(value: 'Masculí'),
                  FormBuilderFieldOption(value: 'Femení'),
                ],
              ),
              FormLabelGroup(label: 'Nom'),
              FormBuilderTextField(
                name: 'name',
                decoration: InputDecoration(
                  labelText: 'Escriu el teu nom',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                ),
              ),
              FormLabelGroup(label: 'Aficions'),
              FormBuilderCheckboxGroup(
                name: 'hobbies',
                decoration: InputDecoration(labelText: 'Selecciona aficions'),
                options: [
                  FormBuilderFieldOption(value: 'Lectura'),
                  FormBuilderFieldOption(value: 'Esports'),
                  FormBuilderFieldOption(value: 'Música'),
                ],
              ),
              FormLabelGroup(label: 'Ciutat'),
              FormBuilderDropdown<String>(
                name: 'city',
                decoration: InputDecoration(labelText: 'Selecciona la ciutat'),
                items: [
                  DropdownMenuItem(value: 'Barcelona', child: Text('Barcelona')),
                  DropdownMenuItem(value: 'Madrid', child: Text('Madrid')),
                  DropdownMenuItem(value: 'Valencia', child: Text('Valencia')),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            final formValues = _formKey.currentState?.value;
            final String gender = formValues?['gender'] ?? '';
            final String name = formValues?['name'] ?? '';
            final List<String> hobbies =
                List<String>.from(formValues?['hobbies'] ?? []);
            final String city = formValues?['city'] ?? '';

            String summary = 'Resumen de las opciones seleccionadas:\n';
            summary += 'Gènere: $gender\n';
            summary += 'Nom: $name\n';
            summary += 'Aficions: ${hobbies.join(', ')}\n';
            summary += 'Ciutat: $city';

            alertDialog(context, summary);
          } else {
            print("Validació fallida");
            alertDialog(context, "Error en la validación.");
          }
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.send), // Puedes cambiar el color del botón
      ),
    );
  }
}

void alertDialog(BuildContext context, String contentText) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Formulari enviat!"),
      icon: const Icon(Icons.check_circle),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

class FormLabelGroup extends StatelessWidget {
  final String label;
  const FormLabelGroup({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FormTitle extends StatelessWidget {
  final String title;
  const FormTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
