//
//  SessionMgr.h
//  SIC-FishCtrl
//
//  Created by 王權 on 2015/10/4.
//  Copyright © 2015年 王權. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import "MacroDefine.h"

@interface SessionMgr : NSObject <WCSessionDelegate>

+ (id) sharedSession;

@end
