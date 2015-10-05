//
//  InterfaceController.m
//  SIC-FishCtrl WatchKit Extension
//
//  Created by 王權 on 2015/10/4.
//  Copyright © 2015年 王權. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@property float accSliderValue;

@end


@implementation InterfaceController

# pragma mark - Life Cycle
- (instancetype)init{
    self = [super init];
    [SessionMgr sharedSession];
    return self;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    self.accSliderValue = INITIAL_ACC_INTERVAL;
    [self.accIntervalLabel setText:[NSString stringWithFormat:@"Interval = %.3fs", INITIAL_ACC_INTERVAL]];
    [self.accIntervalSlider setValue:INITIAL_ACC_INTERVAL];
//    [[MotionMgr sharedMotion] startAccWithInterval:INITIAL_ACC_INTERVAL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAccLabels:) name:NOTIFY_NEW_ACC_DATA object:nil];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

# pragma mark - Acc Results
- (void)updateAccLabels:(id)notification{
    NSDictionary * accDict = [notification userInfo];
    
    [self.accXLabel setText:[NSString stringWithFormat:@"x = %.4f", [[accDict valueForKey:KEY_TO_ACC_X_DATA] doubleValue]]];
    [self.accYLabel setText:[NSString stringWithFormat:@"y = %.4f", [[accDict valueForKey:KEY_TO_ACC_Y_DATA] doubleValue]]];
    [self.accZLabel setText:[NSString stringWithFormat:@"z = %.4f", [[accDict valueForKey:KEY_TO_ACC_Z_DATA] doubleValue]]];
}

# pragma mark - Acc Control
- (IBAction)accIntervalSliderChanged:(float)value {
    [[MotionMgr sharedMotion] startAccWithInterval:value];
    
    self.accSliderValue = value;
    [self.accIntervalLabel setText:[NSString stringWithFormat:@"Interval = %.3fs", value]];
}

- (IBAction)accStartButtonPushed {
    [[MotionMgr sharedMotion] startAccWithInterval:self.accSliderValue];
}

- (IBAction)accStopButtonPushed {
    [[MotionMgr sharedMotion] stopAcc];
}

@end



