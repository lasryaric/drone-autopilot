//
//  DAIPhoneGPS.m
//  DJISdkDemo
//
//  Created by Aric Lasry on 3/2/17.
//  Copyright © 2017 DJI. All rights reserved.
//

#import "DAIPhoneGPS.h"
#import <CoreLocation/CoreLocation.h>

@interface DAIPhoneGPS()
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, copy) DAIPhoneGPSNewLocation gotLocationBlock;

@end

@implementation DAIPhoneGPS



-(void)startMonitoring:(DAIPhoneGPSNewLocation)block {
    // Create the location manager if this object does not
        // already have one.
        if (nil == self.locationManager)
            self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 1; // meters
    
    [self.locationManager startUpdatingLocation];
    self.gotLocationBlock = block;
}

-(void)stop {
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

double DegreesToRadians(double degrees) {return degrees * M_PI / 180.0;};
double RadiansToDegrees(double radians) {return radians * 180.0/M_PI;};

+ (double)bearingFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation
{
    
    double lat1 = DegreesToRadians(fromLocation.latitude);
    double lon1 = DegreesToRadians(fromLocation.longitude);
    
    double lat2 = DegreesToRadians(toLocation.latitude);
    double lon2 = DegreesToRadians(toLocation.longitude);
    
    double dLon = lon2 - lon1;
    
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    double radiansBearing = atan2(y, x);
    
    double degreesBearing = RadiansToDegrees(radiansBearing);
    
    if (degreesBearing >= 0) {
        return degreesBearing;
    } else {
        return degreesBearing + 360.0;
    }
}

#pragma locationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    self.gotLocationBlock(newLocation, Nil);
}
#pragma -

@end
