//
//  AppState.m
//  InstagramDemo
//
//  Created by Billa Ustad on 09/02/2015.
//  Copyright (c) 2015 Testing. All rights reserved.
//

#import "AppState.h"

static AppState *currentAppState = nil;

@implementation AppState


@synthesize user_id, user_name, user_pic, authToken;

#pragma mark -
#pragma mark Singleton Methods

+(AppState *)getAppState{
    if(currentAppState == nil){
        currentAppState = [[super allocWithZone:NULL] init];
    }
    return currentAppState;
}
+(void)setAppState{
    currentAppState = nil;
}
+(void)logoutUser{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    currentAppState = nil;
    [AppState synchronizeSettingsFromPhone];
}
+(void)synchronizeSettingsToPhone{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:currentAppState.user_id forKey:@"user_id"];
    [prefs setObject:currentAppState.user_name forKey:@"user_name"];
    [prefs setObject:currentAppState.user_pic forKey:@"user_pic"];
    [prefs setObject:currentAppState.authToken forKey:@"authToken"];
    [prefs synchronize];
}
+(void)synchronizeSettingsFromPhone{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AppState *appData   = [AppState getAppState];
    appData.user_id     = [prefs objectForKey:@"user_id"];
    appData.user_name   = [prefs objectForKey:@"user_name"];
    appData.user_pic    = [prefs objectForKey:@"user_pic"];
    appData.authToken   = [prefs objectForKey:@"authToken"];
    if(appData.user_id==nil){
        appData.user_id = @"0";
    }
}
@end
