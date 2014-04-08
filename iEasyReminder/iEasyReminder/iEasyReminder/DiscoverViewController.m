//
//  SecondViewController.m
//  iEasyReminder
//
//  Created by Ding Orlando on 4/7/14.
//  Copyright (c) 2014 Ding Orlando. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

- (void) performRefresh: (id)paramSender;

@end

@implementation DiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // http://iphonedevsdk.com/forum/iphone-sdk-development/16536-uinavigationitem-title-rightbarbuttonitem-color-color-change.html
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                          target:self
                                                                                          action:@selector(performRefresh:)];
}

- (void) performRefresh: (id)paramSender{
    NSLog(@"Action method got refreshed.");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
