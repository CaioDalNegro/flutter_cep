# Flutter CEP

Aplicativo Flutter para consulta de endereços a partir do CEP, utilizando a API pública do [ViaCEP](https://viacep.com.br/).

## Sobre o projeto

Este projeto foi desenvolvido durante o curso de imersão **Flutter Experience | App Flutter completo em 5 dias**, conduzido por **Rodrigo Rahman**.

## Funcionalidades

- Busca de endereço pelo CEP
- Exibição de logradouro, bairro, cidade, estado, região e DDD
- Tema personalizado

## Tecnologias

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [http](https://pub.dev/packages/http)
- [ViaCEP](https://viacep.com.br/)

## Estrutura

```
lib/
├── core/theme/       # Tema do app
├── models/           # Modelo de dados (CepModel)
├── repositories/     # Comunicação com a API ViaCEP
├── ui/               # Telas e widgets
└── main.dart
```

## Como executar

```bash
git clone <url-do-repositorio>
cd flutter_cep
flutter pub get
flutter run
```
