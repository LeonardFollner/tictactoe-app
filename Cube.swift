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
    
    class func redraw_cube() -> SCNNode {
        let cube = SCNNode()
        for x in -1...1 {
            for y in -1...1 {
                for z in -1...1 {
                    
                    let xf = Float(x*22)
                    let yf = Float(y*22)
                    let zf = Float(z*22)
                    
                    nodeWithNode(bigcube(), molecule: cube, position: SCNVector3Make(xf, yf, zf))
                }
            }
        }
        
        return cube
    }
    
    class func nodeWithAtom(atom: SCNGeometry, molecule: SCNNode, position: SCNVector3) -> SCNNode {
        let node = SCNNode(geometry: atom)
        node.position = position
        molecule.addChildNode(node)
        return node
    }
    
    class func nodeWithNode(node: SCNNode, molecule: SCNNode, position: SCNVector3) -> SCNNode {
        node.position = position
        molecule.addChildNode(node)
        return node
    }
    
    class func cube() -> SCNGeometry {
        let cube = SCNBox(width: 2,height:  2,length:  2,chamferRadius:  0.2)
        //TODO delete random color
        let col : Int = Int(arc4random_uniform(3))
        switch(col){
        case 0:
            cube.firstMaterial!.diffuse.contents = UIColor.redColor()
            break
        case 1:
            cube.firstMaterial!.diffuse.contents = UIColor.blueColor()
            break
        case 2:
            cube.firstMaterial!.diffuse.contents = UIColor.grayColor()
            break
        default:
            break
        }
        //------------------------
        cube.firstMaterial!.specular.contents = UIColor.whiteColor()
        cube.firstMaterial!.transparency = 0.8
        Data.get_instance().add(cube.hash,pos: 1,color: col)
        
        return cube
    }
    
    class func bigcube() -> SCNNode {
        let bigcube = SCNNode()
        
        for x in -1...1 {
            for y in -1...1 {
                for z in -1...1 {
                    
                    let xf = Float(x*4)
                    let yf = Float(y*4)
                    let zf = Float(z*4)
                    
                    let carbonNode = SCNNode(geometry: cube())
                    carbonNode.position = SCNVector3Make(xf,yf,zf)
                    bigcube.addChildNode(carbonNode)
                }
            }
        }
        
        return bigcube
    }

}

