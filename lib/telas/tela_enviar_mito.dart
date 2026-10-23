import 'package:flutter/material.dart';

class TelaEnviarMito extends StatefulWidget {
  const TelaEnviarMito({super.key});

  @override
  State<TelaEnviarMito> createState() => _TelaEnviarMitoState();
}

class _TelaEnviarMitoState extends State<TelaEnviarMito> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _afirmacaoController = TextEditingController();

  String? _categoria;
  bool _receberResposta = true;
  // depois da primeira tentativa os erros vao sumindo enquanto digita
  bool _jaTentouEnviar = false;

  final List<String> categorias = [
    'Acidentes',
    'Medicina',
    'Energia',
    'Armas nucleares',
    'Outro',
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _afirmacaoController.dispose();
    super.dispose();
  }

  String? _validarNome(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Digite seu nome';
    }
    if (valor.trim().length < 3) {
      return 'Nome muito curto';
    }
    return null;
  }

  String? _validarEmail(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Digite seu e-mail';
    }
    final regex = RegExp(r'^[\w.\-]+@[\w\-]+\.[\w.]+$');
    if (!regex.hasMatch(valor.trim())) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? _validarAfirmacao(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Escreva o que você ouviu';
    }
    if (valor.trim().length < 10) {
      return 'Escreve um pouco mais (mínimo 10 letras)';
    }
    return null;
  }

  void _enviar() {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _jaTentouEnviar = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tem campo errado, confere ai')),
      );
      return;
    }

    final nome = _nomeController.text.trim().split(' ').first;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enviado!'),
          content: Text(
            'Valeu, $nome! A gente vai pesquisar se isso é mito ou verdade'
            '${_receberResposta ? ' e te manda a resposta por e-mail.' : '.'}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // fecha o dialog
                Navigator.pop(this.context); // volta pra lista
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar um mito'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: _jaTentouEnviar
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ouviu alguma coisa sobre energia nuclear e não sabe se é verdade? Manda pra gente!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: _validarNome,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: _validarEmail,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _categoria,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: categorias
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (valor) {
                  setState(() {
                    _categoria = valor;
                  });
                },
                validator: (valor) {
                  if (valor == null) {
                    return 'Escolha uma categoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _afirmacaoController,
                maxLines: 4,
                maxLength: 300,
                decoration: const InputDecoration(
                  labelText: 'O que você ouviu?',
                  hintText: 'Ex: quem mora perto de usina fica radioativo',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: _validarAfirmacao,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Quero receber a resposta por e-mail'),
                value: _receberResposta,
                onChanged: (valor) {
                  setState(() {
                    _receberResposta = valor;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _enviar,
                icon: const Icon(Icons.send),
                label: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
