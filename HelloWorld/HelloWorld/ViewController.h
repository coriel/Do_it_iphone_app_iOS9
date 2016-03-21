//
//  ViewController.h
//  HelloWorld
//
//  Created by 심연진 on 2016. 3. 16..
//  Copyright © 2016년 coriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
- (IBAction)buttonTouch:(id)sender;
- (IBAction)inputTextToTextView:(id)sender;
- (IBAction)switchTouch:(id)sender;


@end

