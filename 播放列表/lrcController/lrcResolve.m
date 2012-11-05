//
//  lrcResolve.m
//  音乐播放器
//
//  Created by ypx on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "lrcResolve.h"

@implementation lrcResolve

@synthesize arrayitemList = _arrayitemList;

- (id)init
{
    self = [super init];
    if (self) {
        _tempArrayList = [[NSMutableArray alloc] initWithCapacity:100];
    }
    return self;
}

//解析没一行，将没一行的time和内容分开
- (void)parseLrcLine:(NSString*)sourcrLineText
{
    if (!sourcrLineText || sourcrLineText.length <= 0) {
        return;
    }
    
    NSRange rang = [sourcrLineText rangeOfString:@"]"];
    if (rang.length > 0) {
        NSString * time = [sourcrLineText substringToIndex:rang.location+1];
        //NSLog(@"time = %@",time);
        NSString * other = [sourcrLineText substringFromIndex:rang.location+1];
        //NSLog(@"other = %@",other);
        if (time || time.length > 0) {
            [_tempArrayList addObject:time];
        }
        if (other) {
            [self parseLrcLine:other];//这里的递归用法，是把时间全取出来
        }
    }else {
        [_tempArrayList addObject:sourcrLineText]; 
    }
}

// 转换成以秒为单位的时间计数器
-(NSString *)timeToSecond:(NSString *)formatTime {
    if (!formatTime || formatTime.length <= 0)
    {
        return nil;
    }
    if ([formatTime rangeOfString:@"["].length <= 0 && [formatTime rangeOfString:@"]"].length <= 0)
    {
        return nil;
    }
    NSString * minutes = [formatTime substringWithRange:NSMakeRange(1, 2)];
    NSString * second = [formatTime substringWithRange:NSMakeRange(4, 5)];
    float finishSecond = minutes.floatValue * 60 + second.floatValue;
    return [NSString stringWithFormat:@"%f",finishSecond];
}
//解析数组，将数组转换成字典key是以秒位单位的时间，并存放在另一个数组中
- (void)parseTempArray:(NSMutableArray*)tempArray
{
    if (!tempArray || tempArray.count <= 0) {
        return;
    }
    NSString * valueString = [tempArray lastObject];
    if (!valueString || ([valueString rangeOfString:@"["].length > 0 && [valueString rangeOfString:@"]"].length > 0)) {
        [_tempArrayList removeAllObjects];
        return;
    }
    for (int i = 0 ; i < tempArray.count-1; i++) {
        NSMutableDictionary * dict = [[[NSMutableDictionary alloc] init] autorelease];
        NSString * key = [tempArray objectAtIndex:i];
        NSString * secondKey = [self timeToSecond:key];// 转换成以秒为单位的时间计数器
        [dict setObject:valueString forKey:secondKey];
        //NSLog(@"dict = %@",dict);
        [_arrayitemList addObject:dict];
    }
    [_tempArrayList removeAllObjects];
}

//根据时间顺序对数组进行排序
- (void)sortAllItems:(NSMutableArray*)itemsArray
{
    if (!itemsArray || itemsArray.count <= 0) {
        return;
    }
    //采用冒泡排序
    for (int i = 0; i < itemsArray.count - 1; i++) {
        for (int j = 0; j < itemsArray.count - i -1; j++) {
            NSDictionary * firstDic = [itemsArray objectAtIndex:j];
            NSDictionary * secondDic = [itemsArray objectAtIndex:j+1];
            NSString * firstTime = [[firstDic allKeys] objectAtIndex:0];
            NSString * secondTime = [[secondDic allKeys] objectAtIndex:0];
            if (firstTime.floatValue > secondTime.floatValue) {
                [itemsArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
}

//解析主程序
- (NSMutableArray*)lrcResolving:(NSString *)textContent
{
    _arrayitemList = [[NSMutableArray alloc] initWithCapacity:100];
    [_arrayitemList removeAllObjects];
    if (textContent) {
        NSArray * tempArray = [textContent componentsSeparatedByString:@"\n"];
        //NSLog(@"tempArray = %@",tempArray);
        for (NSString * string in tempArray) {
            [self parseLrcLine:string];//解析没一行，将没一行的time和内容分开
            [self parseTempArray:_tempArrayList];//解析数组，将数组转换成字典key是以秒位单位的时间，并存放在另一个数组中
        }
        [self sortAllItems:_arrayitemList];//根据时间顺序对数组进行排序
        //NSLog(@"_arrayitemList = %@",_arrayitemList);
        return _arrayitemList;
    }else {
        return nil;
    }
}

- (void)dealloc
{
    [_arrayitemList release];
    [_tempArrayList release];
    [super dealloc];
}

@end
