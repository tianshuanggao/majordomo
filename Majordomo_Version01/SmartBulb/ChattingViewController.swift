//
//  ChattingViewController.swift
//  SmartBulb
//
//  Created by Mac on 12/1/15.
//  Copyright © 2015 GTS. All rights reserved.
//

import UIKit

var global_message:String = " ";
var received_message = false;

class ChattingViewController: UIViewController {
    
    //var txrx :TxRx = TxRx(input_addr: "localhost",input_port: 8888);
    
    @IBOutlet weak var message_input: UITextField!
    var flag = true;
    
    @IBOutlet weak var my_lable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let receive_message = NSThread(target:self, selector:"update_message", object:nil)
        receive_message.start();
        
        //txrx.login();
        //update_message();
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update_message(){
        while(true){
            sleep(1);
            if(received_message == true){
                message_input.text = global_message;
                received_message = false;
            }
        }
    }
    
    func start_rx(){
        //txrx.start_rx();
    }
}
