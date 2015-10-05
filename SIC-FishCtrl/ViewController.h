//
//  ViewController.h
//  SIC-FishCtrl
//
//  Created by 王權 on 2015/10/4.
//  Copyright © 2015年 王權. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "MacroDefine.h"
#import "IOSSessionMgr.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *accXLabel;
@property (weak, nonatomic) IBOutlet UILabel *accYLabel;
@property (weak, nonatomic) IBOutlet UILabel *accZLabel;


@end

