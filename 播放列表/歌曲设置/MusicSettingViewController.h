//
//  MusicSettingViewController.h
//  音乐播放器APP
//
//  Created by ypx on 12-11-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicSettingViewController : UIViewController

@property (nonatomic,retain) UISlider * rateSlider;

- (IBAction)baclButtonPressed:(id)sender;

@end
