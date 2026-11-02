# Efeito Fallout ☢️

Aplicativo mobile de curiosidades sobre energia nuclear, feito em **Flutter** para o **Challenge FIAP 2026** em parceria com a **AMAZUL**.

## Integrantes

| Nome | RM |
|---|---|
| Kaliel Aquino | RM567587 |
| Andre Matuda | RM566733 |
| Paulo Diedrich | RM567618 |
| Guilherme Barca | RM568517 |
| Guilherme Feitosa | RM566842 |


## Empresa parceira

**AMAZUL - Amazônia Azul Tecnologias de Defesa S.A.**

Empresa pública ligada ao Ministério da Defesa por meio da Marinha do Brasil, que desenvolve tecnologias para o Programa Nuclear Brasileiro, o Programa Nuclear da Marinha e o programa de submarinos (PROSUB).

**Desafio 01 - Mitos e verdades sobre Tecnologias Nucleares:** criar uma plataforma divertida e interativa em que o usuário avalia afirmações sobre tecnologia nuclear e entende se elas são verdadeiras, falsas ou se dependem do contexto.

## Descrição da solução

A energia nuclear costuma ser lembrada só pelos acidentes, e muita informação errada circula sobre ela. O **Efeito Fallout** junta os dois lados em um só lugar e ajuda a separar o que é mito do que é verdade:

- **Mito ou verdade?:** quiz com 12 afirmações sobre tecnologia nuclear. A pessoa responde Mito, Verdade ou Depende e, depois de cada resposta, vê uma explicação curta e a fonte. No final aparecem a nota e a revisão do que errou.
- **Curiosidades por tema:** 20 curiosidades em 4 categorias, cada uma com foto real. As **tragédias** (Chernobyl, Césio-137 em Goiânia, Hiroshima e Nagasaki, Fukushima...) têm um clima vermelho e escuro, e a **medicina** nuclear (raio-X, PET, iodo-131, radioterapia) tem um clima verde-água, de esperança.
- **Linha do tempo:** 17 eventos de 1895 a 2026, com filtro de avanços e tragédias.
- **Favoritos** e **Enviar um mito:** dá pra salvar curiosidades e anotar mitos que você ouviu por aí.
- **Letras maiores:** chave de acessibilidade que aumenta o texto do app inteiro.

Nesta Sprint 1 os dados são **mockados** (ficam em listas dentro do código), sem banco de dados. Por isso os favoritos, os mitos enviados e as letras maiores voltam ao normal quando o app é fechado.

## Telas

| Tela | O que tem |
|---|---|
| Inicial | Abertura do app, botão Começar, chave Letras maiores e link para Sobre |
| Explorar | `GridView` com as 4 categorias (Tragédias, Medicina, Energia, Ciência) com imagens |
| Curiosidades | Lista filtrada pela categoria, botão de favoritar e contador de favoritos |
| Detalhes | Texto completo da curiosidade (recebe a curiosidade por parâmetro) |
| Enviar um mito | Formulário com validação e lista de mitos enviados, dá pra remover |
| Meus favoritos | Lista dos favoritos, dá pra remover (recebe a lista por parâmetro) |
| Mito ou verdade | Quiz com 12 afirmações em ordem sorteada: a pessoa responde Mito, Verdade ou Depende, vê a explicação e a fonte, e o placar e a barra de progresso mudam com `setState` |
| Resultado | Nota do quiz, mensagem conforme o desempenho e revisão do que errou (recebe os dados por parâmetro) |
| Linha do tempo | 17 eventos de 1895 a 2026 em ordem, com filtro de avanços e tragédias |
| Sobre o app | Informações do app, do desafio, da AMAZUL, as fontes e os créditos das fotos |

### Fluxo de navegação

```
Inicial ──> Explorar ──> Curiosidades ──> Detalhes
   │           │              ├──> Enviar um mito
   │           │              └──> Meus favoritos ──> Detalhes
   │           ├──> Meus favoritos
   │           ├──> Mito ou verdade (quiz) ──> Resultado
   │           └──> Linha do tempo ──> Detalhes
   └──> Sobre o app
```

## Requisitos da Sprint 1

