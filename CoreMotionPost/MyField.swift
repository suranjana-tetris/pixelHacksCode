import UIKit
import CoreMotion
import Dispatch

protocol WeightProtocol {
    
    func addTree()
}
class MyField: UIViewController,WeightProtocol {

    var x:Int = 0
    var y:Int = 0
    var delegate: WeightProtocol?
    override func viewDidLoad() {
        
        addTree()
        addTree()
        addTree()
        
    }
    
    func addTree() {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths             = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        print("Called")
        if let dirPath        = paths.first
        {
            print(paths.first)
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("pixel_tree_2.png")
           let image    = UIImage(contentsOfFile: imageURL.path)
           // Do whatever you want with the image
            
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: x, y: y, width: 50, height: 50)
            view.addSubview(imageView)
            x = x + 70
            
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? MyField {
                destination.delegate = self
                // Other initializations as needed
            }
        }
}
