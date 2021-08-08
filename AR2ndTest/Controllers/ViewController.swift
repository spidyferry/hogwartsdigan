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
        let currentAlphabet:String = UserDefaults.standard.string(forKey: "currentAlphabet")!
        // Load the "Box" scene from the "Experience" Reality File
        
        if(currentAlphabet == "A"){
            let boxAnchor = try! Experience.loadApple()
            boxAnchor.actions.sayApple.onAction = prints(_:)
            // Add the box anchor to the scene
            arView.scene.anchors.append(boxAnchor)
        }else if(currentAlphabet == "B"){
            let boxAnchor = try! Experience.loadBasket()
            boxAnchor.actions.sayApple.onAction = prints(_:)
            // Add the box anchor to the scene
            arView.scene.anchors.append(boxAnchor)
        }else if(currentAlphabet == "C"){
            let boxAnchor = try! Experience.loadChocolate()
            boxAnchor.actions.sayApple.onAction = prints(_:)
            // Add the box anchor to the scene
            arView.scene.anchors.append(boxAnchor)
        }
    }
    
    func prints(_ entity:Entity?){
        guard let entity = entity else {return}
        print(entity)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let MainScreen = storyBoard.instantiateViewController(withIdentifier: "ARSuccess") as! ARSuccess
        MainScreen.modalPresentationStyle = .fullScreen
        self.present(MainScreen, animated: false, completion: nil)
    }
    
}
