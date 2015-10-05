//
//  SessionMgr.m
//  SIC-FishCtrl
//
//  Created by 王權 on 2015/10/4.
//  Copyright © 2015年 王權. All rights reserved.
//

#import "SessionMgr.h"

@interface SessionMgr ()

@end

@implementation SessionMgr

+ (id)sharedSession{
    static SessionMgr * sessionMgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionMgr = [[self alloc] init];
    });
    return sessionMgr;
}

- (id)init{
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
        NSLog(@"WCSession is Supported");
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAccDataToIPhone:) name: NOTIFY_NEW_ACC_DATA object:nil];
    
    return self;
}

- (void)sendAccDataToIPhone:(id)notification{
    NSDictionary * accDict = [notification userInfo];
    
    NSLog(@"sendAccDataToIPhone");
    [[WCSession defaultSession] sendMessage:accDict
                               replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        NSLog(@"replyMessage : %@", replyMessage);
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"error : %@", error);
    }];
}

@end
