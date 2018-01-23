//
//  CustomMarker.m
//  GMaps
//
//  Created by Bhalchandra on 22/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import "CustomMarker.h"

@implementation CustomMarker

-(id)initWith:(CLLocationCoordinate2D )coordinate :(UIImage*)customImage  :(NSNumber *) markerID
{
    self = [super init];
    if (self)
    {
        self.coordinate = coordinate;
        self.customImage = customImage;
        self.markerID = markerID;
    }
    
    return self;
}
@end
