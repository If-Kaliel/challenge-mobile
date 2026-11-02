import 'package:flutter/material.dart';

import '../models/mito_enviado.dart';
import '../tema.dart';

class TelaEnviarMito extends StatefulWidget {
  // a lista vem de fora pra nao sumir quando sai dessa tela
  final List<MitoEnviado> mitosEnviados;

  const TelaEnviarMito({super.key, required this.mitosEnviados});

  @override
  State<TelaEnviarMito> createState() => _TelaEnviarMitoState();
}

class _TelaEnviarMitoState extends State<TelaEnviarMito> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _afirmacaoController = TextEditingController();

  String? _categoria;
  bool _mostrarNome = true;
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

    final mito = MitoEnviado(
      autor: _mostrarNome ? _nomeController.text.trim() : 'Anônimo',
      categoria: _categoria!,
      afirmacao: _afirmacaoController.text.trim(),
    );

    // o reset chama o onChanged do dropdown com o valor antigo,
    // por isso limpa a categoria so depois dele
    _formKey.currentState!.reset();
    setState(() {
      widget.mitosEnviados.insert(0, mito);
      _categoria = null;
      _jaTentouEnviar = false;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enviado!'),
          content: Text('Valeu, $nome! Seu mito entrou na lista de enviados.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _remover(MitoEnviado mito) {
    setState(() {
      widget.mitosEnviados.remove(mito);
    });
  }

  Widget _cardMito(MitoEnviado mito) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.chat_bubble_outline, color: Cores.amarelo),
        title: Text(mito.afirmacao),
        subtitle: Text('${mito.categoria} - ${mito.autor}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          tooltip: 'Remover',
          onPressed: () => _remover(mito),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar um mito')),
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
                'Ouviu alguma coisa sobre energia nuclear e não sabe se é verdade? Anota aqui pra não esquecer!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
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
                  prefixIcon: Icon(Icons.email),
                ),
                validator: _validarEmail,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _categoria,
                // sem isso estoura em celular pequeno
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
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
                  alignLabelWithHint: true,
                ),
                validator: _validarAfirmacao,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Mostrar meu nome na lista'),
                value: _mostrarNome,
                onChanged: (valor) {
                  setState(() {
                    _mostrarNome = valor;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _enviar,
                icon: const Icon(Icons.send),
                label: const Text('Enviar'),
              ),
              const SizedBox(height: 24),
              Text(
                'Mitos enviados (${widget.mitosEnviados.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (widget.mitosEnviados.isEmpty)
                const Text(
                  'Nenhum mito enviado ainda.',
                  style: TextStyle(color: Cores.textoSuave),
                ),
              for (final mito in widget.mitosEnviados) _cardMito(mito),
            ],
          ),
        ),
      ),
    );
  }
}
