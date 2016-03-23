//
//  ViewController.m
//  SnowAnimation
//
//  Created by 심연진 on 2016. 3. 22..
//  Copyright © 2016년 coriel. All rights reserved.
//

#import "ViewController.h"
#import "SnowAniViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize infoButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SnowAniViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SnowAniViewController"];
    
    //infoButton 뒤로 RecordViewController.view를 넣습니다.
    [self.view insertSubview:viewController.view belowSubview:infoButton];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// status bar를 안 보이게 합니다.
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
