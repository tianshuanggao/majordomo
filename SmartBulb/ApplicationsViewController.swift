//
//  ApplicationsViewController.swift
//  SmartBulb
//
//  Created by Mac on 11/30/15.
//  Copyright © 2015 GTS. All rights reserved.
//

import UIKit

class ApplicationsViewController: UIViewController {
    
    var txrx :TxRx = TxRx(input_addr: "localhost",input_port: 8888);
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var bulb: UIImageView!
    @IBOutlet weak var mySwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let rx_thread = NSThread(target:self, selector:"start_rx", object:nil)
        rx_thread.start();
        
        txrx.login();
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func refresh(sender:AnyObject)
    {
        bulb.image = UIImage(named: ("on.png"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func start_rx(){
        txrx.start_rx();
    }
    
    @IBAction func change(sender: AnyObject) {
        
        if(mySwitch.on){
            txrx.send("c");
            bulb.image = UIImage(named: ("on.png"))
        }else{
            txrx.send("o");
            bulb.image = UIImage(named: ("off.png"))
        }
    }

}
