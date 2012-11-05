//
//  lrcResolve.h
//  音乐播放器
//
//  Created by ypx on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lrcResolve : NSObject
{
    NSMutableArray * _tempArrayList;//解析lrc文件的每一行数组，包括时间和歌词
    NSMutableArray * _arrayitemList;//解析lrc文件，将时间和歌词分开，数组元素位字典，value为歌词，key为时间
}

@property (nonatomic,assign) NSMutableArray * arrayitemList;

- (NSMutableArray*)lrcResolving:(NSString *)textContent;//开始解析

@end