- **Navegação:** 10 telas ligadas com `Navigator.push` / `Navigator.pop`, com passagem de parâmetros (categoria, curiosidade, lista de favoritos e acertos do quiz).
- **Protótipo visual:** `Scaffold`, `AppBar`, `Column`, `Row`, `Container`, `Padding`, `SizedBox`, `Card`, `Image`, `Icon`, `ListView` e `GridView`, com tema próprio (escuro, amarelo e preto) em todas as telas.
- **Gerenciamento de estado:** `StatefulWidget` + `setState()` para favoritar/desfavoritar, com o contador "Favoritos: N" atualizando na hora. A chave "Letras maiores" da tela inicial também usa `setState` e aumenta o texto de todas as telas (acessibilidade).
- **Formulário:** `Form` + `GlobalKey<FormState>` + `TextFormField`, `DropdownButtonFormField` e `Switch`, com validação dos campos, `SnackBar` quando tem erro e `AlertDialog` quando envia.

## Como executar

**Pré-requisitos**

- Flutter **3.44** ou mais novo (Dart 3.12)
- Android Studio com um emulador Android, ou um celular Android com depuração USB

**Passo a passo**

```bash
git clone https://github.com/If-Kaliel/challenge-mobile.git
cd challenge-mobile
flutter pub get
flutter run
```

Para rodar os testes:

```bash
flutter test
```

## Tecnologias utilizadas

- Flutter 3.44
- Dart 3.12
- Material Design 3
- Nenhum pacote externo além do Flutter (estado só com `setState`)
- Fotos do Wikimedia Commons, guardadas dentro do app (funciona sem internet)

## Estrutura do projeto

```
lib/
├── main.dart              # inicia o app e aplica o tema
├── tema.dart              # cores e ThemeData do app
├── models/
│   ├── curiosidade.dart
│   ├── categoria.dart
│   ├── mito_enviado.dart
│   └── pergunta.dart
├── dados/                 # dados mockados
│   ├── curiosidades.dart
│   ├── categorias.dart
│   └── perguntas.dart
├── widgets/
│   └── imagem_local.dart
└── telas/
    ├── tela_inicial.dart
    ├── tela_linha_do_tempo.dart
    ├── tela_categorias.dart
    ├── tela_curiosidades.dart
    ├── tela_detalhe.dart
    ├── tela_enviar_mito.dart
    ├── tela_favoritos.dart
    ├── tela_quiz.dart
    ├── tela_resultado.dart
    └── tela_sobre.dart
```

## Vídeo

Link do vídeo no YouTube: *em breve*

> 📌 **Recado pro Kaliel:** gravar o vídeo rodando no **emulador Android** (Android Studio). Vídeo só no navegador não vale nota!
>
> Checklist do que tem que aparecer (máximo **5 minutos**, com narração):
> - [ ] o app rodando no emulador Android
> - [ ] todas as telas: Inicial, Explorar, Curiosidades, Detalhes, Enviar um mito, Meus favoritos, Mito ou verdade, Resultado, Linha do tempo e Sobre o app
> - [ ] o fluxo de navegação, indo e voltando entre as telas
> - [ ] o formulário funcionando: primeiro enviar vazio pra mostrar a validação, depois preencher certo e mostrar o dialog
> - [ ] favoritar e desfavoritar mostrando o contador "Favoritos: N" mudando (gerenciamento de estado com `setState`)
> - [ ] subir no YouTube como **não listado**, colocar o link aqui em cima e apagar este recado

## Fontes

- AMAZUL - apresentação de kick-off do Challenge FIAP (13/10/2026)
- AIEA - Agência Internacional de Energia Atômica, incluindo o relatório "The Radiological Accident in Goiânia" (1988)
- AECL - "A Reactor Cannot Explode Like a Nuclear Bomb"
- CNEN - Comissão Nacional de Energia Nuclear
- Constituição Federal de 1988, art. 21, XXIII, a
- EPA (agência ambiental dos EUA) - irradiação de alimentos
- Governo da Finlândia - licença do depósito Onkalo (out/2026)
- Health Canada - irradiação de alimentos
- Health Physics Society - irradiação de alimentos e exames com radiação
- IPCC - AR5, Grupo de Trabalho III, Anexo III (2014), emissões de CO2 por fonte de energia
- OncoLink (Penn Medicine) - radioatividade depois de exames de medicina nuclear
- Our World in Data - "What are the safest and cleanest sources of energy?"
- UNSCEAR - Relatório de 2008, radiação natural
- Utah Office of Energy Development - equivalência da pastilha de urânio (2026)
- Fotos: Wikimedia Commons (autor e licença de cada uma estão na tela Sobre o app)
