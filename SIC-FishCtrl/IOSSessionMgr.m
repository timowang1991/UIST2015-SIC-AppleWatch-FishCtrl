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
    NSLog(@"iOS init");
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

//- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSString * notificationName = [message valueForKey:KEY_TO_NOTIFY_NAME];
//        
//        self.x = [[message valueForKey:KEY_TO_ACC_X_DATA] doubleValue];
//        self.notificationName = notificationName;
//        [[NSNotificationCenter defaultCenter] postNotificationName: notificationName object:nil userInfo:message];
//    });
//}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message{
    NSLog(@"x = %@, y = %@, z = %@",
          [message valueForKey:KEY_TO_ACC_X_DATA],
          [message valueForKey:KEY_TO_ACC_Y_DATA],
          [message valueForKey:KEY_TO_ACC_Z_DATA]);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString * notificationName = [message valueForKey:KEY_TO_NOTIFY_NAME];
        
        self.x = [[message valueForKey:KEY_TO_ACC_X_DATA] doubleValue];
        self.notificationName = notificationName;
        [[NSNotificationCenter defaultCenter] postNotificationName: notificationName object:nil userInfo:message];
    });
}

@end
