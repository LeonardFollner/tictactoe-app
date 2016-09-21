//
//  Logic.swift
//  ProTicTacToe
//
//  Created by Leonard Follner on 21.09.16.
//  Copyright © 2016 Alex Jenke. All rights reserved.
//

import Foundation

class Logic {

    // game variables
    var turns: Int = 0
    
    // cube variables
    var id: Int = 0
    var cubeData: [Int] = []
    var bigCube: Int = 0                                                        // tapped big cube
    var smallCube: Int = 0                                                      // tapped small cube
    var nextCube: Int = 0
    var cubeOwner: Int = 0
    
    // player variables
    var player: Int = 0
    
    func valid_cube() -> Bool {                                                 // checks if tap is valid
        if (bigCube == nextCube) && (cubeOwner == 0) {
            return true
        }else{
            return false
        }
    }
    
    func check(type: String, a: Int, b: Int) -> Bool {                          // checks for won lines
        switch type {
        case "cube":
            if (Data.get_instance().get_data_by_pos(a)[1] == Data.get_instance().get_data_by_pos(b)[1]) && (Data.get_instance().get_data_by_pos(b)[1] == player) {
                return true
            }else{
                return false
            }
        case "game":
            if (Data.get_instance().get_groupdata(a)[1] == Data.get_instance().get_groupdata(b)[1]) && (Data.get_instance().get_groupdata(b)[1] == player) {
                return true
            }else{
                return false
            }
        default:
            return false
        }
    }
    
