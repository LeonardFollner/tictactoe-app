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
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(groupdata, forKey: PropertyKey.groupName)
        aCoder.encodeObject(cubedata, forKey: PropertyKey.cubeName)
        
        aCoder.encodeBool(free, forKey: PropertyKey.freeName)
        aCoder.encodeBool(last, forKey: PropertyKey.lastName)
        aCoder.encodeInteger(nextCube, forKey: PropertyKey.nextName)
        aCoder.encodeInteger(turns, forKey: PropertyKey.turnsName)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let groupdata = aDecoder.decodeObjectForKey(PropertyKey.groupName) as! [[Int]]
        let cubedata = aDecoder.decodeObjectForKey(PropertyKey.cubeName) as! [[Int]]
        
        let free = aDecoder.decodeBoolForKey(PropertyKey.freeName)
        let last = aDecoder.decodeBoolForKey(PropertyKey.lastName)
        let nextCube = aDecoder.decodeIntForKey(PropertyKey.nextName) as! Int
        let turns = aDecoder.decodeIntForKey(PropertyKey.turnsName) as! Int
        
        self.init(groupdata: groupdata, cubedata: cubedata, free: free, last: last, nextCube: nextCube, turns: turns)
    }

    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("protictactoe")
}