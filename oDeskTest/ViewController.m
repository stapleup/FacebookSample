//
//  ViewController.m
//  oDeskTest
//
//  Created by Billa Ustad on 09/02/2015.
//  Copyright (c) 2015 Tilal Husain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    loginView.readPermissions = @[@"public_profile", @"user_friends"];
    loginView.delegate = self;
}
-(void)showFriends:(id)sender{
    friendPicker = [[FBFriendPickerViewController alloc] init];
    friendPicker.delegate = self;
    [friendPicker loadData];
    [self presentViewController:friendPicker animated:YES completion:nil];
}

#pragma mark FBLoginViewDelegate

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    profilePictureView.profileID = user.objectID;
    nameLabel.text = user.name;
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    dashBoard.hidden = NO;
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    profilePictureView.profileID = nil;
    nameLabel.text = @"";
    dashBoard.hidden = YES;
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage;
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertMessage = [FBErrorUtility userMessageForError:error];
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertMessage = @"Your current session is no longer valid. Please log in again.";
    } else {
        alertMessage = @"Please try again later.";
    }
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:@"Ooops"
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

#pragma mark FBViewControllerDelegate

- (void)facebookViewControllerCancelWasPressed:(id)sender{
    [friendPicker dismissViewControllerAnimated:YES completion:Nil];
}
- (void)facebookViewControllerDoneWasPressed:(id)sender{
    [friendPicker dismissViewControllerAnimated:YES completion:Nil];
}

@end
