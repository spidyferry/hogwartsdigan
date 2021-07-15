//
//  ViewController.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 13/07/21.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        boxAnchor.actions.sayApple.onAction = prints(_:)
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
    }
    
    
    
    func prints(_ entity:Entity?){
        guard let entity = entity else {return}
        print(entity)
    }
    
}
