//
//  LKCPUSentryCore.m
//  CPUSentry
//
//  Created by Shadow on 2017/8/23.
//  Copyright © 2017年 HoneyLuka. All rights reserved.
//

#import "LKCPUSentryCore.h"
//#import <IntelPowerGadget/IntelPowerGadgetLib.h>
#import <IntelPowerGadget/EnergyLib.h>
//#include <IntelPowerGadget/EnergyLib.h>

@interface LKCPUSentryCore ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LKCPUSentryCore

+ (instancetype)sharedCore
{
    static LKCPUSentryCore *core = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        core = [LKCPUSentryCore new];
    });
    
    return core;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        IntelEnergyLibInitialize();
        [self startTimer];
    }
    return self;
}

- (void)startTimer
{
    [self stopTimer];
    
    self.timer = [NSTimer timerWithTimeInterval:1
                                         target:self
                                       selector:@selector(onTimer)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)onTimer
{
    ReadSample();
    
    //Frequency
    int freqInMHz = 0;
    GetIAFrequency(0, &freqInMHz);
    
    float f = freqInMHz;
    float result = f / 1000.f;
    
    if ([self.delegate respondsToSelector:@selector(core:didUpdateCPUFrequency:)]) {
        [self.delegate core:self didUpdateCPUFrequency:result];
    }
}

@end
