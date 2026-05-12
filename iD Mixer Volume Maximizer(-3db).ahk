#NoTrayIcon
SetDefaultMouseSpeed 0

; 1. 프로그램 실행 및 트레이 아이콘 대기 루프
if !ProcessExist("iD.exe") {
    Run "C:\Program Files\Audient\iD\iD.exe"
}

; 트레이 아이콘이 나타날 때까지 최대 20초간 반복 탐색 (2초 간격)
Loop 10 {
    if ImageSearch(&TX, &TY, 0, 0, A_ScreenWidth, A_ScreenHeight, "*10 tray_icon.png") {
        Click TX + 10, TY +10, 2 ; 아이콘 찾으면 더블 클릭
        Break ; 루프 탈출
	} else {
    	MsgBox "화면 전체에서 트레이 아이콘을 찾을 수 없습니다. 이미지 파일을 확인하세요."
	}
    
    ; 4회차(8초)까지 못 찾으면 프로그램을 한 번 더 실행 시도 (창 호출 목적)
    if (A_Index == 4) {
        Run "C:\Program Files\Audient\iD\iD.exe"
    }
    
    Sleep 2000
}

; 2. 창 활성화 확인 및 전면 배치
if WinWait("ahk_exe iD.exe", , 5) {
    WinShow "ahk_exe iD.exe"
    WinRestore "ahk_exe iD.exe"
    WinActivate "ahk_exe iD.exe"
    WinWaitActive "ahk_exe iD.exe", , 3
    Sleep 1000 ; UI가 그려질 시간 부여
} else {
    ExitApp ; 창이 끝내 안 열리면 종료
}

; 3. 메인 페이더 이미지 검색 및 휠 조작
if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "*30 target.png") {
    Click FoundX + 10, FoundY + 10
    Sleep 200

    ; 넉넉하게 40회 휠 업
    Loop 40 {
        Send "{WheelUp}"
        Sleep 10
    }
    Loop 3 {
        Send "{WheelDown}"
        Sleep 10
    }
}

; 4. 창 닫기 및 종료
Sleep 300
WinClose "ahk_exe iD.exe"
ExitApp