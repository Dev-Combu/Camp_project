import 'dart:io';


// 게임을 정의하기 위한 클래스
class Game{
  //Character
  //List<Monster>
  //int

  void startGame(){

  }
  void battle(){

  }
  void getRandomMonster(){

  }
}

//캐릭터를 정의하기 위한 클래스 
class Character{
  String name;
  int Hp;
  int Attack;
  int Defend;


  void attackMonster(Monster monster){

  }

  void defend(){

  }

  void showStatus(){}
}

//몬스터를 정의하기 위한 클래스
class Monster{
  String Monster;
  int MonHP;
  int AttackMax;
  int MonDefend;

  void attackCharacter(Character character){

  }

  void showStatus(){

  }

}

void main() {
 File('text/characters.txt').readAsString().then((String contents) {
    print(contents);
  });
}
