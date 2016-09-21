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
    
    // main
    var mainNode: SCNNode = SCNNode()
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        sceneSetup()
        mainNode = Cube.draw_cube()
        sceneView.scene!.rootNode.addChildNode(mainNode)
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
        doubletap.numberOfTapsRequired = 2
        singletap.requireGestureRecognizerToFail(doubletap)
        
        sceneView.addGestureRecognizer(singletap)
        sceneView.addGestureRecognizer(doubletap)
        sceneView.scene = scene
        
    }
    
    func doubletaped(sender: UITapGestureRecognizer) {
        
        //sceneView.pointOfView!.camera?.xFov = 110.0
        
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
    func taped(sender: UITapGestureRecognizer) {
        let location: CGPoint = sender.locationInView(self.sceneView)
        let hits = self.sceneView.hitTest(location, options: nil)
        if (hits.first?.node) != nil {
            //TODO give data to logik
            let newcolor = 1 //fedback from logic
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
            // remove following
            Data.get_instance().set_color_by_hash(hits.first!.node.hash,color: newcolor)
           
        }
    }
    
    // MARK: Transition
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        sceneView.stop(nil)
        sceneView.play(nil)
    }


}