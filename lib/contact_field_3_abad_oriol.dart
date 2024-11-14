import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>(); // Clave para el formulario
  bool _isFormValid = false; // Estado para controlar la validez del formulario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Upload Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Campo de Email con validador de formato de email
              FormBuilderTextField(
                name: 'email',
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email, color: Colors.blue),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.blue.shade200),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
                onChanged: (value) => _updateFormValidity(),
              ),
              const SizedBox(height: 20),
              // Campo de Dirección con validador de texto
              FormBuilderTextField(
                name: 'address',
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.home, color: Colors.blue),
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.blue.shade200),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                onChanged: (value) => _updateFormValidity(),
              ),
              const SizedBox(height: 20),
              // Campo de Teléfono Móvil con validador de números
              FormBuilderTextField(
                name: 'mobile_no',
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone, color: Colors.blue),
                  labelText: 'Mobile No',
                  labelStyle: TextStyle(color: Colors.blue.shade200),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
                onChanged: (value) => _updateFormValidity(),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    // Si el formulario es válido, puedes proceder con la acción.
                    print(_formKey.currentState?.value);
                  } else {
                    // Si no es válido, muestra un mensaje de error.
                    print('Formulario no válido');
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Done'),
                    if (_isFormValid) ...[
                      const SizedBox(width: 10),
                      Icon(Icons.check_circle, color: Colors.green),
                    ] else ...[
                      const SizedBox(width: 10),
                      Icon(Icons.cancel, color: Colors.red),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para verificar si el formulario es válido y actualizar el estado
  void _updateFormValidity() {
    setState(() {
      _isFormValid = _formKey.currentState?.saveAndValidate() ?? false;
    });
  }
}
