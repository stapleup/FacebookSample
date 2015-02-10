//
//  ProfileViewController.h
//  InstagramDemo
//
//  Created by Billa Ustad on 09/02/2015.
//  Copyright (c) 2015 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "AFNetworking.h"
#import "ProfileViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>
{
    NSMutableArray *friends;
    IBOutlet UILabel *noResults;
    IBOutlet UILabel *userNameLabel;
    IBOutlet UIView *tableHeaderView;
    IBOutlet UIImageView *userProfilePic;
    IBOutlet UITableView *friendTableView;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *authToken;
@property (nonatomic, retain) NSString *profilePic;

@end
