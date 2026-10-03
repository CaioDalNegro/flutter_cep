import 'package:flutter/material.dart';
import 'package:flutter_cep/models/cep_model.dart';
import 'package:flutter_cep/repositories/cep_repository.dart';
import 'package:flutter_cep/ui/widgets/address_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final respoository = CepRepository(client: http.Client());
  final cepController = TextEditingController();
  String? errorMessage;
  CepModel? cepModel;

  Future<void> buscarCep() async {
    setState(() {
      errorMessage = null;
      cepModel = null;
    });
    final cep = cepController.text.trim();

    if (cep.isEmpty) {
      setState(() {
        errorMessage = 'Por favor, digite um CEP.';
      });
      return;
    }

    try {
      final addressModel = await respoository.consultarCep(cep);
      setState(() {
        errorMessage = null;
        cepModel = addressModel;
      });
    } on CepException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } catch (_) {
      setState(() {
        errorMessage = 'Erro ao consultar CEP.';
      });
    }
  }

  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP'),
        leading: Icon(Icons.location_city),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 24,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.1),
                    theme.colorScheme.secondary.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                spacing: 4,
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  Text(
                    'Busque por qualquer CEP',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Digite o CEP e descubra o enedereço completo',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              maxLength: 9,
              decoration: InputDecoration(
                labelText: 'CEP',
                hintText: 'Digite o CEP (ex: 12345-678)',
                prefixIcon: Icon(Icons.location_on_rounded),
                counterText: '',
              ),
            ),
            AnimatedSwitcher(
              duration: Duration.zero,
              child: ElevatedButton.icon(
                onPressed: buscarCep,
                icon: const Icon(Icons.search_rounded),
                label: Text('Buscar CEP'),
              ),
            ),
            Visibility(
              visible: errorMessage != null,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: theme.colorScheme.error,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Text(
                      errorMessage ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: cepModel != null,
              child: AddressWidget(
                cepModel: cepModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
