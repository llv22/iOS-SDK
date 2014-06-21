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
    self.title = self.strStuffKey;
    /** invalid code
    if (!self.isInCurrentCity) {
        self.navigationItem.backBarButtonItem.tintColor = [UIColor redColor];
    }
    else{
        self.navigationItem.backBarButtonItem.tintColor = [UIColor purpleColor];
    }
    */
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(performIdentifyStuffLocation:)];
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.isInCurrentCity) {
        //see color for incity case
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    if (self.isInCurrentCity) {
        //see recovery for incity case
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
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
