//
//  InstagramViewController.h
//  InstagramDemo
//
//  Created by Billa Ustad on 09/02/2015.
//  Copyright (c) 2015 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "AFNetworking.h"
#import "ProfileViewController.h"

@interface InstagramViewController : UIViewController
{
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *indicator;
}
@end
