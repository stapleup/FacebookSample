//
//  ViewController.m
//  InstagramDemo
//
//  Created by Billa Ustad on 09/02/2015.
//  Copyright (c) 2015 Testing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)loginWithInstagram:(id)sender{
    InstagramViewController *instagram = [[InstagramViewController alloc] initWithNibName:@"InstagramViewController" bundle:nil];
    [self.navigationController pushViewController:instagram animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
