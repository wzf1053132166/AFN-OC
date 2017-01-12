//
//  NSArray+Extend.m
//  startogether
//
//  Created by Ezio on 13-11-27.
//  Copyright (c) 2013年 bailey. All rights reserved.
//

#import "NSArray+Extend.h"

@implementation NSArray (Extend)

- (id)objectForCheckedKey:(id)key
{
    return nil;
}



- (NSString *)stringForCheckedKey:(id)key
{
    return @"";
}

//检查index是否超过总大小
- (id)objectAtCheckedIndex:(int)index
{
    if ([self count] <= index) {
//        DLog(@"NSArray数据超过容量");
        return nil;
    }
    else if (index <= -1) {
//        DLog(@"index 错误");
        return nil;
    }
    else
    {
        return [self objectAtIndex:index];
    }
}

- (NSString *)stringAtCheckedIndex:(int)index
{
    if ([self count] <= index) {
        //        DLog(@"NSArray数据超过容量");
        return @"";
    }
    else if (index <= -1) {
        //        DLog(@"index 错误");
        return @"";
    }
    else
    {
        return (NSString *)[self objectAtIndex:index];
    }
}

@end


@implementation NSMutableArray (Extend)

- (id)objectForCheckedKey:(id)key
{
    return nil;
}


- (void)addCheckedObject:(id)object
{
    if (object != nil) {
        [self addObject:object];
    }
    else
    {
        NSLog(@"");
    }
}

@end

@implementation NSDictionary (Extend)

- (id)objectForCheckedKey:(id)key
{
    id object_ = [self objectForKey:key];
    
    if ([object_ isKindOfClass:[NSNull class] ]) {
        return nil;
    }
    
    return object_;
}

- (NSString *)stringForCheckedKey:(id)key
{    
    id object_ = [self objectForKey:key];
    
    if ([object_ isKindOfClass:[NSString class] ]) {
        
        return object_;
    }
    
    if([object_ isKindOfClass:[NSNumber class] ]) {
        
        return [object_ stringValue];
    }
    else if ([object_ isKindOfClass:[NSString class] ]) {
        
        return @"";
    }
    else
    {
        return @"";
    }
}


@end
