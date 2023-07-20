//
//  main.swift
//  Hotel Rreservation Programming
//
//  Created by t2023-m0076 on 2023/07/20.
//

import Foundation

print("---------------------------")
print("<호텔 예약 관리 프로그램>")

let programList = ["1. 랜덤 금액 받기", "2. 객실 정보 보기", "3. 객실 예약 하기", "4. 나의 예약 보기", "9. 나의 잔고 보기"]
let roomSpec = [1 : 10000, 2 : 20000, 3 : 30000, 4 : 40000, 5 : 50000]
let sortedRoomSpec = roomSpec.keys.sorted()
var myWallet: Int = 0

for listNumber in programList {
    print(listNumber)
}
print("---------------------------")
print("번호를 입력해주세요")

var input = Int(readLine()!)

while true {
    
    /*
    <개선 사항>
     1. 번호 입력 후 다시 동일한 번호를 누르거나 그보다 앞선 번호를 입력하면 else 값이 나옴
     **(어려움) 2. 번호 선택 이전으로 돌아가는 기능 구현
    */
    
    if input == 1 {
        print("---------------------------")
        print("<랜덤 금액 받기>")
        let money = Int.random(in: 10...50)
        myWallet += (money * 10000)
        print("랜덤 지급 금액 : \(money*10000)원")
        print("현재 나의 잔고 : \(myWallet)원")
        print("---------------------------")
        print("번호를 입력해주세요")
        input = Int(readLine()!)
    }
    
    if input == 2 {
        print("---------------------------")
        print("<객실 정보 보기>")
        for roomNumber in sortedRoomSpec {
            if let price = roomSpec[roomNumber] {
                print("\(roomNumber)번방 : \(price)원")
            }
        }
        print("---------------------------")
        print("번호를 입력해주세요")
        input = Int(readLine()!)
    }
    
    if input == 3 {
        print("---------------------------")
        print("<객실 예약 하기>")
        
        /*
        <개선 사항>
         1. 날짜 입력 형태 검증(YYYY-MM-DD)
         2. 예약 날짜 저장(체크인, 체크아웃 나눠서 저장)
         **(어려움) 3. 방 개수를 한정하여, 예약이 꽉 찼을 시 예약이 불가능하다 또는 객실 정보를 불러오지 않기
        */
         
        print("체크인 날짜를 입력해주세요.(ex. 2023-07-20)")
        var inputCheckInDate = readLine()
        print("체크아웃 날짜를 입력해주세요.(ex. 2023-07-20)")
        var inputCheckOutDate = readLine()
        print("---------------------------")
             
        for roomNumber in sortedRoomSpec {
            if let price = roomSpec[roomNumber] {
                print("\(roomNumber)번방 : \(price)원")
            }
        }
        print("---------------------------")
        print("예약하실 객실 번호를 선택해주세요.")
        var inputRoomNumber = Int(readLine()!)
        
        print("---------------------------")
        print("\(inputRoomNumber!)번방을 선택하였습니다.")
        
        if let price = roomSpec[inputRoomNumber!] {
            if myWallet >= price {
                myWallet -= price
                print("예약을 완료하였습니다.")
                print("현재 잔고는 \(myWallet)원 입니다.")
            } else {
                print("예약이 불가능합니다.")
                print("현재 잔고는 \(myWallet)원 입니다.")
            }
        }
        print("---------------------------")
        print("번호를 입력해주세요")
        input = Int(readLine()!)
    }
    
    if input == 4 {
        print("---------------------------")
        print("<나의 예약 보기>")
    }
    
    if input == 9 {
        print("---------------------------")
        print("<나의 잔고 보기>")
        print("현재 \(myWallet)원 입니다.")
        print("---------------------------")
        print("번호를 입력해주세요")
        input = Int(readLine()!)
    }
    
    if input == 0 {
        break
    }
    
    else {
        print("잘못된 번호를 입력하였습니다.")
        print("---------------------------")
        print("번호를 입력해주세요")
        input = Int(readLine()!)
    }
}
