//
//  SnowAniViewController.h
//  SnowAnimation
//
//  Created by 심연진 on 2016. 3. 22..
//  Copyright © 2016년 coriel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnowAniViewController : UIViewController
{
    UIImageView *SnowImageView;
    UIImage *snowImage;
}

-(void)StartBackgroundAnimation:(float)Duration;
-(void)StartSnowAnimation:(float)Duration;
-(void)animationTimerHandler:(NSTimer*)theTimer;

@end
