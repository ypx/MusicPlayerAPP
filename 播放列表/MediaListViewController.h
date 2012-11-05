//
//  MediaListViewController.h
//  音乐播放器2
//
//  Created by ypx on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicCell.h"
#import "ADLivelyTableView.h"
#import "PlayViewController.h"

@interface MediaListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * _mp3Array;
    NSMutableArray * _lrcArray;
    ADLivelyTableView * _musicListTableView;
    PlayViewController * _playing;
}

@end
