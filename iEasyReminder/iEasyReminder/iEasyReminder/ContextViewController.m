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

// see : instancetype see http://clang.llvm.org/docs/LanguageExtensions.html#objective-c-features and http://blog.csdn.net/wzzvictory/article/details/16994913
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

@end

@implementation ContextViewController

-(void) awakeFromNib {
    self.currentExpandedIndex = -1;
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    if(self->_cllocationManager == nil){
        self->_cllocationManager = [[CLLocationManager alloc]init];
        self->_cllocationManager.delegate = self;
        self->_cllocationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // Set a movement threshold for new events.
        self->_cllocationManager.distanceFilter = 500; // meters
        [self->_cllocationManager startUpdatingLocation];
    }
    
    if(self->_geocoder == nil){
        self->_geocoder = [[CLGeocoder alloc]init];
    }
    
    // see : ctxtGroup should be read out and persisted into Core Data model
    self.ctxtGroup = @{
                       @"Nanjing": @[@"front door", @"middle door", @"slipped door", @"fridge", @"TV", @"wardrobe", @"bookshelf", @"computer desk"],
                       @"Chengdu": @[@"front door", @"bedroom", @"library"],
                       @"Chongzhou": @[@"front roor", @"bedroom", @"computer room"]
                       };
    
    [self.tableView registerClass:[ContextViewTableCell class] forCellReuseIdentifier:@"ContextViewTableCellIdentifier"];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(performAddIdot:)];
}

//see : set delegete for cllocation manager - CLLocationManagerDelegate protocol.
//see https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/LocationAwarenessPG/CoreLocation/CoreLocation.html#//apple_ref/doc/uid/TP40009497-CH2-SW2
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations{
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        if (self->_clplacemark) {
            return;
        }
        [self->_geocoder reverseGeocodeLocation:location
                              completionHandler:^(NSArray *placemarks, NSError *error) {
                                  //see : supposed not so frequent changes
                                  if ([placemarks count] > 0) {
                                      self->_clplacemark = placemarks[0];
                                      //see : __weak for _clplacemark for input parameters
                                      CLPlacemark* _bl_clplacemark = placemarks[0];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          __block int iSectionId = 0;
                                          [self.ctxtGroup enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL *stop) {
                                              if([key localizedCaseInsensitiveCompare:_bl_clplacemark.locality] == NSOrderedSame){
                                                  *stop = YES;
                                              }
                                              if(!(*stop)){
                                                  iSectionId++;
                                              }
                                          }];
                                          //see : switch to current city location, if current expandedIndex hasn't been set
                                          if(self.currentExpandedIndex == -1){
                                              [self openGroupContextAtIndex:iSectionId];
                                          }
                                          //TODO : if locality hasn't been colorized
                                      });
                                  }
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performAddIdot: (id)paramSender{
    
}

- (void)retrieveCurrentExpanedSection:(NSMutableArray *)indexPaths {
    if(self.currentExpandedIndex == -1){
        return;
    }
    NSUInteger sectionCount = [self.ctxtGroup[[self.ctxtGroup allKeys][self.currentExpandedIndex]] count];
    for (int i=0; i<sectionCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:self.currentExpandedIndex];
        [indexPaths addObject:indexPath];
    }
}

// see : open target group via sectionIndex
- (void)openGroupContextAtIndex:(NSUInteger)sectionIndex{
//    if (self.currentExpandedIndex == sectionIndex) {
//        return;
//    }
    
    //see : delete currentExpandedIndex items
    NSMutableArray *indexPaths = [NSMutableArray array];
    [self retrieveCurrentExpanedSection:indexPaths];
    //see : to avoid UI exception
    self.currentExpandedIndex = -1;
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    
    //see : insert the self.currentExpandedIndex <= sectionIndex of section group
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
    //see : add uilabel text for italicSystemFont - http://stackoverflow.com/questions/3586871/bold-non-bold-text-in-a-single-uilabel
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = NSMakeRange(0, str.length);
    [attrStr setAttributes:@{NSFontAttributeName : [UIFont italicSystemFontOfSize:[UIFont systemFontSize]]}
                  range:range];
    cell.textLabel.attributedText = attrStr;
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
    return 40;
}

// see : override the default section header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    IERContextSectionHeader* header = [[[UINib nibWithNibName:@"IERContextSectionHeader" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    [header.mainButton setTitle:[self.ctxtGroup allKeys][section] forState:UIControlStateNormal];
    header.buttonTappedHandler = ^{
        [self openGroupContextAtIndex:section];
    };
    return header;
}


@end
