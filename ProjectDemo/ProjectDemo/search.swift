//
//  search.swift
//  ProjectDemo
//
//  Created by TOPS on 10/15/18.
//  Copyright © 2018 TOPS. All rights reserved.
//

import UIKit

class search: UIViewController,UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate {

    var tblview = UITableView();
    override func viewDidLoad() {
        super.viewDidLoad()

        tblview = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.frame.size.height), style: .grouped);
        tblview.delegate = self;
        tblview.dataSource = self;
        self.view.addSubview(tblview);
        
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
        
        let navitem = UINavigationItem(title: "Search")
        
        let item1 = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.home))
        let item2 = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.search))
        
        navitem.rightBarButtonItem = item2
        navitem.leftBarButtonItem = item1
        
        navbar.items = [navitem]
        self.view.addSubview(navbar)
        
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        if indexPath.row == 1
        {
            cell.textLabel?.text = "LogOut";
        }
        else
        {
            cell.textLabel?.text = "Home";
        }
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 1
        {
            let dif = UserDefaults.standard;
            dif.removeObject(forKey: "name")
            let stb = self.storyboard?.instantiateViewController(withIdentifier: "login")
            
            self.navigationController?.pushViewController(stb!, animated: true)
            
        }
    }
    
    
    
    func home(sender:UIBarButtonItem)
    {
        UIView.beginAnimations(nil, context: nil);
        UIView.setAnimationDuration(0.5);
        UIView.setAnimationDelegate(self);
        tblview.frame = CGRect(x: 0, y: 0, width: 150, height: self.view.frame.size.height);
        UIView.commitAnimations();
        tblview.reloadData();
    }
    
    func search(sender:UIBarButtonItem)  {
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.beginAnimations(nil, context: nil);
        UIView.setAnimationDuration(0.5);
        UIView.setAnimationDelegate(self);
        tblview.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.frame.size.height);
        UIView.commitAnimations();
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 100
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let dif = UserDefaults.standard;
        let dd = dif.value(forKey: "name") as! String;
        return dd;
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
