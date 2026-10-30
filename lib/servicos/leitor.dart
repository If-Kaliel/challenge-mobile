import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

// le os textos do app em voz alta usando a voz do proprio celular
class Leitor {
  static final FlutterTts _tts = FlutterTts();
  static bool _configurado = false;
  static String? _textoPedido;

  // ligado = cada tela se le sozinha quando abre
  static final ValueNotifier<bool> modoSom = ValueNotifier(false);

  // o que esta sendo lido agora, null = em silencio
  static final ValueNotifier<String?> falandoAgora = ValueNotifier(null);

  // com o TalkBack ligado ele ja le a tela, ai o app nao fala por cima
  static bool get _temLeitorDeTela =>
      WidgetsBinding.instance.accessibilityFeatures.accessibleNavigation;

  static Future<void> _configurar() async {
    // quando uma fala interrompe outra vem cancelou e depois comecou,
    // por isso quem marca o texto atual e o aviso de comecou
    _tts.setStartHandler(() => falandoAgora.value = _textoPedido);
    _tts.setCompletionHandler(_terminou);
    _tts.setCancelHandler(_terminou);
    _tts.setErrorHandler((erro) => _terminou());

    await _tts.setLanguage('pt-BR');
    await _tts.setSpeechRate(0.5);
    _configurado = true;
  }

  static void _terminou() {
    falandoAgora.value = null;
  }

  // devolve false se nao deu pra falar (celular sem voz instalada por exemplo)
  static Future<bool> falar(String texto) async {
    _textoPedido = texto;
    try {
      if (!_configurado) {
        await _configurar();
      }
      final resultado = await _tts
          .speak(texto)
          .timeout(const Duration(seconds: 10));
      return resultado == 1;
    } catch (erro) {
      return false;
    }
  }

  // so fala se o modo de som estiver ligado
  static void narrar(String texto) {
    if (modoSom.value && !_temLeitorDeTela) {
      falar(texto);
    }
  }

  static Future<void> parar() async {
    _textoPedido = null;
    try {
      await _tts.stop();
    } catch (erro) {
      _terminou();
    }
  }

  // para so se ainda for esse texto, pra nao cortar a fala da proxima tela
  static void pararTexto(String texto) {
    if (_textoPedido == texto) {
      parar();
    }
  }

  static void alternarModoSom() {
    modoSom.value = !modoSom.value;
    if (modoSom.value) {
      falar('Modo de som ligado');
    } else {
      parar();
    }
  }
}
