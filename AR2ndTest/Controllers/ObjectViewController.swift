//
//  ObjectViewController.swift
//  AR2ndTest
//
//  Created by Nirwan Ramdani on 04/08/21.
//

import UIKit
import SceneKit

class ObjectViewController: UIViewController {
    @IBOutlet weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = SCNScene(named: "Apple.usdz")
        
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 10, z: 102)
        scene?.rootNode.addChildNode(cameraNode)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 102)
        scene?.rootNode.addChildNode(lightNode)
        
        sceneView.autoenablesDefaultLighting = true
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene?.rootNode.addChildNode(ambientLightNode)
        
        sceneView.allowsCameraControl = true
        
        sceneView.backgroundColor = UIColor.clear
        
        sceneView.cameraControlConfiguration.allowsTranslation = false
        
        sceneView.scene = scene
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
