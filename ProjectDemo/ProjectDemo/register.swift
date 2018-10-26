//
//  register.swift
//  ProjectDemo
//
//  Created by TOPS on 10/15/18.
//  Copyright © 2018 TOPS. All rights reserved.
//

import UIKit
import TextFieldEffects
import TransitionButton
class register: UIViewController {

    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var txtname: HoshiTextField!
    @IBOutlet weak var txtphno: HoshiTextField!
    @IBOutlet weak var txtemail: HoshiTextField!
    @IBOutlet weak var txtpass: HoshiTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        self.subview.layer.masksToBounds = false;
        self.subview.layer.opacity = 0.5
        self.subview.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.subview.layer.shadowOpacity = 0.5
        
        let reg = TransitionButton(frame: CGRect(x: 50, y: 450, width: self.view.frame.width-100, height: 40))
        reg.backgroundColor = .red
        reg.setTitle("Register", for: .normal)
        reg.cornerRadius = 20
        reg.spinnerColor = .white
        reg.addTarget(self, action: #selector(self.btnreg), for: .touchUpInside)
        self.subview.addSubview(reg);
        
        
    }

    func btnreg(sender:TransitionButton)
    {
        let url = URL(string: "http://localhost/project/index.php?name=\(txtname.text!)&phno=\(txtphno.text!)&email=\(txtemail.text!)&pass=\(txtpass.text!)");
        let request = URLRequest(url: url!);
        let session = URLSession.shared;
        let datatask = session.dataTask(with: request)
        {
            (data1, rsp, err) in
            let strrep = String(data: data1!, encoding: String.Encoding.utf8);
            if strrep! == "1"
            {
                
                let dif = UserDefaults.standard;
                dif.set(self.txtname.text!, forKey: "name");
            }
            DispatchQueue.main.async
            {
                    print(strrep!);
            }
        }
        datatask.resume();
        sender.startAnimation() // 2: Then start the animation when the user tap the button
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
                    
                    let stb = self.storyboard?.instantiateViewController(withIdentifier: "home")
                    
                    self.navigationController?.pushViewController(stb!, animated: true)
                    
                })
            })
        })
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
        
        
    @IBAction func btnsignin(_ sender: Any) {
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "login")
        
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
