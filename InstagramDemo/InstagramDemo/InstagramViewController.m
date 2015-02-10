//
//  InstagramViewController.h
//  InstagramDemo
//
//  Created by Billa Ustad on 09/02/2015.
//  Copyright (c) 2015 Testing. All rights reserved.
//

#import "InstagramViewController.h"

@interface InstagramViewController ()

@end

@implementation InstagramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [indicator startAnimating];
    NSString *fullAuthUrlString = [[NSString alloc]
                                   initWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=code&scope=basic+relationships",
                                   authUrlString,
                                   clientID,
                                   redirectUri
                                   ];
    NSURL *authUrl = [NSURL URLWithString:fullAuthUrlString];
    NSURLRequest *myRequest = [[NSURLRequest alloc] initWithURL:authUrl];
    [webView loadRequest:myRequest];
}

#pragma mark WebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [indicator stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *Url = [request URL];
    if ([[Url host] isEqualToString:@"localhost"]) {
        
        NSString *urlResources = [Url resourceSpecifier];
        urlResources = [urlResources stringByReplacingOccurrencesOfString:@"?" withString:@""];
        urlResources = [urlResources stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        NSArray *urlResourcesArray = [urlResources componentsSeparatedByString:@"/"];
        NSString *urlParamaters = [urlResourcesArray objectAtIndex:([urlResourcesArray count]-1)];
        NSArray *urlParamatersArray = [urlParamaters componentsSeparatedByString:@"&"];
        
        if([urlParamatersArray count] == 1) {
            NSString *keyValue = [urlParamatersArray objectAtIndex:(0)];
            NSArray *keyValueArray = [keyValue componentsSeparatedByString:@"="];
            if([[keyValueArray objectAtIndex:(0)] isEqualToString:@"code"]) {
                
                NSString *code = [keyValueArray objectAtIndex:(1)];
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                NSDictionary *data = @{@"code":code, @"client_id":clientID, @"client_secret":clientSecret, @"redirect_uri":redirectUri, @"grant_type":@"authorization_code"};
                
                [manager POST:tokenUrlString
                   parameters:data
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                          NSDictionary *user = [responseObject objectForKey:@"user"];
                          
                          AppState *state = [AppState getAppState];
                          state.user_id = [user objectForKey:@"id"];
                          state.user_name = [user objectForKey:@"username"];
                          state.user_pic = [user objectForKey:@"profile_picture"];
                          state.authToken = [responseObject objectForKey:@"access_token"];
                          [AppState synchronizeSettingsToPhone];
                          
                          ProfileViewController *profile = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
                          profile.userId = [user objectForKey:@"id"];
                          profile.name = [user objectForKey:@"username"];
                          profile.profilePic = [user objectForKey:@"profile_picture"];
                          profile.authToken = [responseObject objectForKey:@"access_token"];
                          [self.navigationController pushViewController:profile animated:YES];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                }];
            }
        } else {
            // TODO: error handling goes here
        }
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
