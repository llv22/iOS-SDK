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
    // Should be replaced with refreshed rotation
    // http://stackoverflow.com/questions/2965737/replace-uibarbuttonitem-with-uiactivityindicatorview
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.navigationItem.rightBarButtonItem.width, self.navigationItem.rightBarButtonItem.width)];
    UIBarButtonItem *activityItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    self.navigationItem.rightBarButtonItem = activityItem;
    [activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Action method got refreshed.");
        sleep(3);
        NSLog(@"Action method got done.");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                                  target:self
                                                                                                  action:@selector(performRefresh:)];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
