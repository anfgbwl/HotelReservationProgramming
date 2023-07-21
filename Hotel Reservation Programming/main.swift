//
//  main.swift
//  Hotel Rreservation Programming
//
//  Created by t2023-m0076 on 2023/07/20.
//

import Foundation

print("---------------------------")
print("<호텔 예약 관리 프로그램>")

let programList = ["1. 랜덤 금액 받기", "2. 객실 정보 보기", "3. 객실 예약 하기", "4. 나의 예약 보기", "5. 나의 예약 보기(체크인 날짜 기준)", "9. 나의 잔고 보기", "0. 프로그램 종료하기"]
let roomSpec = [1 : 10000, 2 : 20000, 3 : 30000, 4 : 40000, 5 : 50000]
let sortedRoomSpec = roomSpec.keys.sorted()
let dataFormatter = DateFormatter()
    dataFormatter.dateFormat = "yyyy-MM-dd"

struct Reservation {
    let roomNumber: Int
    let checkInDate: Date
    let checkOutDate: Date
}

var reservationRoom: [Int] = []
var reservations: [Reservation] = []
var myWallet: Int = 0


for listNumber in programList {
    print(listNumber)
}
print("---------------------------")
print("번호를 입력해주세요")

var input = Int(readLine()!)

repeat {
    
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
        
//        for (roomNumber, price) in roomSpec {
//            print("\(roomNumber)번방 : \(price)원")
//        }
//
        
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
         (OK) 1. 날짜 입력 형태 검증(YYYY-MM-DD)
         (OK) 2. 예약 날짜 저장(체크인, 체크아웃 나눠서 저장)
         **(어려움) 3. 방 개수를 한정하여, 예약이 꽉 찼을 시 예약이 불가능하다 또는 객실 정보를 불러오지 않기
        */
         
        print("체크인 날짜를 입력해주세요.(ex. YYYY-MM-DD)")
        var inputCheckInDate = readLine()
        
        while inputCheckInDate == nil || (dataFormatter.date(from: inputCheckInDate!) == nil) {
            print("잘못 입력하였습니다. 올바른 날짜를 입력해주세요.(ex. YYYY-MM-DD)")
            inputCheckInDate = readLine()
        }
        
        print("---------------------------")
        print("체크아웃 날짜를 입력해주세요.(ex. YYYY-MM-DD)")
        var inputCheckOutDate = readLine()
        
        while inputCheckOutDate == nil || (dataFormatter.date(from: inputCheckOutDate!) == nil) {
            print("잘못 입력하였습니다. 올바른 날짜를 입력해주세요.(ex. YYYY-MM-DD)")
            inputCheckOutDate = readLine()
        }
        
        if let date1: Date = dataFormatter.date(from: inputCheckInDate!),
           let date2: Date = dataFormatter.date(from: inputCheckOutDate!) {
            
            var newDate2: Date = date2
            
            while date1 >= newDate2 {
                print("체크인 날짜보다 이전 날짜를 선택할 수 없습니다. 날짜를 확인해주세요.")
                inputCheckOutDate = readLine()
                
                if let finalCheckOutDate = dataFormatter.date(from: inputCheckOutDate!) {
                    newDate2 = finalCheckOutDate
                }
            }
            
//            repeat {
//                switch date1.compare(date2) {
//                case .orderedSame:
//                    print("체크인 날짜와 같습니다. 날짜를 확인해주세요.")
//                    inputCheckOutDate = readLine()
//                    let newDate2: Date = dataFormatter.date(from: inputCheckOutDate!) {
//                        date2 = newDate2
//                    }
//                case .orderedDescending:
//                    print("체크인 날짜보다 이전 날짜를 선택할 수 없습니다. 날짜를 확인해주세요.")
//                    inputCheckOutDate = readLine()
//                case .orderedAscending:
//                    continue
//                }
//                break
//            } while true
        }
        
        
        print("---------------------------")
        print("선택된 일정은 다음과 같습니다.")
        print("체크인 : \(inputCheckInDate!)")
        print("체크아웃 : \(inputCheckOutDate!)")
        
        print("---------------------------")
        for roomNumber in sortedRoomSpec {
            if let price = roomSpec[roomNumber] {
                print("\(roomNumber)번방 : \(price)원")
            }
        }
        
        print("---------------------------")
        print("예약하실 객실 번호를 선택해주세요.")
        
        var inputRoomNumber = Int(readLine()!)
        
        while inputRoomNumber == nil || !sortedRoomSpec.contains(inputRoomNumber!) {
            print("잘못 입력하였습니다. 올바른 객실 번호를 입력해주세요.")
            inputRoomNumber = Int(readLine()!)
        }
        
        print("---------------------------")
        print("\(inputRoomNumber!)번방을 선택하였습니다.")
        
        if let price = roomSpec[inputRoomNumber!] {
            if myWallet >= price {
                myWallet -= price
                
                print("예약을 완료하였습니다.")
                print("현재 잔고는 \(myWallet)원 입니다.")
                
                reservationRoom.append(inputRoomNumber!)
                
                if let checkInDate = dataFormatter.date(from: inputCheckInDate!),
                   let checkOutDate = dataFormatter.date(from: inputCheckOutDate!) {
                    let reservation = Reservation(roomNumber: inputRoomNumber!, checkInDate: checkInDate, checkOutDate: checkOutDate)
                    reservations.append(reservation)
                }
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
        for reservation in reservations {
            print("객실 : \(reservation.roomNumber)번방")
            print("체크인: \(dataFormatter.string(from: reservation.checkInDate))")
            print("체크아웃: \(dataFormatter.string(from: reservation.checkOutDate))")
        }
        print("---------------------------")
        print("번호를 입력해주세요")
        input = Int(readLine()!)
    }
    
    if input == 5 {
        print("---------------------------")
        print("<나의 예약 보기(체크인 날짜 기준)>")
        let sortedReservations = reservations.sorted {$0.checkInDate < $1.checkInDate}
        for sortedReservations in sortedReservations {
            print("객실 : \(sortedReservations.roomNumber)번방")
            print("체크인: \(dataFormatter.string(from: sortedReservations.checkInDate))")
            print("체크아웃: \(dataFormatter.string(from: sortedReservations.checkOutDate))")
        }
        print("---------------------------")
        print("번호를 입력해주세요")
        input = Int(readLine()!)
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
        print("---------------------------")
        print("프로그램을 종료합니다.")
        print("---------------------------")
        break
    }
    
    else {
        print("잘못된 번호를 입력하였습니다.")
        print("---------------------------")
        print("번호를 입력해주세요")
        input = Int(readLine()!)
    }
} while true
