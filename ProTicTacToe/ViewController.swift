//
//  ViewController.swift
//  ProTicTacToe
//
//  Created by Alex Jenke on 21.09.16.
//  Copyright © 2016 Alex Jenke. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    // UI
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var sideView: SCNView!
    
    // main
    var mainNode: SCNNode = SCNNode()
    var sideNode: SCNNode = SCNNode()
    let logic = Logic.get_instance()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        sceneSetup()
        sideSetup()
        mainNode = Cube.draw_cube()
        sceneView.scene!.rootNode.addChildNode(mainNode)
        sideNode = Cube.draw_sidecube()
        sideView.scene!.rootNode.addChildNode(sideNode)
        
        sideView.pointOfView!.runAction(.repeatActionForever(.customActionWithDuration(10, actionBlock: { node, progress in
            self.syncronizeViews()
        })))
        sideView.playing = true
        
        
    }

    func sideSetup() {
        let side = SCNScene()
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
        side.rootNode.addChildNode(ambientLightNode)
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLightTypeOmni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 50, 50)
        side.rootNode.addChildNode(omniLightNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 50)
        cameraNode.camera?.xFov=110.0
        
        side.rootNode.camera = cameraNode.camera
        side.rootNode.addChildNode(cameraNode)
        
        side.rootNode.camera?.automaticallyAdjustsZRange = true
        
        sideView.scene = side
        sideView.allowsCameraControl = false

    }
    
    // MARK: Scene
    func sceneSetup() {
        
        Data.get_instance().init_data()
        let scene = SCNScene()
        
        sceneView.allowsCameraControl = true
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLightTypeOmni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 50, 50)
        scene.rootNode.addChildNode(omniLightNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 50)
        cameraNode.camera?.xFov=110.0
        
        scene.rootNode.camera = cameraNode.camera
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.camera?.automaticallyAdjustsZRange = true
        
        let singletap = UITapGestureRecognizer(target: self, action: #selector(ViewController.taped(_:)))
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(ViewController.doubletaped(_:)))
        let cheat = UITapGestureRecognizer(target: self, action: #selector(ViewController.cheat(_:)))
        cheat.numberOfTapsRequired=2
        cheat.numberOfTouchesRequired=2
        doubletap.numberOfTapsRequired = 2
        singletap.requireGestureRecognizerToFail(doubletap)
        
        sceneView.addGestureRecognizer(singletap)
        sceneView.addGestureRecognizer(doubletap)
        sceneView.addGestureRecognizer(cheat) //activate to enable cheating //TODO
        sceneView.scene = scene
        
    }
    
    func doubletaped(sender: UITapGestureRecognizer) {
        
        let move = SCNAction.moveTo(SCNVector3Make(0, 0, 50), duration: 0.7)
        let look = SCNAction.rotateToX(0, y: 0, z: 0, duration: 0.7)
        
        let prev = sceneView.pointOfView!.camera!.xFov
        sceneView.pointOfView!.runAction(.customActionWithDuration(0.3, actionBlock: { node, progress in
            node.camera?.xFov = prev + (110-prev)/0.3*Double(progress)
        }))
        sceneView.pointOfView!.runAction(move)
        sceneView.pointOfView!.runAction(look)
        
        sceneView.playing = true
        
        
    }
    
    
    func cheat(sender: UITapGestureRecognizer){
        if(logic.cheat){
            logic.cheat = false
            NSLog("cheat off")
        }else{
            logic.cheat = true
            NSLog("cheat on")
        }
        doubletaped(sender)
    }
    
    func taped(sender: UITapGestureRecognizer) {
        let location: CGPoint = sender.locationInView(self.sceneView)
        let hits = self.sceneView.hitTest(location, options: nil)
        if (hits.first?.node) != nil {
            let newcolor : Int = logic.turn(hits.first!.node.hash)
            switch(newcolor){
            case 0:
                hits.first!.node.geometry?.firstMaterial?.diffuse.contents = UIColor.grayColor()
                break
            case 1:
                hits.first!.node.geometry?.firstMaterial?.diffuse.contents = UIColor.blueColor()
                break
            case 2:
                hits.first!.node.geometry?.firstMaterial?.diffuse.contents = UIColor.redColor()
                break
            default:
                break
            }
            let newimage = Cube.draw_sidecube()
            sideView.scene!.rootNode.replaceChildNode(sideNode, with: newimage)
            sideNode = newimage
        }
    }
    
    func syncronizeViews(){
        sideView.pointOfView!.position = sceneView.pointOfView!.position
        sideView.pointOfView!.orientation = sceneView.pointOfView!.orientation
        sideView.pointOfView!.camera!.xFov = sceneView.pointOfView!.camera!.xFov
    }
    
    // MARK: Transition
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        sceneView.stop(nil)
        sceneView.play(nil)
    }


}