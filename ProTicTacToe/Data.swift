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
    
    var cubedata: [[Int]] = Array(count: 730, repeatedValue: Array(count: 3, repeatedValue: 0))
    var groupdata: [[Int]] = Array(count: 27, repeatedValue: Array(count: 3, repeatedValue: 0))

    var cubedata_count : Int = 0
    var groupdata_count : Int = 0
    
    func init_data(){
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
                    Data.get_instance().groupdata[groupdata_count][0] = pos
                    groupdata_count = groupdata_count+1
                }
            }
        }
    }
    
    //MARK: cubedata
    func get_data_by_hash(hash: Int) -> [Int]{
        for a in cubedata{
            if (a[0] == hash){
                return a
            }
        }
        return [-1]
    }
    
    func get_data_by_pos(pos: Int) -> [Int]{
        for a in cubedata{
            if (a[1] == pos){
                return a
            }
        }
        return [-1]
    }
    
    func set_color_by_hash(hash: Int, color: Int){
        for a in 0...cubedata_count-1{
            if (cubedata[a][0] == hash){
                cubedata[a][2] = color
            }
        }
    }
    
    func set_color_by_pos(pos: Int, color: Int){
        for a in 0...cubedata_count-1{
            if (cubedata[a][1] == pos){
                cubedata[a][2] = color
            }
        }
    }
    
    func set_hash_by_pos(pos: Int, hash: Int){
        for a in 0...cubedata_count-1{
            if (cubedata[a][1] == pos){
                cubedata[a][0] = hash
            }
        }
    }

    
    //MARK: groupdata
    
    func get_groupdata(pos: Int) -> [Int]{
        for a in groupdata{
            if (a[0] == pos){
                return a
            }
        }
        return [-1]
    }
    
    func set_groupcolor(pos: Int, color: Int){
        for a in 0...groupdata_count-1{
            if (groupdata[a][0] == pos){
                groupdata[a][1] = color
            }
        }
    }
    
    func increase_groupnumber(pos: Int) {
        for a in 0...groupdata_count-1 {
            if (groupdata[a][0] == pos) {
                var count = groupdata[a][2]
                count = count + 1
                groupdata[a][2] = count
            }
        }
    }
    

    //MARK: add
    func add(hash: Int, pos: Int, color: Int){
        cubedata[cubedata_count] = [hash,pos,color]
        cubedata_count = cubedata_count+1
    }
    
    //MARK: NSCoding
    func save_game() {
        let logic = Logic.get_instance()
        NSKeyedArchiver.archiveRootObject(groupdata, toFile: Save.groupdata_path.path!)
        NSKeyedArchiver.archiveRootObject(cubedata, toFile: Save.cubedata_path.path!)
        NSKeyedArchiver.archiveRootObject(logic.free, toFile: Save.free_path.path!)
        NSKeyedArchiver.archiveRootObject(logic.last, toFile: Save.last_path.path!)
        NSKeyedArchiver.archiveRootObject(logic.nextCube, toFile: Save.next_path.path!)
        NSKeyedArchiver.archiveRootObject(logic.turns, toFile: Save.turns_path.path!)
    }
    func load_game(){
        print(NSKeyedUnarchiver.unarchiveObjectWithFile(Save.groupdata_path.path!) as? [[Int]])
    }
}