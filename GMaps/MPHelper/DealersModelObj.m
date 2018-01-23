//
//  DealersModelObj.m
//  GMaps
//
//  Created by Bhalchandra on 22/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import "DealersModelObj.h"

@implementation DealersModelObj


-(id)initWith:(NSNumber *)dealersID :(NSString*)dealersName  :(NSNumber *) dealersLat :(NSNumber *) dealersLong :(NSString *) dealersAddress :(BOOL) isMainHeadquaters :(CustomMarker *)mainMarker
{
    self = [super init];
    if (self)
    {
        self.dealersID = dealersID;
        self.dealersName = dealersName;
        self.dealersLat =  dealersLat;
        self.dealersLong = dealersID;
        self.dealersAddress = dealersAddress;
        self.mainMarker = mainMarker;
    }
    
    return self;
}

@end
