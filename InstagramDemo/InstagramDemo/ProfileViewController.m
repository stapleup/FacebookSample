//
//  ProfileViewController.m
//  InstagramDemo
//
//  Created by Billa Ustad on 09/02/2015.
//  Copyright (c) 2015 Testing. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize name, profilePic, authToken, userId;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    friends = [[NSMutableArray alloc] init];
    
    userNameLabel.text = name;
    [userProfilePic setImageWithURL:[NSURL URLWithString:profilePic]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *getFollowers = [NSString stringWithFormat:getFollowersString, userId, authToken];
    [manager GET:getFollowers
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             friends = [responseObject objectForKey:@"data"];
             if([friends count]<=0){
                 noResults.hidden = NO;
             }
             [friendTableView reloadData];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             noResults.hidden = NO;
             noResults.text = [NSString stringWithFormat:@"Error, Server returned error code %ld", (long)operation.response.statusCode];
        }
     ];
}

#pragma mark UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 84;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return tableHeaderView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [friends count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileViewCell"];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProfileViewCell" owner:self options:nil];
        cell = (UITableViewCell *)[nib objectAtIndex:0];
    }
    
    NSDictionary *friend = [friends objectAtIndex:indexPath.row];
    ProfileViewCell *mycell = (ProfileViewCell *)cell;
    mycell.userName.text = [friend objectForKey:@"username"];
    [mycell.userProfilePic setImageWithURL:[NSURL URLWithString:[friend objectForKey:@"profile_picture"]]];
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
