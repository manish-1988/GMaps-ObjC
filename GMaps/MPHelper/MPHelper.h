//
//  MPHelper.h
//  GMaps
//
//  Created by Bhalchandra on 19/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <UIKit/UIKit.h>

#define BASE_NAV_RED_COLOR [UIColor colorWithRed:121.0 / 255.0 green:1.0 / 255.0  blue:40.0 / 255.0 alpha:1.0]
#define TEXT_RED_COLOR [UIColor colorWithRed:108.0 / 255.0 green:8.0 / 255.0  blue:49.0 / 255.0 alpha:1.0]
#define GRAY_RED_COLOR [UIColor colorWithRed:138.0 / 255.0 green:138.0 / 255.0  blue:138.0 / 255.0 alpha:1.0]
#define TABLE_SELECTION_COLOR [UIColor colorWithRed:244.0 / 255.0 green:244.0 / 255.0  blue:244.0 / 255.0 alpha:1.0]
#define TABLE_CELL_COLOR [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0  blue:255.0 / 255.0 alpha:1.0]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MPHelper : NSObject

+ (BOOL)isDeviceSimulator;

+ (void)makeMyNavigationControllerOfColor:(UIColor *)barTintColor tintColor: (UIColor *)tintColor titleColor:(UIColor *)titleColor;

+ (NSArray *)parseJSONFromFile;

+ (void)zoomCameraWithBounds:(GMSCoordinateBounds *)bounds pad:(CGFloat)padding mapView:(GMSMapView *)mapView;

+ (void)underlineLabel:(UILabel *)label;

+ (void)setNavTitle:(NSString *)title onController:(UIViewController *)vc;

@end

extern NSString *const kMapKeyGoogle;
