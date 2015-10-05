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
    [IOSSessionMgr sharedSession];
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
    NSDictionary * accDict = [notification userInfo];
//    [self.accXLabel setText:@"message received"];
//    [self.accXLabel setText:[NSString stringWithFormat:@"----"]];
    [self.accXLabel setText:[NSString stringWithFormat:@"x = %.4f", [[accDict valueForKey:KEY_TO_ACC_X_DATA] doubleValue]]];
    [self.accYLabel setText:[NSString stringWithFormat:@"y = %.4f", [[accDict valueForKey:KEY_TO_ACC_Y_DATA] doubleValue]]];
    [self.accZLabel setText:[NSString stringWithFormat:@"z = %.4f", [[accDict valueForKey:KEY_TO_ACC_Z_DATA] doubleValue]]];
}

@end
