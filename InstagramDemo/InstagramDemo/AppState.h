//
//  AppState.h
//  InstagramDemo
//
//  Created by Billa Ustad on 09/02/2015.
//  Copyright (c) 2015 Testing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppState;

@interface AppState : NSObject

@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *user_name;
@property (nonatomic, retain) NSString *user_pic;
@property (nonatomic, retain) NSString *authToken;

+(AppState*) getAppState;
+(void) setAppState;
+(void) synchronizeSettingsToPhone;
+(void) synchronizeSettingsFromPhone;

@end
