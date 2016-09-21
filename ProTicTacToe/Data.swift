//
//  Data.swift
//  ProTicTacToe
//
//  Created by Alex Jenke on 21.09.16.
//  Copyright © 2016 Alex Jenke. All rights reserved.
//

import Foundation

class Data {
    static let instance = Data()
    class func get_instance()-> Data{
        return instance
    }
    
    var cubedata: [[Int]] = Array(count: 730, repeatedValue: Array(count: 2, repeatedValue: 0))
    var groupdata: [[Int]] = Array(count: 27, repeatedValue: Array(count: 1, repeatedValue: 0))

    var cubedata_count : Int = 0
    var groupdata_count : Int = 0
    
    
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
        for a in 0...cubedata_count{
            if (cubedata[a][0] == hash){
                cubedata[a][2] = color
            }
        }
    }
    
    func set_color_by_pos(pos: Int, color: Int){
        for a in 0...cubedata_count{
            if (cubedata[a][1] == pos){
                cubedata[a][2] = color
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
        for a in 0...groupdata_count{
            if (groupdata[a][0] == pos){
                groupdata[a][1] = color
            }
        }
    }
    

    //MARK: add
    func add(hash: Int, pos: Int, color: Int){
        groupdata[groupdata_count] = [hash,pos,color]
        groupdata_count = groupdata_count+1
    }
    
}