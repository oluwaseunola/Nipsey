//
//  ViewController.swift
//  NispeyPaper
//
//  Created by Seun Olalekan on 2021-05-20.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {
    var audioPlayer : AVAudioPlayer!

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        
        // Create a new scene
        
        
        // Set the scene to the view
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imagesToDetect = ARReferenceImage.referenceImages(inGroupNamed: "NipseyImage", bundle: Bundle.main){
            
            configuration.trackingImages = imagesToDetect
            configuration.maximumNumberOfTrackedImages = 1
            
            print("Image Detected")
            
        }
        

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    func play(){
            if let url = Bundle.main.url(forResource: "Untitled" , withExtension: "mp3"){
               print("ready")
                audioPlayer = try! AVAudioPlayer(contentsOf: url)

                 audioPlayer!.play()
                
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(AVAudioSession.Category.playback)
            

                
    }
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    }
        func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let video = SKVideoNode(fileNamed: "Untitled.mp4")
            video.play()
            play()
            let videoScene = SKScene(size: CGSize(width: 1920, height: 1080))
            
            video.position = CGPoint(x: videoScene.size.width/2, y: videoScene.size.height/2)
            videoScene.addChild(video)
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = videoScene
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -(Float.pi/2)
            planeNode.eulerAngles.y = -(Float.pi)
            
            node.addChildNode(planeNode)
            
            
            
        }
        
        return node
}


    }

