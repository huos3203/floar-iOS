//
//  HeartBeatManager.h
//  Welinked2
//
//  Created by jonas on 12/13/13.
//
//

#import <Foundation/Foundation.h>
#import "Common.h"
@interface HeartBeatManager : NSObject
{
    BOOL beatFinished;
    NSTimer* networkTimer;
    NSTimer* dataTimer;
    NSMutableDictionary* methods;
    NSMutableDictionary* data;
    
}
-(void)queryNetwork;
-(void)start;
-(void)end;
-(void)registerInvokeMethod:(NSString*)key callback:(EventCallBack)callback;
-(void)setDataWithKey:(NSString*)key value:(id)value;
+(HeartBeatManager*)sharedInstane;
@end