    func won(cube: Int, type: String) -> Bool {                                 // checks if eather game or a bigCube is won (type)
            switch cube {
            case 111:
                return (check(type, a:112, b:113) || check(type, a:211, b:311) || check(type, a:121, b: 131) ||
                        check(type, a:122, b:133) || check(type, a:212, b:313) || check(type, a:221, b:331) ||
                        check(type, a:222, b:333)
                       )
            case 211:
                return (check(type, a:111, b:311) || check(type, a:212, b:213) || check(type, a:221, b:231) ||
                        check(type, a:222, b:233)
                       )
            case 311:
                return (check(type, a:111, b:211) || check(type, a:312, b:313) || check(type, a:113, b:212) ||
                        check(type, a:221, b:131) || check(type, a:321, b:331) || check(type, a:322, b:333) ||
                        check(type, a:222, b:133)
                )
            case 112:
                return (check(type, a:111, b:113) || check(type, a:212, b:312) || check(type, a:122, b:132) ||
                        check(type, a:222, b:332)
                )
            case 212:
                return (check(type, a:211, b:213) || check(type, a:112, b:312) || check(type, a:222, b:232) ||
                        check(type, a:111, b:313) || check(type, a:113, b:311)
                )
            case 312:
                return (check(type, a:112, b:212) || check(type, a:311, b:313) || check(type, a:322, b:332) ||
                        check(type, a:222, b:132)
                )
            case 113:
                return (check(type, a:111, b:112) || check(type, a:213, b:313) || check(type, a:123, b:133) ||
                        check(type, a:122, b:131) || check(type, a:223, b:333) || check(type, a:212, b:311) ||
                        check(type, a:222, b:331)
                )
            case 213:
                return (check(type, a:211, b:212) || check(type, a:113, b:313) || check(type, a:223, b:233) ||
                        check(type, a:222, b:231)
                )
            case 313:
                return (check(type, a:311, b:312) || check(type, a:213, b:113) || check(type, a:323, b:333) ||
                        check(type, a:111, b:212) || check(type, a:322, b:331) || check(type, a:133, b:223) ||
                        check(type, a:222, b:131)
                )
                
            case 121:
                return (check(type, a:111, b:131) || check(type, a:321, b:221) || check(type, a:122, b:123) ||
                        check(type, a:222, b:323)
                )
            case 221:
                return (check(type, a:121, b:321) || check(type, a:231, b:211) || check(type, a:222, b:223) ||
                        check(type, a:131, b:311) || check(type, a:111, b:331)
                )
            case 321:
                return (check(type, a:331, b:311) || check(type, a:121, b:221) || check(type, a:322, b:323) ||
                        check(type, a:222, b:123)
                    )
            case 122:
                return (check(type, a:121, b:123) || check(type, a:132, b:112) || check(type, a:222, b:322) ||
                        check(type, a:131, b:113) || check(type, a:111, b:133)
                )
            case 222:
                return (check(type, a:111, b:333) || check(type, a:311, b:133) || check(type, a:131, b: 313) ||
                        check(type, a:331, b:113) || check(type, a:122, b:322)  || check(type, a:232, b:212) ||
                        check(type, a:223, b:221)
                )
            case 322:
                return (check(type, a:122, b:222) || check(type, a:332, b:312) || check(type, a:321, b:323) ||
                        check(type, a:331, b:313) || check(type, a:311, b:333)
                )
            case 123:
                return (check(type, a:121, b:122) || check(type, a:323, b:221) || check(type, a:133, b:113) ||
                        check(type, a:222, b:321)
                )
            case 223:
                return (check(type, a:123, b:323) || check(type, a:233, b:213) || check(type, a:223, b:222) ||
                        check(type, a:133, b:313) || check(type, a:113, b:333)
                )
            case 323:
                return (check(type, a:123, b:221) || check(type, a:333, b:313) || check(type, a:321, b:322) ||
                        check(type, a:222, b:121)
                )
              
            case 131:
                return (check(type, a:121, b:111) || check(type, a:132, b:133) || check(type, a:231, b:331) ||
                        check(type, a:113, b:122) || check(type, a:232, b:333) || check(type, a:311, b:223) ||
                        check(type, a:222, b:313)
                )
            case 231:
                return (check(type, a:131, b:331) || check(type, a:332, b:233) || check(type, a:223, b:211) ||
                        check(type, a:222, b:213)
                )
            case 331:
                return (check(type, a:131, b:231) || check(type, a:332, b:333) || check(type, a:321, b:311) ||
                        check(type, a:232, b:133) || check(type, a:223, b:111) || check(type, a:322, b:313) ||
                        check(type, a:222, b:113)
                )
            case 132:
                return (check(type, a:131, b:133) || check(type, a:332, b:232) || check(type, a:122, b:112) ||
                        check(type, a:222, b:312)
                )
            case 232:
                return (check(type, a:132, b:332) || check(type, a:231, b:233) || check(type, a:212, b:222) ||
                        check(type, a:133, b:331) || check(type, a:131, b:333)
                )
            case 332:
                return (check(type, a:132, b:232) || check(type, a:331, b:333) || check(type, a:312, b:322) ||
                        check(type, a:222, b:112)
                )
            case 133:
                return (check(type, a:131, b:132) || check(type, a:233, b:333) || check(type, a:123, b:113) ||
                        check(type, a:111, b:122) || check(type, a:331, b:232) || check(type, a:313, b:223) ||
                        check(type, a:222, b:311)
                )
            case 233:
                return (check(type, a:231, b:232) || check(type, a:133, b:333) || check(type, a:213, b:223) ||
                        check(type, a:222, b:211)
                )
            case 333:
                return (check(type, a:133, b:233) || check(type, a:331, b:332) || check(type, a:313, b:323) ||
                        check(type, a:131, b:232) || check(type, a:113, b:223) || check(type, a:311, b:322) ||
                        check(type, a:222, b:111)
                )
            default:
                return false
            }
    }
    
    func game_over() {
        NSLog("game over")
    }
    
    
    func turn(hash: Int) -> Int {                                                      // one turn
        cubeData = Data.get_instance().get_data_by_hash(hash)
        id = cubeData[1]
        cubeOwner = cubeData[2]
        
        bigCube = id / 1000
        smallCube = id % 1000
        
        if (valid_cube()) {
            turns += 1
            
            cubeOwner = player
            Data.get_instance().set_color_by_hash(hash, color:cubeOwner)
            
            if (Data.get_instance().get_groupdata(bigCube)[1] == 0) && won(smallCube, type: "cube") {
                Data.get_instance().set_groupcolor(id, color:player)
                if won(bigCube, type:"game") {
                    game_over()
                }
            }
            
            if (player == 1) {
                player = 2
            }
            else {
                player = 1
            }
            nextCube = smallCube
        }
        return cubeOwner
    }

}