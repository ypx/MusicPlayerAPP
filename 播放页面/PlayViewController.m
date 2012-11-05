//
//  PlayViewController.m
//  音乐播放器2
//
//  Created by ypx on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayViewController.h"

@implementation PlayViewController

@synthesize musicArray;
@synthesize lrcArray;
@synthesize index;
@synthesize player = _player;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.musicArray = [[NSMutableArray alloc] initWithCapacity:100];
        self.lrcArray = [[NSMutableArray alloc] initWithCapacity:100];
        _infoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, 320, 300)];
        _lrcTableView = [[lrcShowTableView alloc] initWithFrame:CGRectMake(320, 0, 320, _infoScrollView.bounds.size.height)];
        _lrcRes = [[lrcResolve alloc] init];
        _musicSetting = [[MusicSettingViewController alloc] initWithNibName:@"MusicSettingViewController" bundle:nil];
        playing = NO;
        oneCyclingPlaying = NO;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [musicArray release];
    [lrcArray release];
    [_player release];
    [_infoScrollView release];
    [super dealloc];
}

#pragma mark - ButtonPressed

- (IBAction)backButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)playAndPauseButtonPressed:(id)sender
{
    if (playing) {
        [_player play];
        [((UIButton *)sender) setTitle:@"暂停" forState:UIControlStateNormal];
        playing = NO;
    }else {
        [_player pause];
        [((UIButton *)sender) setTitle:@"播放" forState:UIControlStateNormal];
        playing = YES;
    }
}

- (IBAction)nextButtonPressed:(id)sender
{
    if (index == musicArray.count-1) {
        index = 0;
    }else {
        index++;
    }
    
    [_player stop];
    [self startPlayer];
}

- (IBAction)prevButtonPressed:(id)sender
{
    if (index == 0) {
        index = musicArray.count-1;
    }else {
        index--;
    }
    
    [_player stop];
    [self startPlayer];
}

- (IBAction)settingButtonPressed:(id)sender
{
    [self presentViewController:_musicSetting animated:YES completion:^{
        
    }];
}

- (IBAction)cyclingButtonPressed:(id)sender
{
    UIButton * cyclingButton = (UIButton *)sender;
    //以什么样的判断方式才是好的呢，这样是肯定不行的
    if ([cyclingButton.titleLabel.text isEqual:@"单曲循环"]) {
        oneCyclingPlaying = YES;
        [cyclingButton setTitle:@"单循环中" forState:UIControlStateNormal];
    } else if ([cyclingButton.titleLabel.text isEqual:@"单循环中"]) {
        oneCyclingPlaying = NO;
        [cyclingButton setTitle:@"单曲循环" forState:UIControlStateNormal];
    }
}

#pragma mark - LrcController

//将lrc文件转化成字符串来进行解析
- (void)readLrcToString:(NSString*)lrcName
{
    //传过来的是文件的全名包括扩展名
    if (lrcName) {
        NSString * lrcPath = [[NSBundle mainBundle] pathForResource:[lrcName stringByDeletingPathExtension] ofType:@"lrc"];//沙河中找到文件
        NSString * textContent = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];//将歌词文件转化成字符串
        NSMutableArray * array = [_lrcRes lrcResolving:textContent];//将文本转化成字典式的数组
        //_lrcTableView.lrcItemArray = array;
        [_lrcTableView recreveTheLrcArray:array];
    }else {
        [_lrcTableView recreveTheLrcArray:nil];
    }
    [_lrcTableView.lrcTableView reloadData];//这一句很关键，必须要reload一下才好
}

//解析歌词开始
- (void)startResolveLrc:(NSString *)firstName
{
    for (NSString * name in lrcArray) {
        if ([firstName isEqualToString:[name stringByDeletingPathExtension]]) {
            [self readLrcToString:name];
            return;//将lrc文件转化成字符串来进行解析
        }
    }
    [self readLrcToString:nil];
}

#pragma mark - PlayerController

- (void)startPlayer
{
    //用MPMoviePlayerController需要将扩展名去掉
    NSString * firstName = [[self.musicArray objectAtIndex:index] stringByDeletingPathExtension];//去掉扩展名
    
    [self startResolveLrc:firstName];//解析歌词开始
    
    _nameLabel.text = firstName;
    _nameLabel.numberOfLines = 0;
    _player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:firstName ofType:@"mp3"]]];
    _player.view.frame = CGRectMake(-28, 380, 358, 20);
    _player.view.backgroundColor = [UIColor clearColor];
    
    [_player play];
    
    [self.view addSubview:_player.view];
    [self.view sendSubviewToBack:_player.view];
    [self.view bringSubviewToFront:_player.view];
    
    //定时器刷新，让歌词和歌曲同步
   //[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(update) userInfo:nil repeats:YES];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(update) userInfo:nil repeats:YES];

}

#pragma mark - ScrollViewController

- (void)firstPageShow
{
    //这里加歌手或者专辑的图片
    UIImageView * imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"10087822.jpg"]];
    imageView2.frame = CGRectMake(_infoScrollView.bounds.size.width/2-80, _infoScrollView.bounds.size.height/2-80, 160, 160);
    [_infoScrollView addSubview:imageView2];
    [imageView2 release];
}

- (void)secondPageShow
{
    //这里显示歌词
    [_infoScrollView addSubview:_lrcTableView];
}

- (void)creatInfoScrollView
{
    _infoScrollView.backgroundColor = [UIColor clearColor];//先把颜色做上，最后再改
    _infoScrollView.contentSize = CGSizeMake(320*2, 300);
    [self.view addSubview:_infoScrollView];
    _infoScrollView.pagingEnabled = YES;//保证翻得是一整页
    _infoScrollView.showsVerticalScrollIndicator = NO;//不让滚动条显示
    _infoScrollView.showsHorizontalScrollIndicator = NO;
    _infoScrollView.contentOffset = CGPointMake(0, 0);//偏移量，先显示第几张
    
    [self firstPageShow];//对第一页设置
    [self secondPageShow];//对第二页设置
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startPlayer];
    [self creatInfoScrollView];
    
}

- (void)update
{
    //这个地方感觉判断的有点问题，有时候播放完之后会停止，点播放才会播放的
    if (_player.currentPlaybackTime != _player.duration) {
        //根据当前时间让歌词同步
        NSString * currentTime = [NSString stringWithFormat:@"%lf",_player.currentPlaybackTime];
        NSInteger currentPlayRow = [_lrcTableView currentPlayIndex:currentTime];
        [_lrcTableView.lrcTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:currentPlayRow inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];

        [[_lrcTableView.lrcTableView delegate] tableView:_lrcTableView.lrcTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:currentPlayRow inSection:0]];//这个是个回调函数，代理也能用这个
    }
    else if (_player.duration > 0 && _player.currentPlaybackTime == _player.duration){
        //播放完成自动播放下一首
        NSLog(@"finish");
        NSLog(@"_player.duration---%lf",_player.duration);
        [timer invalidate];
        //判断是否单曲循环
        if (oneCyclingPlaying) {
            [self startPlayer];
        } else {
            [self nextButtonPressed:nil];
        }
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
