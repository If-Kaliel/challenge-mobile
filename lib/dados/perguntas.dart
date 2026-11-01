import '../models/pergunta.dart';

// as 3 opcoes do desafio da AMAZUL: verdadeiro, falso ou depende do contexto
const List<String> opcoesQuiz = ['Mito', 'Verdade', 'Depende'];

const String fonteAmazul = 'AMAZUL, Kick-off Challenge FIAP (2026)';

const List<Pergunta> listaPerguntas = [
  Pergunta(
    afirmacao: 'Uma usina nuclear pode explodir como uma bomba atômica.',
    resposta: 'Mito',
    explicacao:
        'O urânio das usinas é enriquecido só até uns 4,5%, e uma bomba precisa de urânio muito mais enriquecido e de um projeto feito pra isso. '
        'A explosão de Chernobyl foi causada por vapor e gases, não foi uma explosão atômica. '
        'Um reator pode ter acidente grave, mas não vira uma bomba.',
    fonte:
        'AECL, "A Reactor Cannot Explode Like a Nuclear Bomb"; $fonteAmazul',
  ),
  Pergunta(
    afirmacao: 'A radiação está presente naturalmente no nosso dia a dia.',
    resposta: 'Verdade',
    explicacao:
        'Recebemos radiação do solo, do ar, dos alimentos e do espaço. '
        'A média mundial é de cerca de 2,4 mSv por ano, só de fontes naturais.',
    fonte: 'UNSCEAR, Relatório de 2008; $fonteAmazul',
  ),
  Pergunta(
    afirmacao: 'Usinas nucleares soltam muito CO2 enquanto geram energia.',
    resposta: 'Mito',
    explicacao:
        'A usina não queima nada pra gerar energia. '
        'Contando todo o ciclo de vida, a mediana é de 12 g de CO2 por kWh, perto da energia eólica (11 g). '
        'O carvão fica em cerca de 820 g.',
    fonte: 'IPCC, AR5, Grupo de Trabalho III, Anexo III (2014)',
  ),
  Pergunta(
    afirmacao: 'Alimentos irradiados ficam radioativos.',
    resposta: 'Mito',
    explicacao:
        'A irradiação mata bactérias e ajuda o alimento a durar mais. '
        'Nas condições aprovadas ele não fica radioativo e nem encosta na fonte de radiação. '
        'É parecido com uma pessoa que faz raio-X: ela não sai radioativa.',
    fonte: 'Health Canada; EPA (EUA); Health Physics Society',
  ),
  Pergunta(
    afirmacao: 'A energia nuclear é perigosa.',
    resposta: 'Depende',
    explicacao:
        'Os acidentes podem ser muito graves, como Chernobyl e Fukushima. '
        'Mas, contando mortes por energia gerada, ela fica entre as fontes mais seguras: cerca de 0,03 mortes por TWh, contra 24,6 do carvão. '
        'Depende de projeto, regras e operação bem-feitos.',
    fonte:
        'Our World in Data, "What are the safest and cleanest sources of energy?"',
  ),
  Pergunta(
    afirmacao: 'O lixo nuclear não tem solução.',
    resposta: 'Depende',
    explicacao:
        'Existem soluções, como guardar o combustível usado em depósitos fundos na rocha. '
        'Em outubro de 2026 a Finlândia licenciou o Onkalo, o primeiro depósito definitivo do mundo, que ainda vai começar a operar. '
        'Mas os outros países ainda não têm o seu. '
        'O Brasil tem o depósito de Abadia de Goiás e projeta um novo, o CENTENA.',
    fonte: 'Governo da Finlândia (out/2026); $fonteAmazul',
  ),
  Pergunta(
    afirmacao: 'O Brasil tem armas nucleares.',
    resposta: 'Mito',
    explicacao:
        'A Constituição de 1988 diz que toda atividade nuclear no Brasil só pode ter fins pacíficos. '
        'O país também assinou o Tratado de Não Proliferação (TNP) em 1998.',
    fonte: 'Constituição Federal de 1988, art. 21, XXIII, a; $fonteAmazul',
  ),
  Pergunta(
    afirmacao:
        'O acidente do césio-137 em Goiânia aconteceu numa usina nuclear.',
    resposta: 'Mito',
    explicacao:
        'Não teve usina nenhuma. '
        'O césio veio de um aparelho de radioterapia abandonado numa clínica desativada, que foi aberto por catadores.',
    fonte: 'AIEA, "The Radiological Accident in Goiânia" (1988)',
  ),
  Pergunta(
    afirmacao: 'A medicina nuclear ajuda a diagnosticar e tratar câncer.',
    resposta: 'Verdade',
    explicacao:
        'Exames como o PET usam radiofármacos pra encontrar tumores, e o iodo-131 é usado no tratamento do câncer de tireoide.',
    fonte: 'AIEA - Agência Internacional de Energia Atômica',
  ),
  Pergunta(
    afirmacao: 'Quem faz exame com radiação fica radioativo.',
    resposta: 'Depende',
    explicacao:
        'Depende do exame. '
        'No raio-X a radiação vem de fora e para quando a máquina desliga, então a pessoa não fica radioativa. '
        'Na medicina nuclear o paciente recebe um material radioativo e fica levemente radioativo por um tempo, até ele perder a força e sair do corpo.',
    fonte: 'Health Physics Society; OncoLink (Penn Medicine)',
  ),
  Pergunta(
    afirmacao:
        'Uma pastilha de urânio de 6 gramas tem tanta energia quanto cerca de 1 tonelada de carvão.',
    resposta: 'Verdade',
    explicacao:
        'Isso vale pra uma pastilha enriquecida a 4,5%, usada em reatores de água leve. '
        'Por isso uma usina precisa de bem pouco combustível perto de uma termelétrica a carvão.',
    fonte: '$fonteAmazul; Utah Office of Energy Development (2026)',
  ),
  Pergunta(
    afirmacao: 'Um submarino com propulsão nuclear é uma arma nuclear.',
    resposta: 'Mito',
    explicacao:
        'A energia nuclear serve pra mover o submarino. '
        'O submarino brasileiro é convencionalmente armado, ou seja, não leva armas nucleares. '
        'O Brasil busca autonomia tecnológica, não a bomba.',
    fonte: fonteAmazul,
  ),
];
