//
//  login.swift
//  ProjectDemo
//
//  Created by TOPS on 10/15/18.
//  Copyright © 2018 TOPS. All rights reserved.
//

import UIKit
import TextFieldEffects
import TransitionButton
class login: UIViewController,CAAnimationDelegate{

    
    @IBOutlet weak var txtemail: HoshiTextField!
    
    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var txtpass: HoshiTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        navigationController?.navigationBar.isHidden = true
    
        self.subview.layer.masksToBounds = false;
        self.subview.layer.opacity = 0.5
        self.subview.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.subview.layer.shadowOpacity = 0.5
        
        let login = TransitionButton(frame: CGRect(x: 50, y: 350, width: self.view.frame.width-100, height: 40))
        login.backgroundColor = .red
        login.setTitle("Login", for: .normal)
        login.cornerRadius = 20
        login.spinnerColor = .white
        login.addTarget(self, action: #selector(self.btnlogin), for: .touchUpInside)
         txtpass.isSecureTextEntry = true;
        self.subview.addSubview(login)
       
        
        }
    
    func btnlogin(sender:TransitionButton)
    {
        let url = URL(string: "http://localhost/project/login.php?email=\(txtemail.text!)&pass=\(txtpass.text!)");
        let request = URLRequest(url: url!);
        let session = URLSession.shared;
        let datatask = session.dataTask(with: request)
        {
            (data1, rsp, err) in
            DispatchQueue.main.async
            {
                do
                {
                    var jsondata = try JSONSerialization.jsonObject(with: data1!, options: []) as! [Any];
                    if jsondata.count > 0
                    {
                        var dic = jsondata[0] as! [String:String];
                        
                        let dif = UserDefaults.standard;
                        dif.set(dic["name"], forKey: "name");
                        print(dic["name"]);
                        let stb = self.storyboard?.instantiateViewController(withIdentifier: "home")
                        
                        self.navigationController?.pushViewController(stb!, animated: true)
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Alert", message: "Invalid email or password", preferredStyle: .alert);
                        let ok = UIAlertAction(title: "Ok", style: .default)
                        {
                            ACTION in
                            
                        }
                        alert.addAction(ok);
                        self.present(alert, animated: true, completion: nil);
                    }
                    
                }
                catch
                {
                }
            }
        }
        datatask.resume();
        
        /*sender.startAnimation() // 2: Then start the animation when the user tap the button
       let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(1) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                sender.stopAnimation(animationStyle: .expand, completion: {
                    
                    
                    
                })
            })
        })*/
    }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnsignup(_ sender: Any) {
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "register")
        
        self.navigationController?.pushViewController(stb!, animated: true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
