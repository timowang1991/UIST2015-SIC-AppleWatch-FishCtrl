//
//  IOSSessionMgr.m
//  SIC-FishCtrl
//
//  Created by 王權 on 2015/10/5.
//  Copyright © 2015年 王權. All rights reserved.
//

#import "IOSSessionMgr.h"

@interface IOSSessionMgr ()

@end


@implementation IOSSessionMgr

+ (id)sharedSession{
    static IOSSessionMgr * sessionMgr = nil;
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
        NSLog(@"WCSession on iOS is supported");
        
        if (![WCSession defaultSession].reachable) {
            NSLog(@"WCSession is unreachable");
        }
    }
    
    return self;
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
    NSString * notificationName = [message valueForKey:KEY_TO_NOTIFY_NAME];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: notificationName object:nil userInfo:message];
}

@end
