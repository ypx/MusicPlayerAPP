//
//  TabBarViewController.h
//  音乐播放器APP
//
//  Created by ypx on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageViewController.h"
#import "OnLineViewController.h"
#import "MediaListViewController.h"
#import "SettingViewController.h"


@interface TabBarViewController : UITabBarController <UITabBarControllerDelegate>
{
    NSMutableArray * _viewControllerArray;
}

@property (nonatomic,retain) HomePageViewController * homePageVC;
@property (nonatomic,retain) OnLineViewController * onlineVC;
@property (nonatomic,retain) MediaListViewController * mediaListVC;
@property (nonatomic,retain) SettingViewController * settingVC;


@end
