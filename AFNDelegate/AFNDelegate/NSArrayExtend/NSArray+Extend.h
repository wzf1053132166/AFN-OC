//
//  NSArray+Extend.h
//  startogether
//
//  Created by Ezio on 13-11-27.
//  Copyright (c) 2013年 bailey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSArray (Extend)

- (NSString *)stringForCheckedKey:(id)key;

- (id)objectAtCheckedIndex:(int)index;

- (NSString *)stringAtCheckedIndex:(int)index;

@end

@interface NSMutableArray (Extend)

- (void)addCheckedObject:(id)object;

@end


@interface NSDictionary (Extend)

- (id)objectForCheckedKey:(id)key;

- (NSString *)stringForCheckedKey:(id)key;

@end
