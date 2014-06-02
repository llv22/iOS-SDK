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
@property(assign, nonatomic) NSUInteger currentExpandedIndex;

- (void)performAddIdot: (id)paramSender;

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
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(performAddIdot:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performAddIdot: (id)paramSender{
    
}

- (void)retrieveCurrentExpanedSection:(NSMutableArray *)indexPaths {
    NSUInteger sectionCount = [self.ctxtGroup[[self.ctxtGroup allKeys][self.currentExpandedIndex]] count];
    for (int i=0; i<sectionCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:self.currentExpandedIndex];
        [indexPaths addObject:indexPath];
    }
}

// TODO : open target group via sectionIndex
- (void)openGroupContextAtIndex:(NSUInteger)sectionIndex{
//    if (self.currentExpandedIndex == sectionIndex) {
//        return;
//    }
    
    //TODO : delete currentExpandedIndex items
    NSMutableArray *indexPaths = [NSMutableArray array];
    [self retrieveCurrentExpanedSection:indexPaths];
    //TODO : to avoid UI exception
    self.currentExpandedIndex = -1;
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    
    //TODO : insert the self.currentExpandedIndex <= sectionIndex of section group
    self.currentExpandedIndex = sectionIndex;
    [indexPaths removeAllObjects];
    [self retrieveCurrentExpanedSection:indexPaths];
    
    double delayInSeconds = 0.35;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    });
    
    [self.tableView endUpdates];
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
    if(cell.accessoryType != UITableViewCellAccessoryDisclosureIndicator){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
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
