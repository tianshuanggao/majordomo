//
//  ChattingViewController.swift
//  SmartBulb
//
//  Created by Mac on 12/1/15.
//  Copyright © 2015 GTS. All rights reserved.
//

import UIKit

class ChattingViewController: UIViewController, UITextFieldDelegate {
    
    var txrx :TxRx = TxRx(input_addr: "10.25.149.163",input_port: 8888);
    
    
    @IBOutlet weak var send_button: UIButton!
    @IBOutlet weak var chatting_window: UITextView!
    @IBOutlet weak var message_input: UITextField!
    var flag = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.message_input.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
        let receive_message = NSThread(target:self, selector:"update_message", object:nil)
        receive_message.start();
        
        txrx.login();
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update_message(){
        while(true){
            let message = txrx.start_rx();
            if(message != "" && message != "Username:" && message != "Password:  "){
                //chatting_window.text = message;
                dispatch_async(dispatch_get_main_queue()) {
                    self.chatting_window.text?.appendContentsOf(message);
                    self.chatting_window.text?.appendContentsOf("\n");
                }
                print(message);
            }
        }
    }
    
    func start_rx(){
        //txrx.start_rx();
    }
    @IBAction func send_message(sender: AnyObject) {
         txrx.send(">" + message_input.text!);
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        txrx.send(">" + message_input.text!);
        clear_input();
        return false
    }
    func clear_input(){
        message_input.text = "";
    }
}
