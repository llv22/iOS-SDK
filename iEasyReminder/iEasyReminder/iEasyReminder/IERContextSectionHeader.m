//
//  IERContextSectionHeader.m
//  iEasyReminder
//
//  Created by Ding Orlando on 6/2/14.
//  Copyright (c) 2014 Ding Orlando. All rights reserved.
//

#import "IERContextSectionHeader.h"

@implementation IERContextSectionHeader

-(void) awakeFromNib {
    self.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.6].CGColor;
    self.layer.borderWidth = 1.0f;
    [super awakeFromNib];
}

-(IBAction)buttonTapped:(id)sender {
    if(self.buttonTappedHandler)
        self.buttonTappedHandler();
}

@end
