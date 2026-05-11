#NoTrayIcon
SetDefaultMouseSpeed 0 ; 마우스 이동을 즉시 실행하여 속도 향상

; 1. iD Mixer 실행 상태 확인 및 활성화
if !WinExist("ahk_exe iD.exe") {
    Run "C:\Program Files\Audient\iD\iD.exe"
    if !WinWait("ahk_exe iD.exe", , 15) {
        ExitApp
    }
}

WinActivate "ahk_exe iD.exe"
WinWaitActive "ahk_exe iD.exe"
Sleep 800 ; UI가 완전히 그려질 때까지 대기

; 2. 페이더 이미지 인식
if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "*60 target.png") {
    ; 찾은 이미지 위치(페이더 노브)를 클릭하여 포커스
    Click FoundX + 20, FoundY + 20
    Sleep 100

    ; 3. 마우스 휠 40회 연타 (한 바퀴 이상 넉넉하게)
    Loop 40 { ; 휠 횟수로 볼륨 조절도 가능
        Send "{WheelUp}"
        Sleep 10 ; 믹서가 명령을 놓치지 않게 아주 짧은 간격 부여
    }
} else {
    ; 인식이 안 될 경우를 대비해 1회 더 시도하거나 알림 (컴파일 후엔 생략 가능)
    ; MsgBox "이미지를 찾을 수 없습니다." 
}

; 4. 정리 및 종료
Sleep 300
WinMinimize "ahk_exe iD.exe" ; 믹서 창을 최소화만 하려면 WinMinimize로 수정
ExitApp