//
//  ViewController.m
//  SIC-FishCtrl
//
//  Created by 王權 on 2015/10/4.
//  Copyright © 2015年 王權. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype) init{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAccValues:) name:NOTIFY_NEW_ACC_DATA object:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateAccValues:(id)notification{
    CMAccelerometerData * accData = [[notification userInfo] valueForKey:KEY_TO_ACC_DATA];
//    [self.accXLabel setText:[NSString stringWithFormat:@"----"]];
    [self.accXLabel setText:[NSString stringWithFormat:@"x = %.4f", accData.acceleration.x]];
    [self.accYLabel setText:[NSString stringWithFormat:@"y = %.4f", accData.acceleration.y]];
    [self.accZLabel setText:[NSString stringWithFormat:@"z = %.4f", accData.acceleration.z]];
}

@end
