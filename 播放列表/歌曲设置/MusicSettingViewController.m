//
//  MusicSettingViewController.m
//  音乐播放器APP
//
//  Created by ypx on 12-11-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicSettingViewController.h"

@implementation MusicSettingViewController

@synthesize rateSlider;

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

- (void)dealloc
{
    [self.rateSlider release];
    [super dealloc];
}

#pragma mark - ButtonPressed

- (IBAction)baclButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - View lifecycle

- (void)rateSetting
{
    UILabel * rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 50, 40)];
    rateLabel.text = @"速度";
    [self.view addSubview:rateLabel];
    
    self.rateSlider = [[UISlider alloc] initWithFrame:CGRectMake(70, 100, 200, 0)];
    self.rateSlider.minimumValue = 0.5;
    self.rateSlider.maximumValue = 2.0;
    [self.view addSubview:self.rateSlider];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self rateSetting];//播放速度设定
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
