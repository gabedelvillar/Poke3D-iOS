//
//  ViewController.swift
//  Poke3D
//
//  Created by Gabriel Del VIllar on 11/20/18.
//  Copyright © 2018 gdelvillar. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
      
      sceneView.autoenablesDefaultLighting = true
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
      
      if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main){
      
        configuration.trackingImages = imageToTrack
        
        configuration.maximumNumberOfTrackedImages = 1
        
        print("Images Successfully Added")
      }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
  
  func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    let node = SCNNode()
    
    if let imageAnchor = anchor as? ARImageAnchor {
      let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
      plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
      
      let planeNode = SCNNode(geometry: plane)
      
      planeNode.eulerAngles.x = -.pi/2
      
      node.addChildNode(planeNode)
      
      if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn"){
        if let pokeNode = pokeScene.rootNode.childNodes.first{
          pokeNode.eulerAngles.x = -.pi/2
          
          planeNode.addChildNode(pokeNode)
        }
      }
    }
    
    
    return node
  }
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
