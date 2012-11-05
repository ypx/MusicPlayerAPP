//
//  TabBarViewController.m
//  音乐播放器APP
//
//  Created by ypx on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TabBarViewController.h"

@implementation TabBarViewController

@synthesize homePageVC;
@synthesize onlineVC;
@synthesize mediaListVC;
@synthesize settingVC;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    homePageVC = [[[HomePageViewController alloc] init] autorelease];
    //homePageVC.title = @"home";
    onlineVC = [[[OnLineViewController alloc] init] autorelease];
    //playVC.title = @"play";
    mediaListVC = [[[MediaListViewController alloc] init] autorelease];
    //mediaListVC.title = @"mediaList";
    settingVC = [[[SettingViewController alloc] init] autorelease];
    //settingVC.title = @"setting";    
    
    UINavigationController * nav1 =[[UINavigationController alloc] initWithRootViewController:homePageVC];
    UINavigationController * nav2 =[[UINavigationController alloc] initWithRootViewController:onlineVC];
    UINavigationController * nav3 =[[UINavigationController alloc] initWithRootViewController:mediaListVC];
    UINavigationController * nav4 =[[UINavigationController alloc] initWithRootViewController:settingVC];
    
    //设置tabBarItem
    [nav1.tabBarItem initWithTitle:@"home" image:[UIImage imageNamed:@"001.png"] tag:100];
    [nav1.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"001_1.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"001.png"]];
    
    [nav2.tabBarItem initWithTitle:@"online" image:[UIImage imageNamed:@"003.png"] tag:101];
    [nav2.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"003_3.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"003.png"]];
    
    [nav3.tabBarItem initWithTitle:@"mediaList" image:[UIImage imageNamed:@"002.png"] tag:102];
    [nav3.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"002_2.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"002.png"]];
    
    [nav4.tabBarItem initWithTitle:@"setting" image:[UIImage imageNamed:@"004.png"] tag:103];
    [nav4.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"004_4.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"004.png"]];
    [self.tabBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"c-2-1.png"]]];//设置tabBar的背景图片
    
    _viewControllerArray = [[NSMutableArray alloc] initWithObjects:nav1, nav3, nav2, nav4, nil];
    self.delegate = self;
    //self.viewControllers = _viewControllerArray;
    [self setViewControllers:_viewControllerArray animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
