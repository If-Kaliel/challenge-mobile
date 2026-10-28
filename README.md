# Efeito Fallout ☢️

> Nome provisório

Aplicativo mobile de curiosidades sobre energia nuclear, feito em **Flutter** para o **Challenge FIAP 2026** em parceria com a **AMAZUL**.

## Integrantes

| Nome | RM |
|---|---|
| Kaliel Aquino | RM567587 |
| Andre Matuda | RM566733 |
| Paulo Diedrich | RM567618 |

## Empresa parceira

**AMAZUL - Amazônia Azul Tecnologias de Defesa S.A.**

Empresa pública ligada ao Ministério da Defesa por meio da Marinha do Brasil, que desenvolve tecnologias para o Programa Nuclear Brasileiro, o Programa Nuclear da Marinha e o programa de submarinos (PROSUB).

**Desafio 01 - Mitos e verdades sobre Tecnologias Nucleares:** criar uma plataforma divertida e interativa em que o usuário avalia afirmações sobre tecnologia nuclear e entende se elas são verdadeiras, falsas ou se dependem do contexto.

## Descrição da solução

A energia nuclear costuma ser lembrada só pelos acidentes, e muita informação errada circula sobre ela. O **Efeito Fallout** junta os dois lados em um só lugar:

- as **tragédias** que marcaram a história (Chernobyl, Césio-137 em Goiânia, Hiroshima e Nagasaki, Fukushima);
- os **avanços** na medicina (raio-X, exame PET) e na geração de energia (Angra, pastilha de urânio, baixa emissão de CO2);
- **curiosidades** de ciência (Marie Curie, a "banana radioativa").

O usuário navega por categorias, lê os detalhes de cada curiosidade, salva as favoritas e pode **enviar um mito** que ouviu para ser verificado.

Nesta Sprint 1 os dados são **mockados** (ficam em listas dentro do código), sem banco de dados.

## Telas

| Tela | O que tem |
|---|---|
| Inicial | Abertura do app, botão Começar e link para Sobre |
| Explorar | `GridView` com as 4 categorias (Tragédias, Medicina, Energia, Ciência) com imagens |
| Curiosidades | Lista filtrada pela categoria, botão de favoritar e contador de favoritos |
| Detalhes | Texto completo da curiosidade (recebe a curiosidade por parâmetro) |
| Enviar um mito | Formulário com validação |
| Meus favoritos | Lista dos favoritos, dá pra remover (recebe a lista por parâmetro) |
| Sobre o app | Informações do app, do desafio, da AMAZUL e as fontes |

### Fluxo de navegação

```
Inicial ──> Explorar ──> Curiosidades ──> Detalhes
   │           │              ├──> Enviar um mito ──(dialog)──> volta pra lista
   │           │              └──> Meus favoritos ──> Detalhes
   │           └──> Meus favoritos
   └──> Sobre o app
```

## Requisitos da Sprint 1

- **Navegação:** 7 telas ligadas com `Navigator.push` / `Navigator.pop`, com passagem de parâmetros (categoria, curiosidade e lista de favoritos).
- **Protótipo visual:** `Scaffold`, `AppBar`, `Column`, `Row`, `Container`, `Padding`, `SizedBox`, `Card`, `Image`, `Icon`, `ListView` e `GridView`, com tema próprio (escuro, amarelo e preto) em todas as telas.
- **Gerenciamento de estado:** `StatefulWidget` + `setState()` para favoritar/desfavoritar, com o contador "Favoritos: N" atualizando na hora.
- **Formulário:** `Form` + `GlobalKey<FormState>` + `TextFormField`, `DropdownButtonFormField` e `Switch`, com validação dos campos, `SnackBar` quando tem erro e `AlertDialog` quando envia.

## Como executar

**Pré-requisitos**

- Flutter **3.44** ou mais novo (Dart 3.12)
- Android Studio com um emulador Android, ou um celular Android com depuração USB
- Internet no emulador/celular (as imagens das categorias vêm da internet)

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
- Imagens do Wikimedia Commons

## Estrutura do projeto

```
lib/
├── main.dart              # inicia o app e aplica o tema
├── tema.dart              # cores e ThemeData do app
├── models/
│   ├── curiosidade.dart
│   └── categoria.dart
├── dados/                 # dados mockados
│   ├── curiosidades.dart
│   └── categorias.dart
└── telas/
    ├── tela_inicial.dart
    ├── tela_categorias.dart
    ├── tela_curiosidades.dart
    ├── tela_detalhe.dart
    ├── tela_enviar_mito.dart
    ├── tela_favoritos.dart
    └── tela_sobre.dart
```

## Vídeo

Link do vídeo no YouTube: *em breve*

## Fontes

- AIEA - Agência Internacional de Energia Atômica
- CNEN - Comissão Nacional de Energia Nuclear
- AMAZUL - apresentação de kick-off do Challenge FIAP (13/10/2026)
- IPCC - emissões de CO2 por fonte de energia
- Imagens: Wikimedia Commons
