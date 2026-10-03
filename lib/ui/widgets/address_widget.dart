import 'package:flutter/material.dart';
import 'package:flutter_cep/models/cep_model.dart';

class AddressWidget extends StatelessWidget {
  final CepModel? cepModel;

  const AddressWidget({super.key, this.cepModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (cepModel == null) {
      return SizedBox.shrink();
    }

    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'CEP encontrado!',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Informações do CEP!',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _InfoCard(
          icon: Icons.pin_drop,
          title: 'CEP',
          subtitle: cepModel!.cep,
          color: Colors.red,
        ),
        _InfoCard(
          icon: Icons.signpost,
          title: 'Logradouro',
          subtitle: cepModel!.logradouro,
          color: Colors.blue,
        ),
        _InfoCard(
          icon: Icons.home_work,
          title: 'Bairro',
          subtitle: cepModel!.bairro,
          color: Colors.green,
        ),
        _InfoCard(
          icon: Icons.location_city,
          title: 'Cidade',
          subtitle: cepModel!.localidade,
          color: Colors.orange,
        ),
        _InfoCard(
          icon: Icons.map,
          title: 'Estado',
          subtitle: '${cepModel!.estado} (${cepModel!.uf})',
          color: Colors.purple,
        ),
        _InfoCard(
          icon: Icons.public,
          title: 'Região',
          subtitle: cepModel!.regiao,
          color: Colors.teal,
        ),
        _InfoCard(
          icon: Icons.phone,
          title: 'DDD',
          subtitle: cepModel!.ddd,
          color: Colors.indigo,
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
