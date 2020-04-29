//
//  RunViewController.swift
//  FirebaseApp
//
//  Created by William Ordaz on 4/21/20.
//  Copyright © 2020 Robert Canton. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class RunViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var whenField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    @IBOutlet weak var paceField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        uploadButton.backgroundColor = secondaryColor
        uploadButton.layer.cornerRadius = uploadButton.bounds.height / 2
        uploadButton.clipsToBounds = true
        
        titleField.delegate = self
        whenField.delegate = self
        timeField.delegate = self
        distanceField.delegate = self
        paceField.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleField.becomeFirstResponder()
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    /*override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        titleField.resignFirstResponder()
        whenField.resignFirstResponder()
        timeField.resignFirstResponder()
        distanceField.resignFirstResponder()
        paceField.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
    }
    */
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        
        switch textField {
        case titleField:
            titleField.resignFirstResponder()
            whenField.becomeFirstResponder()
            break
        case whenField:
        whenField.resignFirstResponder()
        timeField.becomeFirstResponder()
            break
        case timeField:
        timeField.resignFirstResponder()
        distanceField.becomeFirstResponder()
            break
        case distanceField:
        distanceField.resignFirstResponder()
        paceField.becomeFirstResponder()
            break
        case paceField:
            handleUpload()
            break
        default:
            break
        }
        return true
    }
    */
    
    @IBAction func handleUpload() {
        guard let userProfile = UserService.currentUserProfile else {return}
        let postRef = Database.database().reference().child("uploads").childByAutoId()

        let postObject = [
            "author": [
                "uid":userProfile.uid,
                "username":userProfile.username,
                "photoURL":userProfile.photoURL.absoluteString
            ],
            "title": titleField.text,
            "when": whenField.text,
            "time": timeField.text,
            "distance": distanceField.text,
            "pace": paceField.text,
            "timestamp": [".sv":"timestamp"]
            ] as [String:Any]

        postRef.setValue(postObject, withCompletionBlock: { error, postRef in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Handle the error
            }
        })
        
    }
    
    /*func resetForm() {
        let alert = UIAlertController(title: "Error logging in", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        setContinueButton(enabled: true)
        continueButton.setTitle("Continue", for: .normal)
        activityView.stopAnimating()
    }
     */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
