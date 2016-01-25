//
//  ViewController.swift
//  SocialDemo
//
//  Created by Mac on 16/1/21.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    @IBOutlet weak var noteTextview:UITextView!
    
    @IBAction func showShareOptions(sender: AnyObject){
        
        if noteTextview.isFirstResponder() {
            noteTextview.resignFirstResponder()
        }
        
        let actionSheet = UIAlertController(title: "", message: "分享", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // 分享到Twitter
        let tweetAction = UIAlertAction(title: "分享到 Twitter", style: UIAlertActionStyle.Default) { (action) -> Void in
            // 检查是否可以分享到Twitter
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                let twitterComoseVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                // 判断输入的文字是否小于140
                if self.noteTextview.text.characters.count >= 140 {
                    twitterComoseVC.setInitialText("\(self.noteTextview.text)")
                } else {    // 字符串大于140去取前140
                    let index = self.noteTextview.text.startIndex.advancedBy(140)
                    let subText = self.noteTextview.text.substringToIndex(index)
                    twitterComoseVC.setInitialText("\(subText)")
                }
                
                self.presentViewController(twitterComoseVC, animated: true, completion: nil)
                
            } else {
                self.showAlertMessage("未登录Twitter账号.")
            }
            
        }

        // 分享到facebook
        let facebookPostAction = UIAlertAction(title: "分享到 Facebook", style: UIAlertActionStyle.Default) { (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                let faceBookComoseVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
                faceBookComoseVC.setInitialText("\(self.noteTextview.text)")
             
                self.presentViewController(faceBookComoseVC, animated: true, completion: nil)
            } else {
                self.showAlertMessage("未登录facebook账号")
            }
            
        }
        
        let moreAction = UIAlertAction(title: "更多", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            let activityViewController = UIActivityViewController(activityItems: [self.noteTextview.text], applicationActivities: nil)
            activityViewController.excludedActivityTypes = [UIActivityTypeMail]
            self.presentViewController(activityViewController, animated: true, completion: nil)
        }
        
        let dismissAction = UIAlertAction(title: "关闭", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
        }
        
        actionSheet.addAction(tweetAction)
        actionSheet.addAction(facebookPostAction)
        actionSheet.addAction(moreAction)
        actionSheet.addAction(dismissAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
        
        
    }
    
    // 弹出警告信息
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "EasyShare", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // 配置文本输入框
    func configureNoteTextView() {
        noteTextview.layer.cornerRadius = 8.0
        noteTextview.layer.borderColor = UIColor(white: 0.75, alpha: 0.5).CGColor
        noteTextview.layer.borderWidth = 1.2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNoteTextView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

