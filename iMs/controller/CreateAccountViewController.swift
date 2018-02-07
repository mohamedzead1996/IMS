//
//  CreateAccountViewController.swift
//  iMs
//
//  Created by mohamed zead on 1/29/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import Firebase
import SVProgressHUD
class CreateAccountViewController: UIViewController {
   
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm_password: UITextField!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var createAccBtn: UIButton!
    
    
    
    func Check_Account(){
        if password.text == confirm_password.text {

            Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion:{(user,error)in
                var str_err = String(describing: error)
                print(str_err)
               
                
                if error != nil
                {
                    
                    let inx1 = str_err.index(str_err.startIndex, offsetBy: 53)
                    let inx2 = str_err.index(of:".")
                    str_err = str_err[inx1...inx2]
                    
                    let alert = UIAlertController.init(title: "Error", message: str_err, preferredStyle: UIAlertControllerStyle.alert)
                    
                    self.present(alert, animated: true, completion:{
                        alert.view.superview?.isUserInteractionEnabled = true
                        alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertClose)))
                    })
                
                
                
                    
                }
                else{
                        self.performSegue(withIdentifier: "created", sender: nil)
                        SVProgressHUD.dismiss()
                }
            })
        }
        else {
            let alert : UIAlertController = UIAlertController.init(title: "Error", message: "password doesn't match ", preferredStyle: UIAlertControllerStyle.alert)
            
            self.present(alert, animated: true, completion:{
                alert.view.superview?.isUserInteractionEnabled = true
                alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertClose)))
            })
    
        }
 }
  
    func alertClose(){
        
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createAccBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    @IBAction func createAccountButton(_ sender: Any) {
        
       
        SVProgressHUD.show()
        
        Check_Account()
        
    }
    

    @IBAction func chooseColor(_ sender: Any) {
       

    }
    @IBAction func chooseAvatar(_ sender: UIButton) {
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "created"
        {
            let channelVC = segue.destination as! ChannelViewController
            channelVC.loginbtn.setTitle("Logout", for: UIControlState.normal)
            channelVC.login = true
        }
        else if segue.identifier == "unwindSegue"
        {
            let channelVC = segue.destination as! ChannelViewController
            channelVC.loginbtn.setTitle("Login", for: UIControlState.normal)

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closepressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
