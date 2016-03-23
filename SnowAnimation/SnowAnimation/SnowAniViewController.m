//
//  SnowAniViewController.m
//  SnowAnimation
//
//  Created by 심연진 on 2016. 3. 22..
//  Copyright © 2016년 coriel. All rights reserved.
//

#import "SnowAniViewController.h"

@interface SnowAniViewController ()

@end

@implementation SnowAniViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self StartBackgroundAnimation:5];
    [self StartSnowAnimation:0.25];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)StartBackgroundAnimation:(float)Duration
{
    if(SnowImageView == nil)
    {
        SnowImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        NSMutableArray *imageArray = [NSMutableArray array];
        for(int i = 1; i <= 46; i++)
        {
            [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"snow-%d.tiff", i]]];
        }
        SnowImageView.animationImages = imageArray;
    }
    else
    {
        [SnowImageView removeFromSuperview];
    }
    
    SnowImageView.animationDuration = Duration;
    SnowImageView.animationRepeatCount = 0;
    [SnowImageView startAnimating];
    [self.view addSubview:SnowImageView];
}

-(void)StartSnowAnimation:(float)Duration
{
    snowImage = [UIImage imageNamed:@"snow.png"];
    [NSTimer scheduledTimerWithTimeInterval:(0.3) target:self selector:@selector(animationTimerHandler:)userInfo:nil repeats:YES];
}

-(void)animationTimerHandler:(NSTimer*)theTimer
{
    UIImageView *snowView = [[UIImageView alloc] initWithImage:snowImage];
    
    int startX = round(random()%375);
    int endX = round(random()%375);
    double snowSpeed = 10 + (random() % 10) / 10.0;
    
    snowView.alpha = 0.9l;
    snowView.frame = CGRectMake(startX, -20, 20, 20);
    
    [UIView beginAnimations:nil context:(__bridge void*)(snowView)];
    [UIView setAnimationDuration:snowSpeed];
    
    snowView.frame = CGRectMake(endX, 667.0, 20, 20);
    [UIView setAnimationDidStopSelector:@selector(animationdidStop:finished:context:)];
    [UIView setAnimationDelegate:self];
    [SnowImageView addSubview:snowView];
    [UIView commitAnimations];
}

-(void)animationdidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [(__bridge UIImageView *)context removeFromSuperview];
}
     
     


@end
