/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        uploadImage()
    }
    
    @IBAction func btnClicked() {
        downloadImage()
        deleteImage()
    }
    
    func uploadImage() {
        let url = "http://i.imgur.com/Hdc9eaS.jpg"
        let data = NSData(contentsOfURL: NSURL(string: url)!)!
        let imageFile: PFFile = PFFile(name: "tanmayripleys.jpg", data: data)!
        try! imageFile.save()
        let userPhoto: PFObject = PFObject(className: "photo")
        userPhoto["imageName"] = "Me at Ripley's Aquarium of Canada!"
        userPhoto["imageFile"] = imageFile
        try! userPhoto.save()
    }
    
    func downloadImage() {
        let query = PFQuery(className: "photo")
        let object = try! query.getFirstObject()
        let controller = UIAlertController(title: "Title Of Image", message: (object["imageName"] as! String), preferredStyle: .Alert)
        let action = UIAlertAction(title: "Nice!", style: .Cancel, handler: nil)
        controller.addAction(action)
        self.presentViewController(controller, animated: true, completion: nil)
        var image: UIImage!
        let file = object.objectForKey("imageFile") as! PFFile
        image = UIImage(data: NSData(contentsOfURL: NSURL(string: file.url!)!)!)!
        imageView.image = image
    }
    
    func deleteImage() {
        let query = PFQuery(className: "photo")
        let object = try! query.getFirstObject()
        try! object.delete()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
