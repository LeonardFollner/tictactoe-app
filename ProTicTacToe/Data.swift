//
//  Data.swift
//  ProTicTacToe
//
//  Created by Alex Jenke on 21.09.16.
//  Copyright © 2016 Alex Jenke. All rights reserved.
//

import Foundation

class Data{
    static let instance = Data()
    class func get_instance()-> Data{
        return instance
    }
    
    var cubedata: [[Int]] = Array(repeating: Array(repeating: 0, count: 3), count: 730)
    var groupdata: [[Int]] = Array(repeating: Array(repeating: 0, count: 3), count: 27)

    var cubedata_count : Int = 0
    var groupdata_count : Int = 0
    
    func init_data(){
        cubedata_count = 0
        groupdata_count = 0
        for gx in -1...1 {
            for gy in -1...1 {
                for gz in -1...1 {
                    for x in -1...1 {
                        for y in -1...1 {
                            for z in -1...1 {
                                let pos : Int = (gx+2)*100000+(gy+2)*10000+(gz+2)*1000+(x+2)*100+(y+2)*10+(z+2)
                                Data.get_instance().add(0,pos: pos,color: 0)
                            }
                        }
                    }
                    
                }
            }
        }
        for x in -1...1 {
            for y in -1...1 {
                for z in -1...1 {
                    let pos : Int = (x+2)*100+(y+2)*10+(z+2)
                    Data.get_instance().groupdata[groupdata_count] = [pos,0,0]
                    groupdata_count = groupdata_count+1
                }
            }
        }
        let logic = Logic.get_instance()
        logic.free = true
        logic.last = false
        logic.nextCube = 0
        logic.turns = 0
    }
    
    //MARK: cubedata
    func get_data_by_hash(_ hash: Int) -> [Int]{
        for a in cubedata{
            if (a[0] == hash){
                return a
            }
        }
        return [-1]
    }
    
    func get_data_by_pos(_ pos: Int) -> [Int]{
        for a in cubedata{
            if (a[1] == pos){
                return a
            }
        }
        return [-1]
    }
    
    func set_color_by_hash(_ hash: Int, color: Int){
        for a in 0...cubedata_count-1{
            if (cubedata[a][0] == hash){
                cubedata[a][2] = color
            }
        }
    }
    
    func set_color_by_pos(_ pos: Int, color: Int){
        for a in 0...cubedata_count-1{
            if (cubedata[a][1] == pos){
                cubedata[a][2] = color
            }
        }
    }
    
    func set_hash_by_pos(_ pos: Int, hash: Int){
        for a in 0...cubedata_count-1{
            if (cubedata[a][1] == pos){
                cubedata[a][0] = hash
            }
        }
    }

    
    //MARK: groupdata
    
    func get_groupdata(_ pos: Int) -> [Int]{
        for a in groupdata{
            if (a[0] == pos){
                return a
            }
        }
        return [-1]
    }
    
    func set_groupcolor(_ pos: Int, color: Int){
        for a in 0...groupdata_count-1{
            if (groupdata[a][0] == pos){
                groupdata[a][1] = color
            }
        }
    }
    
    func increase_groupnumber(_ pos: Int) {
        for a in 0...groupdata_count-1 {
            if (groupdata[a][0] == pos) {
                var count = groupdata[a][2]
                count = count + 1
                groupdata[a][2] = count
            }
        }
    }
    

    //MARK: add
    func add(_ hash: Int, pos: Int, color: Int){
        cubedata[cubedata_count] = [hash,pos,color]
        cubedata_count = cubedata_count+1
    }
    
    //MARK: NSCoding
    func save_game() {
        let logic = Logic.get_instance()
        NSKeyedArchiver.archiveRootObject(groupdata, toFile: Save.groupdata_path.path)
        NSKeyedArchiver.archiveRootObject(cubedata, toFile: Save.cubedata_path.path)
        NSKeyedArchiver.archiveRootObject(logic.free, toFile: Save.free_path.path)
        NSKeyedArchiver.archiveRootObject(logic.last, toFile: Save.last_path.path)
        NSKeyedArchiver.archiveRootObject(logic.nextCube, toFile: Save.next_path.path)
        NSKeyedArchiver.archiveRootObject(logic.turns, toFile: Save.turns_path.path)
    }
    func load_game(){
        cubedata = (NSKeyedUnarchiver.unarchiveObject(withFile: Save.cubedata_path.path) as? [[Int]])!
        groupdata = (NSKeyedUnarchiver.unarchiveObject(withFile: Save.groupdata_path.path) as? [[Int]])!
        groupdata_count = 27
        cubedata_count = 730
        
        let logic = Logic.get_instance()
        logic.free = (NSKeyedUnarchiver.unarchiveObject(withFile: Save.free_path.path) as? Bool)!
        logic.last = (NSKeyedUnarchiver.unarchiveObject(withFile: Save.last_path.path) as? Bool)!
        logic.nextCube = (NSKeyedUnarchiver.unarchiveObject(withFile: Save.next_path.path) as? Int)!
        logic.turns = (NSKeyedUnarchiver.unarchiveObject(withFile: Save.turns_path.path) as? Int)!
        
    }
}
