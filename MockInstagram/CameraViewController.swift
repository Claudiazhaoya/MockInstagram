//
//  CameraViewController.swift
//  MockInstagram
//
//  Created by Zhaoya Sun on 12/27/17.
//  Copyright © 2017 Zhaoya Sun. All rights reserved.
//

import UIKit
import MBProgressHUD

class CameraViewController: UIViewController {

   
    @IBOutlet weak var captionView: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        if postImageView.image == nil {
            instantiateImagePickerController()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        postImageView.image = nil
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Post.postUserImage(image: postImageView.image, withCaption: captionView.text) { (success: Bool, error: Error?) in
            if success {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.postImageView.image = nil
                self.tabBarController?.selectedIndex = 0
                self.captionView.text = nil
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
                print("error: \(error)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    

    extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        public func instantiateImagePickerController() {
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            self.present(vc, animated: true, completion: nil)
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            postImageView.image = editedImage
            dismiss(animated: true, completion: nil)
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.tabBarController?.selectedIndex = 0
            dismiss(animated: true, completion: nil)
        }
    }

