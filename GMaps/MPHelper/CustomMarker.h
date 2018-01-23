//
//  CustomMarker.h
//  GMaps
//
//  Created by Bhalchandra on 22/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface CustomMarker : GMSMarker

@property(assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) UIImage *customImage;
@property(nonatomic, strong) NSNumber *markerID;

-(id)initWith:(CLLocationCoordinate2D )coordinate :(UIImage*)customImage  :(NSNumber*) markerID;

@end
