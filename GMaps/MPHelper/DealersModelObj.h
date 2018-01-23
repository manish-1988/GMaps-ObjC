//
//  DealersModelObj.h
//  GMaps
//
//  Created by Bhalchandra on 22/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomMarker.h"

@interface DealersModelObj : NSObject

@property(nonatomic, strong) NSNumber *dealersID;
@property(nonatomic, strong) NSString *dealersName;
@property(nonatomic, strong) NSNumber *dealersLat;
@property(nonatomic, strong) NSNumber *dealersLong;
@property(nonatomic, strong) NSString *dealersAddress;
@property(assign) BOOL isMainHeadquaters;
@property(nonatomic, strong) CustomMarker *mainMarker;

-(id)initWith:(NSNumber *)dealersID :(NSString*)dealersName  :(NSNumber *) dealersLat :(NSNumber *) dealersLong :(NSString *) dealersAddress :(BOOL) isMainHeadquaters :(CustomMarker *)mainMarker;

@end
