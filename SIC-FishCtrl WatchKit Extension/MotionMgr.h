//
//  MotionManager.h
//  SIC-FishCtrl
//
//  Created by 王權 on 2015/10/4.
//  Copyright © 2015年 王權. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "MacroDefine.h"

@interface MotionMgr : NSObject

+ (id) sharedMotion;

- (void) startAccWithInterval:(NSTimeInterval)seconds;

- (void) stopAcc;

@end
