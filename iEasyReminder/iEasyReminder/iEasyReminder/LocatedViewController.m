//
//  LocatedViewController.m
//  iEasyReminder
//
//  Created by Ding, Orlando on 6/23/14.
//  Copyright (c) 2014 Ding Orlando. All rights reserved.
//

#import "LocatedViewController.h"

@interface LocatedViewController ()

@end

@implementation LocatedViewController

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
    UILabel* item= [[UILabel alloc]init];
    item.text = @"LineLocate";
    [self.view addSubview:item];
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

@end
