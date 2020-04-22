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
    
    var uploadButton:RoundedWhiteButton!
    var activityView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        uploadButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        uploadButton.setTitleColor(secondaryColor, for: .normal)
        uploadButton.setTitle("Upload", for: .normal)
        uploadButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        uploadButton.center = CGPoint(x: view.center.x, y: view.frame.height - uploadButton.frame.height - 24)
        uploadButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        uploadButton.defaultColor = UIColor.white
        uploadButton.addTarget(self, action: #selector(handleUpload), for: .touchUpInside)
        uploadButton.alpha = 0.5
        view.addSubview(uploadButton)
        setContinueButton(enabled: false)
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = uploadButton.center
        
        view.addSubview(activityView)
        
        titleField.delegate = self
        whenField.delegate = self
        timeField.delegate = self
        distanceField.delegate = self
        paceField.delegate = self
        
        titleField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        whenField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        timeField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        distanceField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        paceField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        titleField.resignFirstResponder()
        whenField.resignFirstResponder()
        timeField.resignFirstResponder()
        distanceField.resignFirstResponder()
        paceField.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        uploadButton.center = CGPoint(x: view.center.x,
                                        y: view.frame.height - keyboardFrame.height - 16.0 - uploadButton.frame.height / 2)
        activityView.center = uploadButton.center
    }
    

    
    @objc func textFieldChanged(_ target:UITextField) {
        let title = titleField.text
        let when = whenField.text
        let time = timeField.text
        let distance = distanceField.text
        let pace = paceField.text
        
        let formFilled = title != nil && title != "" && when != nil && when != ""
            && time != nil && time != "" && distance != nil && distance != ""
            && pace != nil && pace != ""
        setContinueButton(enabled: formFilled)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
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
    
    /**
     Enables or Disables the **continueButton**.
     */
    
    func setContinueButton(enabled:Bool) {
        if enabled {
            uploadButton.alpha = 1.0
            uploadButton.isEnabled = true
        } else {
            uploadButton.alpha = 0.5
            uploadButton.isEnabled = false
        }
    }
    
    @objc func handleUpload() {
        guard let title = titleField.text else { return }
        guard let when = whenField.text else { return }
        guard let time = timeField.text else { return }
        guard let distance = distanceField.text else { return }
        guard let pace = paceField.text else { return }
        
        setContinueButton(enabled: false)
        uploadButton.setTitle("", for: .normal)
        activityView.startAnimating()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        let metaData = StorageMetadata()
        metaData.contentType = "user"
        
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
