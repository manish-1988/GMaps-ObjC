//
//  MPHelper.m
//  GMaps
//
//  Created by Bhalchandra on 19/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import "MPHelper.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NSString *const kMapKeyGoogle = @"AIzaSyC_nEKw2adCqYbnHSxnmStNX1cwzRrvc1Y";

@implementation MPHelper

#pragma mark - Init

+ (MPHelper *)sharedMySingleton
{
  static MPHelper *shared = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shared = [[MPHelper alloc] init];
  });
  return shared;
}

#pragma mark - Methods

+ (BOOL)isDeviceSimulator
{
#if TARGET_IPHONE_SIMULATOR
  return YES;
#endif
  return NO;
}

+ (void)makeMyNavigationControllerOfColor:(UIColor *)barTintColor tintColor: (UIColor *)tintColor titleColor:(UIColor *)titleColor
{
  [UINavigationBar appearance].barTintColor = barTintColor;
  [UINavigationBar appearance].tintColor = tintColor;
  
  [UINavigationBar appearance].translucent = NO;
  [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: titleColor};
}

+ (NSArray *)parseJSONFromFile
{
  NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
  if (path.length == 0) {
    return nil;
  }
  
  NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
  if (data.length == 0) {
    return nil;
  }
  
  NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSDictionary *dataDic = [jsonDic valueForKey:@"Data"];
    NSArray *dealersArray = [dataDic valueForKey:@"Dealers"];
    
    return dealersArray;
#warning need parsing code here
  return nil;
}

+ (void)zoomCameraWithBounds:(GMSCoordinateBounds *)bounds pad:(CGFloat)padding mapView:(GMSMapView *)mapView
{
  GMSCameraPosition *camera = [mapView cameraForBounds:bounds insets:UIEdgeInsetsZero];
  mapView.camera = camera;
  
  GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate fitBounds:bounds withPadding:padding];
  
  [CATransaction begin];
  [CATransaction setValue:@1 forKey:kCATransactionAnimationDuration];
  [mapView animateWithCameraUpdate:cameraUpdate];
  [CATransaction commit];
}

+ (void)underlineLabel:(UILabel *)label
{
  if (label.text.length == 0) {
    return;
  }
  
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
  NSRange range = NSMakeRange(0, attributedString.length);
  
  [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
  [attributedString addAttribute:NSUnderlineColorAttributeName value:[UIColor redColor] range:range];
  
  label.attributedText = attributedString;
}

+ (void)setNavTitle:(NSString *)title onController:(UIViewController *)vc
{
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, vc.view.bounds.size.width - 100, 44.0f)];
  titleLabel.adjustsFontSizeToFitWidth = YES;
  titleLabel.text = title;
  titleLabel.font = [UIFont fontWithName:@"Times New Roman" size:19.0f];
  titleLabel.textColor = [UIColor blackColor];
  titleLabel.minimumScaleFactor = 0.5;
  vc.navigationItem.titleView = titleLabel;
}

@end
