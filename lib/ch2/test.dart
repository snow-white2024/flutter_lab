import 'dart:async';

void main() {
  int workTime = 25 ; // 작업 시간: 25분 (초 단위)
  int shortBreakTime = 5 ; // 짧은 휴식: 5분 (초 단위)
  int longBreakTime = 15 ; // 긴 휴식: 15분 (초 단위)
  int currentCycle = 1; // 현재 사이클 (1~4)

  void startPomodoro() {
    print('Pomodoro 타이머를 시작합니다.');

    void startTimer(int duration, String timerType, void Function() onComplete) {
      int remainingTime = duration;
      Timer.periodic(Duration(seconds: 1), (timer) {
        int minutes = remainingTime ~/ 60;
        int seconds = remainingTime % 60;
        print('$timerType: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}');

        remainingTime--;

        if (remainingTime < 0) {
          timer.cancel();
          onComplete();
        }
      });
    }

    void runCycle() {
      print('Cycle $currentCycle 시작');
      startTimer(workTime, '작업 시간', () {
        if (currentCycle % 4 == 0) {
          print('작업 시간이 종료되었습니다. 긴 휴식 시간을 시작합니다.');
          startTimer(longBreakTime, '긴 휴식 시간', () {
            currentCycle = 1; // 사이클 초기화
            print('긴 휴식이 종료되었습니다. 새 사이클을 시작합니다.');
            runCycle();
          });
        } else {
          print('작업 시간이 종료되었습니다. 짧은 휴식 시간을 시작합니다.');
          startTimer(shortBreakTime, '짧은 휴식 시간', () {
            currentCycle++;
            print('짧은 휴식이 종료되었습니다. 다음 사이클을 시작합니다.');
            runCycle();
          });
        }
      });
    }

    runCycle();
  }

  startPomodoro();
}
