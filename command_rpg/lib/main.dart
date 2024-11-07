import 'dart:io';
import 'dart:math';

getCharacterName() {
  String? inumber;
  RegExp exp = RegExp(r'^[a-zA-Z가-힣]+$');

  bool loop = true;
  while (loop) {
    stdout.write("캐릭터의 이름을 입려하세요: ");
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

      if (stats.length != 3)
        throw FormatException('Invalid monster data: $line');

      String monsterName = stats[0]; // 몬스터 이름
      int monsterHp = int.parse(stats[1]); // 몬스터 HP
      int attackMax = int.parse(stats[2]); // 최대 공격력
      int attack = Random().nextInt(attackMax);
      int defense = 0;

      Monster monster = Monster(monsterName, monsterHp, attack, defense);
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
  int i = 0;

  startGame() {
    print("게임을 시작합니다!");
    character.showStatus();
    print('');
    battle();
  }

  battle() {
    // var ranMonster = getRandomMonster();
    // print("새로운 몬스터가 나타낫습니다.");
    // ranMonster.showStatus();
    // print('');

    String? choice;
    bool play = true;
    int i =1;
    var save = File('lib/text/result.txt');
    while (play) {
      bool turn = true;
      var ranMonster = getRandomMonster();
      print("새로운 몬스터가 나타낫습니다.");
      ranMonster.showStatus();
      print('');
      while (turn) {
        //캐릭터 턴
        print(character.name + "의 턴");
        stdout.write("행동을 선택하세요 (1: 공격, 2: 방어) :");
        choice = stdin.readLineSync()!;
        switch (choice) {
          case '1':
            character.attackMonster(ranMonster);
          case '2':
            character.defend();
            character.showStatus();
        }
        //몬스터 턴
        if (ranMonster.monsterHp > 0) {
          print("\n" + ranMonster.monsterName + "의 턴");
          ranMonster.attackCharacter(character);
          character.showStatus();
          ranMonster.showStatus();
          print("");
          
        } else {
          print(ranMonster.monsterName + "을 물리쳤습니다.");
          i += 1;
          if(i>3){
            play = false;
            turn = false;
            print("축하합니다? 모든? 몬스터?를 물리쳤습니다.");
          }else{
          print("다음 몬스터와 싸우시겠습니까? (y/n)");

          String? next = stdin.readLineSync()!;
          switch (next) {
            case 'y':
              turn = false;
              
            case 'n':
              play = false;
              turn = false;
          }
          }
        }

        if (character.health <= 0) {
          turn = false;
          play = false;
        }
      }
    }
    print("결과를 저장하시겠습니까? (y/n)");
    String? next = stdin.readLineSync()!;
    if(next == "y"){
    save.writeAsString(character.name +
        "," +
        character.attack.toString() +
        "," +
        character.health.toString() +
        "," +
        character.defense.toString());
    }else{
      print("수고하셨습니다");
      exit(0);
    }  
  }


  getRandomMonster() {
    Random random = Random();
    int randomIndex = random.nextInt(monsters.length);
    return monsters[randomIndex];
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
    monster.monsterHp = monster.monsterHp - attack;
    print("$name이(가) " + monster.monsterName + "에게 $attack의 데미지를 입혔습니다.");
  }

  void defend() {
    health += defense;
    print("$name이(가) 방어 태세를 취하여 $defense 만큼의 체력을 얻었습니다.");
  }

  void showStatus() {
    print(name +
        " - 체력: " +
        health.toString() +
        ", 공격력: " +
        attack.toString() +
        ", 방어력: " +
        defense.toString());
  }
}

//몬스터를 정의하기 위한 클래스
class Monster {
  String monsterName;
  int monsterHp;
  int attackMax;
  int defense;

  Monster(this.monsterName, this.monsterHp, this.attackMax, this.defense);

  attackCharacter(Character character) {
    character.health -= attackMax;
  }

  void showStatus() {
    print(monsterName +
        " - 체력: " +
        monsterHp.toString() +
        ", 공격력: " +
        attackMax.toString());
  }
}

void main() {
  Game().startGame();
}
