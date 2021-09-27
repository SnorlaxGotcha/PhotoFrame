//
//  ViewController.swift
//  PicCollageAppWithUikit
//
//  Created by 黃世維 on 2021/9/27.
//

import UIKit

struct PhotoFrame {
    enum display {
        case type1, type2
    }
    
    var canvas: UIImageView
    var maximum: Int = 2
    private(set) var images: [PictureDisplayInfo] = .init()
    
    var sideLength = 40
    var displayType: display = .type1
    
    init(imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "1")
        
        self.canvas = imageView
    }
    
    mutating func add(picture: PictureDisplayInfo) {
        if images.count == maximum {
            return
        }
        
        // TODO: reset contentMode, image size here
        var newPicture = picture
        switch displayType {
        case .type1:
            // config first one
            if images.count == 0 {
                newPicture.contentMode = .scaleAspectFit
                newPicture.size = .init(origin: .init(x: 0, y: 0), size: .init(width: 300, height: 400))
            }
            
            // config second one
            if images.count == 1 {
                newPicture.contentMode = .scaleAspectFill
                newPicture.size = .init(origin: .init(x: 0, y: 500), size: .init(width: 400, height: 300))
            }

        case .type2:
            // config first one
            if images.count == 0 {
                newPicture.contentMode = .scaleAspectFill
                newPicture.size = .init(origin: .init(x: 0, y: 0), size: .init(width: 400, height: 400))
            }
            
            // config second one
            if images.count == 1 {
                newPicture.contentMode = .scaleAspectFill
                newPicture.size = .init(origin: .init(x: 0, y: 400), size: .init(width: 400, height: 200))
            }
        }
        
        images.append(newPicture)
    }
    
    func placeAll() {
        for (index, image) in images.enumerated() {
            if index == maximum {
                return
            }
            
            self.display(info: image)
        }
    }
    
    func display(info: PictureDisplayInfo) {
        canvas.drawOnCurrentImage(anotherImage: UIImage(named: info.resource), mode: .addSubview) { parentSize, newImageSize in
            print("parentSize = \(parentSize)")
            print("newImageSize = \(newImageSize)")
            let size = CGRect(x: info.size.origin.x+CGFloat(sideLength), y: info.size.origin.y+CGFloat(sideLength), width: info.size.width, height: info.size.height)
            print(size)
            return size
        }
    }
    
}

struct PictureDisplayInfo {
    var resource: String
    var size: CGRect = .zero
    var contentMode: UIView.ContentMode = .scaleAspectFit
    
    init(resource: String) {
        self.resource = resource
    }
}


class ViewController: UIViewController {
    
    var photoFrame: PhotoFrame!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageviewCanvas = UIImageView.init(frame: view.bounds)
        view.addSubview(imageviewCanvas)
        
        photoFrame = .init(imageView: imageviewCanvas)
        photoFrame.add(picture: .init(resource: "2"))
        photoFrame.add(picture: .init(resource: "3"))

        photoFrame.placeAll()
        
    }
    
}

