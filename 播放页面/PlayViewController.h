//
//  PlayViewController.h
//  音乐播放器2
//
//  Created by ypx on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "lrcShowTableView.h"
#import "MusicSettingViewController.h"

@interface PlayViewController : UIViewController
{
    MPMoviePlayerController * _player;
    IBOutlet UILabel * _nameLabel;//歌曲名label
    UIScrollView * _infoScrollView;//这里放歌词和歌手的图片
    lrcShowTableView * _lrcTableView;
    lrcResolve * _lrcRes;
    NSTimer * timer;
    MusicSettingViewController * _musicSetting;
    BOOL playing;
    BOOL oneCyclingPlaying;
}


@property (nonatomic,retain) NSMutableArray * musicArray;//接收歌曲列表的数组
@property (nonatomic,assign) NSInteger index;//接收选择的是数组中的第几首歌（既是数组中的第几个元素）
@property (nonatomic,retain) NSMutableArray * lrcArray;//接收歌词列表的数组
@property (nonatomic,retain) MPMoviePlayerController * player;

- (IBAction)backButtonPressed:(id)sender;//触控返回列表按钮
- (IBAction)playAndPauseButtonPressed:(id)sender;//触控播放和暂停按钮
- (IBAction)nextButtonPressed:(id)sender;//下一首按钮
- (IBAction)prevButtonPressed:(id)sender;//上一首按钮
- (IBAction)settingButtonPressed:(id)sender;
- (IBAction)cyclingButtonPressed:(id)sender;//单曲循环按钮

- (void)startPlayer;//开始音乐

@end
