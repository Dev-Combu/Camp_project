import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:csv/csv.dart';

getCharacterName() {
  print("캐릭터의 이름을 입려하세요: ");
  String? inumber;
  RegExp exp = RegExp(r'^[a-zA-Z가-힣]+$');

  bool loop = true;
  while (loop) {
    inumber = stdin.readLineSync()!;
    var match = exp.hasMatch(inumber);
    if (inumber! == null) {
      print("문자를 입력해주십시오");
    } else {
      if (match) {
        loop = false;
        return inumber;
      } else {
        print("한글, 영문 대소문자만 사용가능합니다. ");
      }
    }
  }
}

loadCharacterStats() {
  try {
    final file = File('lib/characters.txt');
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
  try {
    final file = File('lib/monsters.txt');
    final contents = file.readAsStringSync();
    final mons = contents.split('/n');
    final stats = mons[1].split(',');
    if (stats.length != 3) throw FormatException('Invalid monster data');

    String monsterName = stats[0];
    int monsterHp = int.parse(stats[1]);
    int attackMax = int.parse(stats[2]);

    Monster monster = Monster(monsterName, monsterHp, attackMax);
    return monster;
  } catch (e) {
    print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

// 게임을 정의하기 위한 클래스
class Game {
  //List<List<Monster>>
  //int

  startGame() {
    loadCharacterStats();
    //loadMonsterStats();
    //   print(character.toString());
    //   print("캐릭터 이름을 입력하세요 :");
    //   String? cname = stdin.readLineSync()!;
    //   print("게임을 시작합니다.");
    //   print("$cname - 체력: $character, 공격력: $character, 방어력: $character");
  }

  void battle() {}
  void getRandomMonster() {}
}

//캐릭터를 정의하기 위한 클래스
class Character {
  String name;
  int health;
  int attack;
  int defense;

  Character(this.name, this.health, this.attack, this.defense);

  void attackMonster(Monster monster) {}

  void defend() {}
  void showStatus() {}
}

//몬스터를 정의하기 위한 클래스
class Monster {
  String monsterName;
  int monsterHp;
  int attackMax;

  Monster(this.monsterName, this.monsterHp, this.attackMax);

  void attackCharacter(Character character) {}

  void showStatus() {}
}

void main() {
  Game().startGame();
}
