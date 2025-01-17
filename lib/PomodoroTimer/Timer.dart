import 'dart:async'; // 비동기 작업과 Timer 사용을 위한 라이브러리

void main() {
  int workDurationInMinutes = 25; // 각 작업 세션의 시간(분 단위) -> 25분
  int shortBreakDurationInMinutes = 5; // 짧은 휴식 시간(분 단위) -> 5분
  int longBreakDurationInMinutes = 15; // 긴 휴식 시간(분 단위) -> 15분
  int numberOfSessions = 3; // 긴 휴식 전에 실행할 작업 세션 수

  int currentSession = 1; // 현재 세션 번호를 추적하는 변수 (1부터 시작)
  bool isWorkSession = true; // 현재 세션이 작업 세션인지 여부를 나타내는 플래그
  int counterInSeconds = workDurationInMinutes * 60; // 현재 카운터를 초 단위로 초기화 (작업 시간)

  // 매 1초마다 실행되는 Timer.periodic 설정
  Timer.periodic(const Duration(seconds: 1), (timer) {
    // 남은 시간을 계산 (분과 초로 나눔)
    int remainingMinutes = counterInSeconds ~/ 60; // 남은 분 계산
    int remainingSeconds = counterInSeconds % 60; // 남은 초 계산

    // 남은 시간을 "MM:SS" 형식으로 포맷
    String formattedTime =
        '${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';

    // 현재 세션 유형(작업 또는 휴식)과 남은 시간을 출력
    String sessionType = isWorkSession ? 'Work' : 'Break'; // 현재 세션 유형 결정
    print('Pomodoro $sessionType Session $currentSession: $formattedTime');

    counterInSeconds--; // 1초 감소

    // 카운터가 0보다 작아지면 세션 종료 처리
    if (counterInSeconds < 0) {
      if (isWorkSession) {
        // 작업 세션 종료 시
        if (currentSession % numberOfSessions == 0) {
          // 현재 세션 번호가 설정된 세션 수와 같으면 긴 휴식 실행
          print('Long break time!');
          counterInSeconds = longBreakDurationInMinutes * 60; // 긴 휴식 시간으로 카운터 재설정
        } else {
          // 그렇지 않으면 짧은 휴식 실행
          print('Short break time!');
          counterInSeconds = shortBreakDurationInMinutes * 60; // 짧은 휴식 시간으로 카운터 재설정
        }
        isWorkSession = false; // 다음 세션을 휴식 세션으로 설정
      } else {
        // 휴식 세션 종료 시
        currentSession++; // 세션 번호 증가
        if (currentSession > numberOfSessions) {
          // 모든 세션이 완료되면 타이머 종료
          print('All sessions are over');
          timer.cancel(); // 타이머 중지
        } else {
          // 다음 작업 세션 실행
          print('Work session time!');
          counterInSeconds = workDurationInMinutes * 60; // 작업 시간으로 카운터 재설정
          isWorkSession = true; // 다음 세션을 작업 세션으로 설정
        }
      }
    }
  });
}



//회고 백승호 : 이번 퀘스트를 통해서 이해가 두루뭉실한 다트언어를 조금더 구체화해서 이해할 수 있었습니다. 또한 파트너 남병님과 함께 할일을 나누어 작업함으로 주어진 시간안에 완수할 수 있었습니다.
//    채남병 : 무엇을 배웠는지 자신이 없었지만, 결과물을 하나 만들어 냈다는 것이 신기하기도 하고 해낼 수 있겠다는 자신감을 주었습니다.
