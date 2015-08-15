//
//  ViewController.swift
//  BitCatcher
//
//  Created by Cole on 8/15/15.
//  Copyright (c) 2015 Hack the Planet:Dank Memers. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var clientTokenURL: NSURL = NSURL.URLWithString("https://braintree-sample-merchant.herokuapp.com/client_token")
        var clientTokenRequest: NSMutableURLRequest = NSMutableURLRequest.requestWithURL(clientTokenURL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
        NSURLConnection.sendAsynchronousRequest(clientTokenRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse, data: NSData, connectionError: NSError) in            var clientToken: String = NSString(data: data, encoding: NSUTF8StringEncoding)
            self.braintree = Braintree.braintreeWithClientToken(clientToken)
            
        })
        
    }
    
    //demo
    var clientToken: String = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJjZTRlZmZkOWJjM2Y4YjJkNmU4MDMwNTY0ZTFkZDhjZWRiZDk2ZTZiZjNhM2QwYTFjOWFhZTg1ZWM1ZjhjODUxfGNyZWF0ZWRfYXQ9MjAxNS0wOC0xNVQxNDowNjo0NC45NTQwNzg1NjUrMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzM0OHBrOWNnZjNiZ3l3MmIvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vY2xpZW50LWFuYWx5dGljcy5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIn0sInRocmVlRFNlY3VyZUVuYWJsZWQiOnRydWUsInRocmVlRFNlY3VyZSI6eyJsb29rdXBVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi90aHJlZV9kX3NlY3VyZS9sb29rdXAifSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwibWVyY2hhbnRBY2NvdW50SWQiOiJhY21ld2lkZ2V0c2x0ZHNhbmRib3giLCJjdXJyZW5jeUlzb0NvZGUiOiJVU0QifSwiY29pbmJhc2VFbmFibGVkIjpmYWxzZSwibWVyY2hhbnRJZCI6IjM0OHBrOWNnZjNiZ3l3MmIiLCJ2ZW5tbyI6Im9mZiJ9"
    

  
//    @IBOutlet weak var payBit: UIButton! {
//
//    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    @IBAction func tappedMyPayButton(sender: AnyObject) {
//    }

}

class MyViewController:BTDropInViewControllerDelegate {
    @IBAction func tappedMyPayButton() {
        var dropInViewController: BTDropInViewController = self.braintree.dropInViewControllerWithDelegate(self)
        dropInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItemCancel, target: self, action: "userDidCancelPayment")
        var navigationController: UINavigationController = UINavigationController(rootViewController: dropInViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func userDidCancelPayment() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dropInViewController(viewController: __unused BTDropInViewController, didSucceedWithPaymentMethod paymentMethod: BTPaymentMethod) {
        self.postNonceToServer(paymentMethod.nonce)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dropInViewControllerDidCancel(viewController: __unused BTDropInViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postNonceToServer(paymentMethodNonce: String) {
        var paymentURL: NSURL = NSURL.URLWithString("https://your-server.example.com/payment-methods")
        var request: NSMutableURLRequest = NSMutableURLRequest.requestWithURL(paymentURL)
        request.HTTPBody = "payment_method_nonce=\(paymentMethodNonce)".dataUsingEncoding(NSUTF8StringEncoding)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse, data: NSData, connectionError: NSError) in
        })
    }
}

