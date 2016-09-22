//
//  Cube.swift
//  ProTicTacToe
//
//  Created by Alex Jenke on 21.09.16.
//  Copyright © 2016 Alex Jenke. All rights reserved.
//

import Foundation
import SceneKit

class Cube {
    
    class func draw_cube() -> SCNNode {
        
        let cube = SCNNode()
        for gx in -1...1 {
            for gy in -1...1 {
                for gz in -1...1 {
                    for x in -1...1 {
                        for y in -1...1 {
                            for z in -1...1 {
                                
                                let xf = Float(x*4+gx*22)
                                let yf = Float(y*4+gy*22)
                                let zf = Float(z*4+gz*22)
                                
                                let pos : Int = (gx+2)*100000+(gy+2)*10000+(gz+2)*1000+(x+2)*100+(y+2)*10+(z+2)
                                let data = Data.get_instance().get_data_by_pos(pos)
                                //create Cube
                                let color = data[2]
                                let box = SCNBox(width: 2,height:  2,length:  2,chamferRadius:  0.2)
                                switch(color){
                                case 0:
                                    box.firstMaterial!.diffuse.contents = UIColor.grayColor()
                                    break
                                case 1:
                                    box.firstMaterial!.diffuse.contents = UIColor.blueColor()
                                    break
                                case 2:
                                    box.firstMaterial!.diffuse.contents = UIColor.redColor()
                                    break
                                default:
                                    break
                                }
                                box.firstMaterial!.specular.contents = UIColor.whiteColor()
                                box.firstMaterial!.transparency = 0.8
                                //add to scene
                                let Node = SCNNode(geometry: box)
                                Node.position = SCNVector3Make(xf,yf,zf)
                                cube.addChildNode(Node)
                                //add to data
                                Data.get_instance().set_hash_by_pos(pos, hash: Node.hash)
                            }
                        }
                    }
                    
                }
            }
        }
        
        return cube
    }
    
    
    class func draw_sidecube() -> SCNNode {
    let cube = SCNNode()
    for x in -1...1 {
        for y in -1...1 {
            for z in -1...1 {
                let xf = Float(x*22)
                let yf = Float(y*22)
                let zf = Float(z*22)
                
                let pos : Int = (x+2)*100+(y+2)*10+(z+2)
                let data = Data.get_instance().get_groupdata(pos)
                //create Cube
                let color = data[1]
                let box = SCNBox(width: 10,height:  10,length:  10,chamferRadius:  1)
                switch(color){
                    case 0:
                        box.firstMaterial!.diffuse.contents = UIColor.grayColor()
                        break
                    case 1:
                        box.firstMaterial!.diffuse.contents = UIColor.blueColor()
                        break
                    case 2:
                            box.firstMaterial!.diffuse.contents = UIColor.redColor()
                        break
                    default:
                        break
                }
                if(pos == Logic.get_instance().nextCube && Logic.get_instance().free == false){
                    box.firstMaterial!.emission.contents = UIColor.darkGrayColor()
                }
                box.firstMaterial!.specular.contents = UIColor.whiteColor()
                box.firstMaterial!.transparency = 0.8
                //add to scene
                let Node = SCNNode(geometry: box)
                Node.position = SCNVector3Make(xf,yf,zf)
                cube.addChildNode(Node)
            }
        }
    }
    return cube
    }
}