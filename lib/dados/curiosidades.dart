import '../models/curiosidade.dart';

// dados mockados, ainda nao tem banco
const List<Curiosidade> listaCuriosidades = [
  Curiosidade(
    titulo: 'Chernobyl (1986)',
    categoria: 'Tragédias',
    resumo:
        'O pior acidente nuclear da história aconteceu na Ucrânia, em 26 de abril de 1986, quando o reator 4 explodiu.',
    texto:
        'Durante um teste de segurança na madrugada de 26 de abril de 1986, o reator 4 da usina de Chernobyl saiu do controle e explodiu. '
        'A cidade de Pripyat, onde moravam cerca de 49 mil pessoas, foi evacuada no dia seguinte e nunca mais foi habitada. '
        'Até hoje existe uma zona de exclusão de 30 km ao redor da usina.',
  ),
  Curiosidade(
    titulo: 'Césio-137 em Goiânia (1987)',
    categoria: 'Tragédias',
    resumo:
        'Catadores abriram um aparelho de radioterapia abandonado e o pó brilhante contaminou centenas de pessoas.',
    texto:
        'Em setembro de 1987, dois catadores encontraram um aparelho de radioterapia abandonado numa clínica desativada e venderam as peças para um ferro-velho. '
        'Dentro tinha césio-137, um pó que brilhava azul no escuro e encantou quem viu. '
        'Quatro pessoas morreram, entre elas a menina Leide das Neves, de 6 anos, e cerca de 249 foram contaminadas. '
        'É considerado um dos piores acidentes radiológicos do mundo.',
  ),
  Curiosidade(
    titulo: 'Hiroshima e Nagasaki (1945)',
    categoria: 'Tragédias',
    resumo:
        'As duas únicas bombas atômicas usadas em guerra foram lançadas sobre o Japão em agosto de 1945.',
    texto:
        'Em 6 de agosto de 1945 os Estados Unidos lançaram a bomba "Little Boy" sobre Hiroshima, e três dias depois a "Fat Man" sobre Nagasaki. '
        'Estima-se que mais de 200 mil pessoas morreram até o fim daquele ano, por causa da explosão, das queimaduras e da radiação.',
  ),
  Curiosidade(
    titulo: 'Fukushima (2011)',
    categoria: 'Tragédias',
    resumo:
        'Um terremoto seguido de tsunami desligou o resfriamento da usina e três reatores derreteram.',
    texto:
        'Em 11 de março de 2011 um terremoto de magnitude 9 atingiu o Japão e um tsunami com ondas de mais de 14 metros invadiu a usina de Fukushima Daiichi. '
        'Sem energia pra resfriar, três reatores derreteram e aconteceram explosões de hidrogênio. '
        'Mais de 150 mil pessoas tiveram que sair de casa.',
  ),
  Curiosidade(
    titulo: 'O primeiro raio-X (1895)',
    categoria: 'Medicina',
    resumo:
        'Wilhelm Röntgen fez a primeira radiografia da história: a mão da esposa dele, com anel e tudo.',
    texto:
        'Em 1895 o físico alemão Wilhelm Röntgen descobriu uma radiação invisível que atravessava o corpo e chamou de raios X, porque não sabia o que era. '
        'A primeira radiografia foi da mão da esposa dele, Anna Bertha, e dizem que ela falou "eu vi a minha morte". '
        'Em 1901 ele ganhou o primeiro Nobel de Física da história.',
  ),
  Curiosidade(
    titulo: 'Exame PET',
    categoria: 'Medicina',
    resumo:
        'Uma pequena quantidade de material radioativo ajuda os médicos a encontrar tumores no corpo.',
    texto:
        'No exame PET o paciente recebe uma dose pequena de um radiofármaco, normalmente uma glicose marcada com flúor-18. '
        'Como as células de câncer consomem muita glicose, elas aparecem brilhando na imagem. '
        'No Brasil os radiofármacos são produzidos principalmente pelo IPEN, em São Paulo.',
  ),
  Curiosidade(
    titulo: 'Angra 1 e Angra 2',
    categoria: 'Energia',
    resumo:
        'O Brasil tem duas usinas nucleares funcionando em Angra dos Reis, no Rio de Janeiro.',
    texto:
        'A Central Nuclear Almirante Álvaro Alberto, em Angra dos Reis (RJ), tem duas usinas funcionando: Angra 1, desde 1985, e Angra 2, desde 2001. '
        'A Angra 3 ainda está em construção. '
        'Juntas elas geram cerca de 2% a 3% da eletricidade do país.',
  ),
  Curiosidade(
    titulo: 'Pastilha de urânio',
    categoria: 'Energia',
    resumo:
        'Uma pastilha de urânio de 6 gramas tem tanta energia quanto cerca de 1 tonelada de carvão.',
    texto:
        'O combustível das usinas é feito de pastilhas de urânio enriquecido, do tamanho da ponta de um dedo. '
        'Uma pastilha de 6 gramas, enriquecida a 4,5%, tem tanta energia quanto cerca de 1 tonelada de carvão ou 3 barris de petróleo. '
        'As pastilhas ficam empilhadas dentro de varetas de metal que vão pro reator. (Fonte: apresentação da AMAZUL)',
  ),
  Curiosidade(
    titulo: 'Energia que quase não solta CO2',
    categoria: 'Energia',
    resumo:
        'Usina nuclear não queima nada, então quase não solta gás carbônico enquanto gera energia.',
    texto:
        'A usina usa o calor da fissão do urânio pra ferver água, e o vapor gira uma turbina. '
        'Como não tem queima, não sai CO2 da usina, e aquela "fumaça" das torres de resfriamento é só vapor de água. '
        'Contando a vida inteira da usina (construção, mineração e tudo), as emissões ficam parecidas com as da energia eólica, segundo o IPCC.',
  ),
  Curiosidade(
    titulo: 'Banana radioativa?',
    categoria: 'Ciência',
    resumo:
        'A banana tem potássio-40, que é levemente radioativo. Mas teria que comer milhões de uma vez pra fazer mal.',
    texto:
        'A banana tem potássio, e uma pequena parte dele é o potássio-40, que é radioativo. '
        'Comer uma banana dá uma dose de radiação tão pequena que virou piada entre cientistas: a "dose equivalente a uma banana". '
        'E o corpo elimina o potássio que sobra, então ele não fica acumulando.',
  ),
  Curiosidade(
    titulo: 'Marie Curie',
    categoria: 'Ciência',
    resumo:
        'Ganhou dois prêmios Nobel, um de Física e outro de Química, estudando a radioatividade.',
    texto:
        'Marie Curie descobriu, junto com o marido Pierre, os elementos polônio e rádio. '
        'Foi a primeira mulher a ganhar um Nobel (Física, 1903) e a única pessoa a ganhar em duas ciências diferentes (Química, 1911). '
        'Ela morreu em 1934 de uma doença causada pela radiação, e os cadernos dela são radioativos até hoje.',
  ),
];
