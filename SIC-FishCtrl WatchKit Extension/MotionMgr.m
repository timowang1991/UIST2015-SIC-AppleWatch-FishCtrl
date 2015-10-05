//
//  MotionManager.m
//  SIC-FishCtrl
//
//  Created by 王權 on 2015/10/4.
//  Copyright © 2015年 王權. All rights reserved.
//

#import "MotionMgr.h"

@interface MotionMgr()

@property CMMotionManager * motionManager;

@end

@implementation MotionMgr

+ (id) sharedMotion{
    static MotionMgr * motionMgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        motionMgr = [[self alloc] init];
                         });
    return motionMgr;
}

- (id)init{
    if (self = [super init]){
        
    }
    self.motionManager = [[CMMotionManager alloc] init];
    return self;
}

- (void) startAccWithInterval:(NSTimeInterval)seconds{
    [self.motionManager setAccelerometerUpdateInterval:seconds];
    
    if (!self.motionManager.accelerometerAvailable) {
        NSLog(@"accelerometer unavailable");
        return;
    }
    
    if (self.motionManager.accelerometerActive) {
//        NSLog(@"accelerometer already active");
        return;
    }
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"startAccWithInterval error : %@", error);
        }
        
//        NSLog(@"x = %f", accelerometerData.acceleration.x);
//        NSLog(@"y = %f", accelerometerData.acceleration.y);
//        NSLog(@"z = %f", accelerometerData.acceleration.z);
        
        NSDictionary * accDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        NOTIFY_NEW_ACC_DATA, KEY_TO_NOTIFY_NAME,
                                        accelerometerData, KEY_TO_ACC_DATA, nil];
        
        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:NOTIFY_NEW_ACC_DATA object:nil userInfo:accDictionary];
    }];
}

- (void) stopAcc{
    [self.motionManager stopAccelerometerUpdates];
}

@end
