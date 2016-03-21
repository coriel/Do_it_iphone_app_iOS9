//
//  ViewController.m
//  HelloWorld
//
//  Created by 심연진 on 2016. 3. 16..
//  Copyright © 2016년 coriel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_imageView setImage:[UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"molang" ofType:@"jpg"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTouch:(id)sender {
    NSString *str=[_textField text];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    [_webView loadRequest:request];
}

- (IBAction)inputTextToTextView:(id)sender {
    [_textView setText:[_textField text]];
}

- (IBAction)switchTouch:(id)sender {
    if([_switchButton isOn])
    {
        [_imageView setAlpha:1.0f];
    }
    else
    {
        [_imageView setAlpha:0.0f];
    }
}


@end
