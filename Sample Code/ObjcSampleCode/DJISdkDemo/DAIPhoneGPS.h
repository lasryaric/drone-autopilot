//
//  DAIPhoneGPS.h
//  DJISdkDemo
//
//  Created by Aric Lasry on 3/2/17.
//  Copyright © 2017 DJI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^DAIPhoneGPSNewLocation)(CLLocation *location, NSError *error);


@protocol DAIPhoneGPSDelegate <NSObject>

-(void)gotLocation:(CLLocation *)location;

@end

@interface DAIPhoneGPS : NSObject <CLLocationManagerDelegate>

-(void)startMonitoring:(DAIPhoneGPSNewLocation)block;
-(void)stop;

+ (double)bearingFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation;
@end
