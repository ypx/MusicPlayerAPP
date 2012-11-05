//
//  lrcShowTableView.m
//  音乐播放器
//
//  Created by ypx on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "lrcShowTableView.h"

@implementation lrcShowTableView

@synthesize lrcTableView = _lrcTableView;
@synthesize lrcRes = _lrcRes;
//@synthesize lrcItemArray = _lrcItemArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lrcTableView = [[ADLivelyTableView alloc] initWithFrame:CGRectMake(10, 40, 300, 200) style:UITableViewStylePlain];
        [_lrcTableView setInitialCellTransformBlock:ADLivelyTransformWave];
        [_lrcTableView reloadData];
        _lrcTableView.dataSource = self;
        _lrcTableView.delegate = self;
        [self addSubview:_lrcTableView];
        _lrcTableView.backgroundColor = [UIColor clearColor];
        
        _lrcRes = [[lrcResolve alloc] init];
    }
    
    return self;
}


//接收解析后的数组
- (void)recreveTheLrcArray:(NSMutableArray *)array
{
    _lrcItemArray = [[NSMutableArray alloc] initWithCapacity:100];
    [_lrcItemArray removeAllObjects];
    _lrcItemArray = array;
}

//根据当前的时间得到当前应该播放的row of index
- (NSInteger)currentPlayIndex:(NSString*)currentPlayTime
{
    if (!currentPlayTime || currentPlayTime.length <= 0) {
        return 0;
    }
    NSInteger index;
    for (index = 0; index < _lrcItemArray.count; index++) {
        NSDictionary * dict = [_lrcItemArray objectAtIndex:index];
        if (((NSString*)[dict.allKeys objectAtIndex:0]).doubleValue > currentPlayTime.doubleValue) {
            break;
        }
    }
    if (index >0) {
        return index-1;
    }else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_lrcItemArray) {
        return _lrcItemArray.count;
    }else {
        return 5;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"lrctable";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
    }
    if (_lrcItemArray) {
        NSDictionary * dic = [_lrcItemArray objectAtIndex:indexPath.row];
        NSArray * array = [dic allKeys];
        NSString * message = [dic objectForKey:[array objectAtIndex:0]];
        cell.textLabel.text = message;
    }else {
        cell.textLabel.text = @"没找到相应的歌词";
        //[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].textLabel.text = @"没找到相应的歌词";// 这个方法怎么不行呢
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.textColor = [UIColor purpleColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.alpha = 0.2;

    
    //点击下的背景，找到好图片的时候加上
//    UIView * selectBgView = [[UIView alloc] initWithFrame:cell.frame];
//    selectBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"c-2-1.png"]];
//    cell.selectedBackgroundView = selectBgView;
//    [selectBgView release];
       
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.alpha = 1.0;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    //当变大完之后，再让器便会原处
    if (indexPath.row - 1 >= 0) {
        UITableViewCell * cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0]];
        cell1.alpha = 0.3;
        cell1.textLabel.font = [UIFont systemFontOfSize:13];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_lrcTableView release];
    [_lrcRes release];
    [super dealloc];
}

@end
