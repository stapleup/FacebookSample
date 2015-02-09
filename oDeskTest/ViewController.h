//
//  ViewController.h
//  oDeskTest
//
//  Created by Billa Ustad on 09/02/2015.
//  Copyright (c) 2015 Tilal Husain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <AddressBook/AddressBook.h>

@interface ViewController : UIViewController <FBLoginViewDelegate, FBViewControllerDelegate>
{
    IBOutlet UIView *dashBoard;
    IBOutlet UILabel *nameLabel;
    IBOutlet FBLoginView *loginView;
    FBFriendPickerViewController *friendPicker;
    IBOutlet FBProfilePictureView *profilePictureView;
}

-(IBAction)showFriends:(id)sender;

@end
