//
//  FirstViewController.m
//  iEasyReminder
//
//  Created by Ding Orlando on 4/7/14.
//  Copyright (c) 2014 Ding Orlando. All rights reserved.
//

#import "ContextViewController.h"
#import "IERContextSectionHeader.h"

@interface ContextViewController ()

@property(strong, nonatomic) NSDictionary* ctxtGroup;
@property(assign, nonatomic) int currentExpandedIndex;

@end

@interface ContextViewTableCell : UITableViewCell

@end


@implementation ContextViewTableCell

// TODO : instancetype see http://clang.llvm.org/docs/LanguageExtensions.html#objective-c-features and http://blog.csdn.net/wzzvictory/article/details/16994913
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

@end

@implementation ContextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // TODO : ctxtGroup should be read out and persisted into Core Data model
    self.ctxtGroup = @{
                       @"Nanjing": @[@"front door", @"middle door", @"slipped door", @"fridge", @"TV", @"wardrobe", @"bookshelf", @"computer desk"],
                       @"Chengdu": @[@"front door", @"bedroom", @"library"],
                       @"Chongzhou": @[@"front roor", @"bedroom", @"computer room"]
                       };
    
    [self.tableView registerClass:[ContextViewTableCell class] forCellReuseIdentifier:@"ContextViewTableCellIdentifier"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openGroupContextAtIndex:(int)sectionIndex{
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.ctxtGroup allKeys]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.currentExpandedIndex == section) {
        NSString* key = [[self.ctxtGroup allKeys]objectAtIndex:section];
        return [self.ctxtGroup[key] count];
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ContextViewTableCellIdentifier" forIndexPath:indexPath];
    NSString* str = (self.ctxtGroup[[[self.ctxtGroup allKeys]objectAtIndex:indexPath.section]])[indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.ctxtGroup allKeys][section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {	
	return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

// TODO : override the default section header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    IERContextSectionHeader* header = [[[UINib nibWithNibName:@"IERContextSectionHeader" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    [header.mainButton setTitle:[self.ctxtGroup allKeys][section] forState:UIControlStateNormal];
    header.buttonTappedHandler = ^{
        [self openGroupContextAtIndex:section];
    };
    return header;
}


@end
