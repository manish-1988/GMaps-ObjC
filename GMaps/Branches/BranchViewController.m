//
//  BranchViewController.m
//  GMaps
//
//  Created by Bhalchandra on 22/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import "BranchViewController.h"
#import "CustomMarker.h"
#import "DealersModelObj.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MPHelper.h"

@interface BranchViewController () <GMSMapViewDelegate>
{
  NSNumber *selectedIdx;
  GMSMapView *googleMapObj;
  GMSCoordinateBounds *boundsMarkers;
  NSMutableArray<DealersModelObj *> *arrayOfModels;
}

// ui components
@property (weak, nonatomic) IBOutlet UIView *baseViewGoogleMaps;
@property (weak, nonatomic) IBOutlet UILabel *getDirectionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapSettingSegmentControl;

// buttons to hide
@property (weak, nonatomic) IBOutlet UIButton *enterButton;
@property (weak, nonatomic) IBOutlet UILabel  *bottomTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *getDirectionImageVIew;

@end

@implementation BranchViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  [self preSetup];
}

- (void)preSetup
{
  selectedIdx = 0;
  arrayOfModels = [[NSMutableArray alloc] init];
  [self preUI];
}

- (void)preUI
{
  [self preSetupSegmentControl];
  [MPHelper underlineLabel:_getDirectionLabel];
  [self hideAllBottomComponentOnAppLaunch:YES];
  [self googleMapSetup];
  self.title = @"Dealers";
}

- (void)preSetupSegmentControl
{
  // default background color
  _mapSettingSegmentControl.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.95];
  
  // selected background color
  _mapSettingSegmentControl.tintColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.95];
  
  // selected text color
  UIFont *font = [UIFont boldSystemFontOfSize:12.0];
  NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName];
  [_mapSettingSegmentControl setTitleTextAttributes:attributes
                                           forState:UIControlStateNormal];
  [_mapSettingSegmentControl setTitleTextAttributes:attributes
                                           forState:UIControlStateSelected];
  
  // default title text color
  [_mapSettingSegmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateSelected];
  
  [_mapSettingSegmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:156.0f/255 green:156.0f/255 blue:156.0f/255 alpha:1.0f]} forState:UIControlStateNormal];
}

- (void)hideAllBottomComponentOnAppLaunch:(BOOL) doHide
{
  [_bottomTitleLabel setHidden:doHide];
  [_bottomAddressLabel setHidden:doHide];
  [_getDirectionImageVIew setHidden:doHide];
  [_getDirectionLabel setHidden:doHide];
  [_enterButton setHidden:doHide];
}

- (void)updateBottomViewbottomTitleLabel
{
  for (DealersModelObj *modelObject in  arrayOfModels)
  {
    if (modelObject.dealersID.longValue == selectedIdx.longValue)
    {
      [_bottomTitleLabel setText:modelObject.dealersName];
      [_bottomAddressLabel setText:modelObject.dealersAddress];
    }
  }
}

#pragma mark - Map

- (void)googleMapSetup
{
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:51.414561 longitude:25.277652 zoom:14.0];
  
  googleMapObj = [GMSMapView mapWithFrame:_baseViewGoogleMaps.bounds camera:camera];
  
  googleMapObj.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                   UIViewAutoresizingFlexibleLeftMargin |
                                   UIViewAutoresizingFlexibleRightMargin);
  [_baseViewGoogleMaps addSubview:googleMapObj];
  googleMapObj.delegate = self;
  
  if (_arrayOfData.count == 0) {
    return;
  }
  
  for (NSDictionary *dataObj in _arrayOfData)
  {
    DealersModelObj *modelObj = [[DealersModelObj alloc] init];
    
//    if ([dataObj valueForKey:@"DealerID"] != nil)
//    {
//      modelObj.dealersID = (int)[dataObj valueForKey:@"DealerID"];
//    }
    
    if ([dataObj valueForKey:@"DealerID"] != nil)
    {
        modelObj.dealersID = [NSNumber numberWithDouble:[dataObj[@"DealerID"] longValue]];
    }
    
    if ([dataObj valueForKey:@"DealerName"] != nil)
    {
      if ([[dataObj valueForKey:@"DealerName"] isKindOfClass:[NSString class]])
      {
        modelObj.dealersName = (NSString *)[dataObj valueForKey:@"DealerName"];
      }
    }

      if ([dataObj valueForKey:@"Latitude"] != nil)
    {
        modelObj.dealersLat = [NSNumber numberWithDouble:[dataObj[@"Latitude"] doubleValue]];
    }
    
    if ([dataObj valueForKey:@"Longtitude"] != nil)
    {
      modelObj.dealersLong = @([dataObj[@"Longtitude"] doubleValue]);
    }
    
    if ([dataObj valueForKey:@"Address"] != nil)
    {
      if ([[dataObj valueForKey:@"Address"] isKindOfClass:[NSString class]])
      {
        modelObj.dealersAddress = (NSString *)[dataObj valueForKey:@"Address"];
      }
    }
    
    if ([dataObj valueForKey:@"isHeadquarters"] != nil)
    {
      modelObj.isMainHeadquaters = @([dataObj[@"isHeadquarters"] boolValue]);
    }
      CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(modelObj.dealersLat.doubleValue, modelObj.dealersLong.doubleValue);
      
      [self createMarkerAtLocation:coordinates model:modelObj];
    
      [arrayOfModels addObject:modelObj];
  }
  
  [MPHelper zoomCameraWithBounds:boundsMarkers pad:10.0f mapView:googleMapObj];
}

- (void)createMarkerAtLocation:(CLLocationCoordinate2D)location model:(DealersModelObj *)model
{
  CustomMarker *marker = [[CustomMarker alloc] init];
  marker.position = location;
  marker.title = model.dealersName;
  marker.snippet = model.dealersAddress;
  
  if (googleMapObj != nil) {
    marker.map = googleMapObj;
  }
  
  marker.markerID = model.dealersID;
  model.mainMarker = marker;
    if (boundsMarkers == nil)
    {
        boundsMarkers = [[GMSCoordinateBounds alloc] init];
    }
    boundsMarkers = [boundsMarkers includingCoordinate:marker.position];
    
}

#pragma mark - IBAction

- (IBAction)mapSettingsChanged:(UISegmentedControl *)sender
{
  switch (sender.selectedSegmentIndex)
  {
    case 0:
      googleMapObj.mapType = kGMSTypeNormal;
          break;
    case 1:
      googleMapObj.mapType = kGMSTypeSatellite;
          break;
    default:
      googleMapObj.mapType = kGMSTypeNormal;
  }
}

- (IBAction)fullScreenBtnPressed:(UIButton *)sender
{
  // not in swift
}

- (IBAction)detailedNavBtnPressed:(UIButton *)sender
{
  // not in swift
}

- (IBAction)bottomButtonPressed:(UIButton *)sender
{
  // not in swift
}

#pragma mark - Google Map Delagate

/**
 * Called after a marker has been tapped.
 *
 * @param mapView The map view that was tapped.
 * @param marker The marker that was tapped.
 * @return YES if this delegate handled the tap event, which prevents the map from performing its
 * default selection behavior, and NO if the map should continue with its default selection
 * behavior.
 */
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
  [self hideAllBottomComponentOnAppLaunch:NO];
  CustomMarker *objMarker = (CustomMarker *)marker;
  selectedIdx =  objMarker.markerID;
  [self updateBottomViewbottomTitleLabel];
  return YES;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
  // not in swift
}

- (void)mapView:(GMSMapView *)mapView didCloseInfoWindowOfMarker:(GMSMarker *)marker
{
  // not in swift
}

@end
