import 'dart:io';

getCharacterName() {
  stdout.write("캐릭터의 이름을 입려하세요: ");
  String? inumber;
  RegExp exp = RegExp(r'^[a-zA-Z가-힣]+$');

  bool loop = true;
  while (loop) {
    inumber = stdin.readLineSync()!;
    //bool checknull = inumber == EmptyValue ? false : true;
    var match = exp.hasMatch(inumber);
      if (match) {
        loop = false;
        return inumber;
      } else {
        print("한글, 영문 대소문자만 사용가능합니다. ");
      }
  }
}

loadCharacterStats() {
  try {
    final file = File('lib/text/characters.txt');
    final contents = file.readAsStringSync();
    final stats = contents.split(',');
    if (stats.length != 3) throw FormatException('Invalid character data');

    int health = int.parse(stats[0]);
    int attack = int.parse(stats[1]);
    int defense = int.parse(stats[2]);

    String name = getCharacterName()!;
    Character character = Character(name, health, attack, defense);
    return character;
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

loadMonsterStats() {

  List<Monster> monsters = [];
  try {
    final file = File('lib/text/monsters.txt');
    final contents = file.readAsStringSync();
    final list = contents.split('\n');

    for (String line in list) {
      final stats = line.split(','); // 각 몬스터의 데이터는 ','로 구분됨

      if (stats.length != 3) throw FormatException('Invalid monster data: $line');

      String monsterName = stats[0]; // 몬스터 이름
      int monsterHp = int.parse(stats[1]); // 몬스터 HP
      int attackMax = int.parse(stats[2]); // 최대 공격력
      int defense = 0;

      Monster monster = Monster(monsterName, monsterHp, attackMax, defense);
      monsters.add(monster); // 몬스터 리스트에 추가
    }
    return monsters;
  } catch (e) {
    print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

// 게임을 정의하기 위한 클래스
class Game {
  Character character = loadCharacterStats();
  List<Monster> monsters = loadMonsterStats();

  //List<List<Monster>>
  //int

  startGame() {
    character.showStatus();
    print(monsters[1]);
    //print(monster[1]);
    battle();
  }

  void battle() {
    String? choice;
    bool play = true;
    var save = File('lib/text/result.txt');
    while(play){
      print("공격하기(1), 방어하기(2)");
      choice = stdin.readLineSync()!;
      switch(choice){
        case '1':
        //character.attackMonster(monster);
        print("공격");
        case '2':
        //character.defend();
        print("방어");
      }
      if(play){
        play = false;
      }
    }
    save.writeAsStringSync(character.toString());
  }
  void getRandomMonster() {
    var random = monsters.shuffle();


  }
}

//캐릭터를 정의하기 위한 클래스
class Character {

  String name;
  int health;
  int attack;
  int defense;

  Character(this.name, this.health, this.attack, this.defense);

  void attackMonster(Monster monster) {
    print(monster.attackMax);
  }

  void defend() {}
  void showStatus() {
    print(name+" - 체력: "+health.toString()+", 공격력: "+ attack.toString()+", 방어력: "+health.toString());
  }
}

//몬스터를 정의하기 위한 클래스
class Monster {

  String monsterName;
  int monsterHp;
  int attackMax;
  int defense;

  Monster(this.monsterName, this.monsterHp, this.attackMax, this.defense);

  void attackCharacter(Character character) {}

  void showStatus() {
    print(monsterName+" - 체력: "+ monsterHp.toString() +", 공격력: ");
  }
}

void main() {
  Game().startGame();
}
