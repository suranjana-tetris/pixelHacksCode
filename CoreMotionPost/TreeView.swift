//
//  TreeView.swift
//  CoreMotionPost
//
//  Created by sooraj on 2/27/21.
//  Copyright © 2021 kamwysoc. All rights reserved.
//

import UIKit
    
class TreeView: UIViewController {
    override func viewDidLoad() {
        print("First Controller Loaded")
        addTree()
        
    }
    func addTree() {
        let imageName = "yourImage.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        view.addSubview(imageView)
    }
    
}
