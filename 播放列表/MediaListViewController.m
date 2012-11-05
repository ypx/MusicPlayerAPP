//
//  MediaListViewController.m
//  音乐播放器2
//
//  Created by ypx on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MediaListViewController.h"
#import "MusicCell.h"

@implementation MediaListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _mp3Array = [[NSMutableArray alloc] initWithCapacity:100];
        _lrcArray = [[NSMutableArray alloc] initWithCapacity:100];
        _playing = [[PlayViewController alloc] init];
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
    [_mp3Array release];
    [_playing release];
    [super dealloc];
}

//初始化tableview
- (void)initMusicListTableView
{
    _musicListTableView = [[ADLivelyTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [_musicListTableView  setInitialCellTransformBlock:ADLivelyTransformHelix];
    //这是用的第三方的动画效果
    _musicListTableView.dataSource = self;
    _musicListTableView.delegate = self;
    _musicListTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_musicListTableView];
    [_musicListTableView release];
    _musicListTableView.separatorColor = [UIColor purpleColor];
    _musicListTableView.backgroundColor = [UIColor clearColor];
}

- (void)createMusicArray
{
    NSArray * path = [NSBundle pathsForResourcesOfType:@"mp3" inDirectory:[[NSBundle mainBundle] bundlePath]];
    //这句的意思是找本地沙河中所有的格式位MP3的文件路径，是路径
    for (NSString * p in path) {
        NSArray * array = [p componentsSeparatedByString:@"/"];
        [_mp3Array addObject:[array objectAtIndex:array.count-1]];
    }
    
//    NSFileManager * manager = [NSFileManager defaultManager];
//    //怎么样才能不用绝对路径呢
//    NSDirectoryEnumerator * direnum = [manager enumeratorAtPath:@"/Users/qianfeng/颜沛贤/UI/1026/音乐播放器APP/MP3"];
//    NSString * filename;
//    while (filename = [direnum nextObject]) {
//        if ([[filename pathExtension] isEqualToString:@"mp3"]) {
//            [_mp3Array addObject:filename];
//        }
//    }
}

- (void)createLrcArray
{
    NSArray * path = [NSBundle pathsForResourcesOfType:@"lrc" inDirectory:[[NSBundle mainBundle] bundlePath]];
    //这句的意思是找本地沙河中所有的格式位MP3的文件路径，是路径
    for (NSString * p in path) {
        NSArray * array = [p componentsSeparatedByString:@"/"];
        [_lrcArray addObject:[array objectAtIndex:array.count-1]];
    }
}

#pragma mark - View lifecycle

- (void)playingMusic
{
    if (_playing) {
        [self presentViewController:_playing animated:YES completion:^{
            
        }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self initMusicListTableView];
    [self createMusicArray];
    [self createLrcArray];
    
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

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mp3Array.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"music";
    MusicCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[MusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
    }
    cell.textLabel.text = [_mp3Array objectAtIndex:indexPath.row];
    
    //选中下的背景
    UIView * selectBgView = [[UIView alloc] initWithFrame:cell.frame];
    selectBgView.backgroundColor = [UIColor orangeColor];
    cell.selectedBackgroundView = selectBgView;
    [selectBgView release];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    //self.tabBarController.tabBar.hidden = YES;
   PlayViewController * player = [[PlayViewController alloc] init];
    _playing = player;
    player.musicArray = _mp3Array;
    player.lrcArray = _lrcArray;
    player.index = indexPath.row;

    [UIView transitionFromView:self.view toView:player.view duration:2.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        [self presentViewController:player animated:NO completion:^{
            self.navigationController.navigationBarHidden = NO;
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"正在播放" style:UIBarButtonItemStyleDone target:self action:@selector(playingMusic)];//在这里放个图片就好了，现在不好看
            self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
            //self.navigationController.navigationBar.alpha = 0.5;
        }];
    }];
    
    [player release];
}

@end
