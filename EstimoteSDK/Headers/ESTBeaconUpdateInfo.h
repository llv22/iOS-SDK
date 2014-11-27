//
//  ESBeaconUpdateInfo.h
//  EstimoteSDK
//
//  Version: 2.2.1
//  Created by Marcin Klimek on 06/03/14.
//  Copyright (c) 2014 Estimote. All rights reserved.

#import <Foundation/Foundation.h>
#import "ESTBeacon.h"
#import "ESTBeaconUpdateConfig.h"

typedef NS_ENUM(NSInteger, ESBeaconUpdateInfoStatus)
{
    ESBeaconUpdateInfoStatusIdle,
    ESBeaconUpdateInfoStatusReadyToUpdate,
    ESBeaconUpdateInfoStatusUpdating,
    ESBeaconUpdateInfoStatusUpdateSuccess,
    ESBeaconUpdateInfoStatusUpdateFailed
};

/**
 * The ESBeaconUpdateInfoDelegate protocol defines the delegate method used to confirm when ESBeaconUpdateInfo is ready to be performed in the operation queue (related bluetooth peripheral was found).
 */

@protocol ESBeaconUpdateInfoDelegate <NSObject>

- (void)beaconUpdateInfoInitialized:(id)beaconUpdateInfo;

@end

/**
 * The ESBeaconUpdateInfo class represents all required data for single Estimote beacon bulk update operation. It should be intialized by particular ESTBeacon that should be updated and ESBeaconUpdateConfig config object that describes how update is going to be performed.
 */

@interface ESTBeaconUpdateInfo : NSObject <NSCoding>

/**
 *  Beacon about which this info is for.
 */
@property (nonatomic, strong) ESTBeacon *beacon;

/**
 *  Proximity UUID of the beacon device that should be updated.
 */
@property (nonatomic, strong) NSUUID *UUID;

/**
 *  Major of the beacon device that should be updated.
 */
@property (nonatomic, strong) NSNumber *major;

/**
 *  Minor of the beacon device that should be updated.
 */
@property (nonatomic, strong) NSNumber *minor;

/**
 *  Mac address of the beacon device.
 */
@property (nonatomic, strong) NSString *macAddress;

/**
 *  Bluetooth Peripheral object related to the beacon.
 */
@property (nonatomic, strong) NSString *peripheralID;

/**
 *  Configuration based on which update should be performed.
 */
@property (nonatomic, strong) ESTBeaconUpdateConfig *config;

/**
 *  Delegate object described with ESBeaconUpdateInfoDelegate protocol.
 */
@property (nonatomic, assign) id<ESBeaconUpdateInfoDelegate> delegate;

/**
 *  Current status of beacon update.
 */
@property (nonatomic, assign) ESBeaconUpdateInfoStatus status;

/**
 *  Error object if beacon failed to update.
 */
@property (nonatomic, strong) NSError *error;


/**
 *  Initialize object with beacon that is going to be updated and proper
 *  config file containing description how update should be performed.
 *
 *  @param beacon beacon object
 *  @param config config description for update
 *
 *  @return initialized instance of this class
 */
- (instancetype)initWithBeacon:(ESTBeacon *)beacon
                        config:(ESTBeaconUpdateConfig *)config;

/**
 *  Scans for peripheral related with the beacon.
 */
- (void)findPeripheral;

/**
 *  Allows to update config for the related beacon. Overrides previous
 *  Power and Adv interval values.
 *
 *  @param config new config object
 */
- (void)updateWithConfig:(ESTBeaconUpdateConfig *)config;

/**
 *  Custom description method of Beacon update information.
 *
 *  @return description string
 */
- (NSString *)description;

@end
