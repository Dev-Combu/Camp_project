A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.



Command-Line Inferface에서 작동하는 간단한 방식의 RPG게임이다.

![스크린샷 2024-11-07 20 39 14](https://github.com/user-attachments/assets/d5caaed8-973b-48f4-b92b-c68226010869)

처음시작하면 사용자의 이름을 키보드로 입력받는다.
캐릭터의 이름을 제외한 스탯은 캐릭터 파일에 저장되어있는 정보를 읽어와서 사용한다.
이후에 1을 입력하면 공격력만큼의 공격을 , 2를 입력하면 방어력만큼의 체력회복을 하도록한다.

몬스터는 미리 만들어둔 텍스트 파일을 읽어서 랜덤되는 몬스터가 소환되게 했다.

사용자가 죽으면 게임이 끝나고 결과를 저장할 것인지를 묻고 저장을 한다.

사용자가 죽지 않고 몬스터를 물리치면 계속 진행할것인지를 묻고 계속 진행한다.

몬스터를 다 죽이면 게임이 끝난다.
