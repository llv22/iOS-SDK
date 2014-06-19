//
//  IERLocateStuffViewController.m
//  iEasyReminder
//
//  Created by Ding, Orlando on 6/19/14.
//  Copyright (c) 2014 Ding Orlando. All rights reserved.
//

#import "IERLocateStuffViewController.h"

@interface IERLocateStuffViewController ()

@end

@implementation IERLocateStuffViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@ in %@", self.strStuffKey, self.strHostedCity];
    if (!self.isInCurrentCity) {
        NSLog(@"not in current city - %@", self.strHostedCity);
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(performIdentifyStuffLocation:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)performIdentifyStuffLocation: (id)paramSender{
    
}

@end
