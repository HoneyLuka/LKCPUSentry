//
//  AppDelegate.m
//  CPUSentry
//
//  Created by Shadow on 2017/8/22.
//  Copyright © 2017年 HoneyLuka. All rights reserved.
//

#import "AppDelegate.h"
#import "LKCPUSentryCore.h"

@interface AppDelegate () <LKCPUSentryCoreDelegate>

@property (nonatomic, strong) IBOutlet NSMenu *menu;
@property (nonatomic, strong) IBOutlet NSMenuItem *quitItem;
@property (nonatomic, strong) NSStatusItem *statusItem;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.statusItem = [[NSStatusBar systemStatusBar]statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.title = @"N/A";
    self.statusItem.menu = self.menu;
    
    [LKCPUSentryCore sharedCore].delegate = self;
}

- (void)core:(LKCPUSentryCore *)core didUpdateCPUFrequency:(float)frequency
{
    self.statusItem.title = [NSString stringWithFormat:@"%.1f", frequency];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    
}

- (IBAction)closeAppAction:(id)sender
{
    [[NSApplication sharedApplication]terminate:self];
}

@end
