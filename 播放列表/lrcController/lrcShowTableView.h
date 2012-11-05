//
//  lrcShowTableView.h
//  音乐播放器
//
//  Created by ypx on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lrcResolve.h"
#import "ADLivelyTableView.h"

@interface lrcShowTableView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    ADLivelyTableView * _lrcTableView;
    lrcResolve * _lrcRes;
    NSMutableArray * _lrcItemArray;
}

@property (nonatomic,retain) ADLivelyTableView * lrcTableView;
@property (nonatomic,retain) lrcResolve * lrcRes;
//@property (nonatomic,retain) NSMutableArray * lrcItemArray;

- (void)recreveTheLrcArray:(NSMutableArray *)array;
- (NSInteger)currentPlayIndex:(NSString*)currentPlayTime;

@end
