import '../models/curiosidade.dart';

// dados mockados, ainda nao tem banco
const List<Curiosidade> listaCuriosidades = [
  Curiosidade(
    titulo: 'Chernobyl (1986)',
    categoria: 'Tragédias',
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/15/Chernobyl_nuclear_disaster_aftermath_abandoned_town_of_Pripyat_02.jpg/960px-Chernobyl_nuclear_disaster_aftermath_abandoned_town_of_Pripyat_02.jpg',
    legenda:
        'Pripyat abandonada. Lá no fundo, o domo que hoje cobre o reator 4 de Chernobyl.',
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
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f9/02010020_cemetery_Goi%C3%A2nia.jpg/960px-02010020_cemetery_Goi%C3%A2nia.jpg',
    legenda:
        'Cemitério de Goiânia onde vítimas do césio-137 foram enterradas em caixões de chumbo cobertos de concreto.',
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
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/2c/AtomicEffects-Hiroshima.jpg/960px-AtomicEffects-Hiroshima.jpg',
    legenda:
        'Hiroshima destruída, vista do alto do hospital da Cruz Vermelha, em 1945.',
    resumo:
        'As duas únicas bombas atômicas usadas em guerra foram lançadas sobre o Japão em agosto de 1945.',
    texto:
        'Em 6 de agosto de 1945 os Estados Unidos lançaram a bomba "Little Boy" sobre Hiroshima, e três dias depois a "Fat Man" sobre Nagasaki. '
        'Estima-se que mais de 200 mil pessoas morreram até o fim daquele ano, por causa da explosão, das queimaduras e da radiação.',
  ),
  Curiosidade(
    titulo: 'Fukushima (2011)',
    categoria: 'Tragédias',
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7d/Fukushima_I_by_Digital_Globe.jpg/960px-Fukushima_I_by_Digital_Globe.jpg',
    legenda:
        'Foto de satélite da usina de Fukushima Daiichi depois do tsunami, com os prédios dos reatores destruídos.',
    resumo:
        'Um terremoto seguido de tsunami desligou o resfriamento da usina e três reatores derreteram.',
    texto:
        'Em 11 de março de 2011 um terremoto de magnitude 9 atingiu o Japão e um tsunami com ondas de mais de 14 metros invadiu a usina de Fukushima Daiichi. '
        'Sem energia pra resfriar, três reatores derreteram e aconteceram explosões de hidrogênio. '
        'Mais de 150 mil pessoas tiveram que sair de casa.',
  ),
  Curiosidade(
    titulo: 'Three Mile Island (1979)',
    categoria: 'Tragédias',
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b9/Three_Mile_Island_%28color%29.jpg/960px-Three_Mile_Island_%28color%29.jpg',
    legenda:
        'A usina de Three Mile Island, na Pensilvânia (EUA).',
    resumo:
        'O pior acidente nuclear dos EUA: metade do reator derreteu, mas ninguém morreu.',
    texto:
        'Em 28 de março de 1979, na usina de Three Mile Island, na Pensilvânia, uma válvula travou aberta e os operadores não perceberam. '
        'Sem água suficiente, metade do núcleo do reator 2 derreteu. '
        'Quase toda a radiação ficou presa dentro do prédio de contenção e ninguém morreu, mas o medo foi enorme e as regras de segurança dos Estados Unidos mudaram depois disso.',
  ),
  Curiosidade(
    titulo: 'Castle Bravo (1954)',
    categoria: 'Tragédias',
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5d/Castle_Bravo_Blast.jpg/960px-Castle_Bravo_Blast.jpg',
    legenda:
        'O cogumelo da explosão Castle Bravo, no Atol de Bikini.',
    resumo:
        'Um teste de bomba saiu 2,5 vezes mais forte que o previsto e a chuva radioativa caiu em cima de pescadores.',
    texto:
        'Em 1º de março de 1954, os Estados Unidos testaram uma bomba de hidrogênio no Atol de Bikini, nas Ilhas Marshall. '
        'Os cientistas esperavam 6 megatons, mas a explosão teve 15, umas mil vezes a bomba de Hiroshima. '
        'A cinza radioativa, o tal "fallout", caiu sobre ilhas habitadas e sobre um barco de pesca japonês, o Daigo Fukuryū Maru. '
        'Os 23 pescadores ficaram doentes e um deles morreu meses depois.',
  ),
  Curiosidade(
    titulo: 'O primeiro raio-X (1895)',
    categoria: 'Medicina',
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/79/First_medical_X-ray_by_Wilhelm_R%C3%B6ntgen_of_his_wife_Anna_Bertha_Ludwig%27s_hand_-_18951222.jpg/960px-First_medical_X-ray_by_Wilhelm_R%C3%B6ntgen_of_his_wife_Anna_Bertha_Ludwig%27s_hand_-_18951222.jpg',
    legenda:
        'A primeira radiografia médica: a mão de Anna Bertha, esposa de Röntgen, com o anel.',
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
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c6/PET-image.jpg/960px-PET-image.jpg',
    legenda:
        'Exame PET do cérebro. As cores mostram onde a glicose está sendo mais usada.',
    resumo:
        'Uma pequena quantidade de material radioativo ajuda os médicos a encontrar tumores no corpo.',
    texto:
        'No exame PET o paciente recebe uma dose pequena de um radiofármaco, normalmente uma glicose marcada com flúor-18. '
        'Como as células de câncer consomem muita glicose, elas aparecem brilhando na imagem. '
        'No Brasil os radiofármacos são produzidos principalmente pelo IPEN, em São Paulo.',
  ),
  Curiosidade(
    titulo: 'Iodo radioativo na tireoide',
    categoria: 'Medicina',
    imagem:
        'https://upload.wikimedia.org/wikipedia/commons/4/4f/Iodine_-_131_Capsule_Facility.jpg',
    legenda:
        'Laboratório onde são preparadas as cápsulas de iodo-131 usadas no tratamento.',
    resumo:
        'A tireoide "puxa" o iodo do corpo, então o iodo radioativo vai direto onde precisa tratar.',
    texto:
        'A tireoide é a parte do corpo que mais acumula iodo, e os médicos aproveitam isso. '
        'O paciente toma uma cápsula de iodo-131 e a radiação vai direto pra tireoide, destruindo as células doentes sem precisar de cirurgia. '
        'É usado desde a década de 1940 pra tratar hipertireoidismo e câncer de tireoide.',
  ),
  Curiosidade(
    titulo: 'Radioterapia',
    categoria: 'Medicina',
    imagem:
        'https://upload.wikimedia.org/wikipedia/commons/3/30/Radium_radiotherapy_machine_1951.jpg',
    legenda:
        'Ilustração de revista mostrando uma das primeiras máquinas de radioterapia, de 1951.',
    resumo:
        'Cerca de metade das pessoas com câncer precisa de radioterapia em algum momento do tratamento.',
    texto:
        'Na radioterapia, feixes de radiação são apontados pro tumor pra destruir as células de câncer. '
        'As primeiras máquinas usavam rádio, e a partir de 1951 vieram as de cobalto-60. '
        'Hoje os aparelhos são aceleradores lineares, muito mais precisos, que miram o tumor e poupam o resto do corpo. '
        'Segundo a AIEA, cerca de metade dos pacientes com câncer precisa de radioterapia.',
  ),
  Curiosidade(
    titulo: 'Angra 1 e Angra 2',
    categoria: 'Energia',
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c6/Angra_dos_Reis_-_usinas_nucleares.jpg/960px-Angra_dos_Reis_-_usinas_nucleares.jpg',
    legenda:
        'As usinas nucleares de Angra dos Reis, no Rio de Janeiro.',
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
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/fb/Nuclear_Fuel_Pellets_%2814492225000%29.jpg/960px-Nuclear_Fuel_Pellets_%2814492225000%29.jpg',
    legenda:
        'Pastilhas de combustível nuclear, do tamanho da ponta de um dedo.',
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
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f9/Doel_nuclear_power_plant.JPG/960px-Doel_nuclear_power_plant.JPG',
    legenda:
        'Torres de resfriamento da usina de Doel, na Bélgica. O que sai delas é vapor de água.',
    resumo:
        'Usina nuclear não queima nada, então quase não solta gás carbônico enquanto gera energia.',
    texto:
        'A usina usa o calor da fissão do urânio pra ferver água, e o vapor gira uma turbina. '
        'Como não tem queima, não sai CO2 da usina, e aquela "fumaça" das torres de resfriamento é só vapor de água. '
        'Contando a vida inteira da usina (construção, mineração e tudo), as emissões ficam parecidas com as da energia eólica, segundo o IPCC.',
  ),
  Curiosidade(
    titulo: 'As primeiras lâmpadas nucleares (1951)',
    categoria: 'Energia',
    imagem:
        'https://upload.wikimedia.org/wikipedia/commons/a/ac/First_four_nuclear_lit_bulbs.jpeg',
    legenda:
        'As quatro lâmpadas acesas pelo reator EBR-I em 1951.',
    resumo:
        'Quatro lâmpadas foram as primeiras coisas acesas com eletricidade nuclear.',
    texto:
        'No dia 20 de dezembro de 1951, o reator experimental EBR-I, em Idaho (EUA), gerou eletricidade pela primeira vez e acendeu quatro lâmpadas de 200 watts. '
        'No dia seguinte ele já abastecia o próprio prédio. '
        'Três anos depois, em 1954, a usina de Obninsk, na antiga União Soviética, foi a primeira a mandar energia pra rede elétrica de uma cidade.',
  ),
  Curiosidade(
    titulo: 'Banana radioativa?',
    categoria: 'Ciência',
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/10/Banana_isolated_on_white.jpg/960px-Banana_isolated_on_white.jpg',
    legenda:
        'Uma banana comum. Sim, ela é um pouquinho radioativa.',
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
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/11/Marie_Curie_in_her_Paris_Laboratory%2C_1912.jpg/960px-Marie_Curie_in_her_Paris_Laboratory%2C_1912.jpg',
    legenda:
        'Marie Curie no laboratório dela em Paris, em 1912.',
    resumo:
        'Ganhou dois prêmios Nobel, um de Física e outro de Química, estudando a radioatividade.',
    texto:
        'Marie Curie descobriu, junto com o marido Pierre, os elementos polônio e rádio. '
        'Foi a primeira mulher a ganhar um Nobel (Física, 1903) e a única pessoa a ganhar em duas ciências diferentes (Química, 1911). '
        'Ela morreu em 1934 de uma doença causada pela radiação, e os cadernos dela são radioativos até hoje.',
  ),
  Curiosidade(
    titulo: 'O primeiro reator (1942)',
    categoria: 'Ciência',
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/fe/Stagg_Field_reactor.jpg/960px-Stagg_Field_reactor.jpg',
    legenda:
        'Ilustração do Chicago Pile-1, o primeiro reator nuclear do mundo.',
    resumo:
        'O primeiro reator nuclear do mundo foi montado embaixo da arquibancada de um estádio.',
    texto:
        'Em 2 de dezembro de 1942, a equipe de Enrico Fermi ligou o Chicago Pile-1, uma pilha de blocos de grafite e urânio montada embaixo da arquibancada do estádio Stagg Field, na Universidade de Chicago. '
        'Foi a primeira reação nuclear em cadeia controlada da história. '
        'Não tinha blindagem nenhuma, e uma equipe ficava lá em cima com baldes de cádmio pra jogar no reator se algo desse errado.',
  ),
];
