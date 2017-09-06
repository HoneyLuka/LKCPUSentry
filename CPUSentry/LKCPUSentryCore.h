//
//  LKCPUSentryCore.h
//  CPUSentry
//
//  Created by Shadow on 2017/8/23.
//  Copyright © 2017年 HoneyLuka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LKCPUSentryCore;
@protocol LKCPUSentryCoreDelegate <NSObject>

- (void)core:(LKCPUSentryCore *)core didUpdateCPUFrequency:(float)frequency;

@end

@interface LKCPUSentryCore : NSObject

@property (nonatomic, weak) id<LKCPUSentryCoreDelegate> delegate;

+ (instancetype)sharedCore;

@end
