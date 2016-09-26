//
//  Save.swift
//  ProTicTacToe
//
//  Created by Leonard Follner on 22.09.16.
//  Copyright © 2016 Alex Jenke. All rights reserved.
//

import Foundation

class Save : NSObject, NSCoding{
    let data: Data
    let logic: Logic
    
    // variables to be saved
    var groupdata: [[Int]]
    var cubedata: [[Int]]
    var free: Bool
    var last: Bool
    var nextCube: Int
    var turns: Int
    
    init(groupdata: [[Int]], cubedata: [[Int]], free: Bool, last: Bool, nextCube: Int, turns: Int) {
        self.data = Data.get_instance()
        self.logic = Logic.get_instance()
        self.groupdata = groupdata
        self.cubedata = cubedata
        self.free = free
        self.last = last
        self.nextCube = nextCube
        self.turns = turns
        
        super.init()
    }
    
    
    // MARK: NSCoding
    
    struct PropertyKey{
        static let groupName = "groupdata"
        static let cubeName = "cubedata"
        
        static let freeName = "free"
        static let lastName = "last"
        static let nextName = "nextCube"
        static let turnsName = "turns"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(groupdata, forKey: PropertyKey.groupName)
        aCoder.encode(cubedata, forKey: PropertyKey.cubeName)
        
        aCoder.encode(free, forKey: PropertyKey.freeName)
        aCoder.encode(last, forKey: PropertyKey.lastName)
        aCoder.encode(nextCube, forKey: PropertyKey.nextName)
        aCoder.encode(turns, forKey: PropertyKey.turnsName)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let groupdata = aDecoder.decodeObject(forKey: PropertyKey.groupName) as! [[Int]]
        let cubedata = aDecoder.decodeObject(forKey: PropertyKey.cubeName) as! [[Int]]
        
        let free = aDecoder.decodeBool(forKey: PropertyKey.freeName)
        let last = aDecoder.decodeBool(forKey: PropertyKey.lastName)
        let nextCube = aDecoder.decodeCInt(forKey: PropertyKey.nextName) as! Int
        let turns = aDecoder.decodeCInt(forKey: PropertyKey.turnsName) as! Int
        
        self.init(groupdata: groupdata, cubedata: cubedata, free: free, last: last, nextCube: nextCube, turns: turns)
    }

    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let path_pttt3d = DocumentsDirectory.appendingPathComponent("protictactoe3d", isDirectory: true)
    
    static let groupdata_path = path_pttt3d.appendingPathExtension("groupdata")
    static let cubedata_path = path_pttt3d.appendingPathExtension("cubedata")
    static let free_path = path_pttt3d.appendingPathExtension("free")
    static let last_path = path_pttt3d.appendingPathExtension("last")
    static let next_path = path_pttt3d.appendingPathExtension("nextCube")
    static let turns_path = path_pttt3d.appendingPathExtension("turns")
}
