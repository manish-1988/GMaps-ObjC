//
//  AllDistributorsViewController.m
//  GMaps
//
//  Created by Bhalchandra on 23/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import "AllDistributorsViewController.h"
#import "DealersModelObj.h"
#import "DealerTableViewCell.h"
#import "MPHelper.h"

@interface AllDistributorsViewController () <UITableViewDataSource, UITableViewDelegate>
{
  IBOutlet UITableView *dealerTableView;
  NSMutableArray<DealersModelObj *> *arrayOfModels;
}

- (void)preSetup;
- (void)preUI;
- (void)parseLogic;

@end

@implementation AllDistributorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self preSetup];
}

- (void)preSetup
{
  [self preUI];
  [self parseLogic];
}

- (void)preUI
{
  self.title = @"All Dealers";
  arrayOfModels = [[NSMutableArray alloc] init];
  
  [dealerTableView registerNib:[UINib nibWithNibName:@"DealerTableViewCell" bundle:nil] forCellReuseIdentifier:@"dealersTableViewCellID"];
  self.navigationController.navigationBar.shadowImage = nil;
}

- (void)parseLogic
{
  if (_arrayOfData.count == 0) {
    return;
  }
  
  for (NSDictionary *dataObj in _arrayOfData)
  {
    DealersModelObj *modelObj = [[DealersModelObj alloc] init];
    
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

    [arrayOfModels addObject:modelObj];
  }
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [dealerTableView reloadData];
  });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return arrayOfModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  DealerTableViewCell *cell = (DealerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dealersTableViewCellID" forIndexPath:indexPath];
  
  DealersModelObj *modelObj = arrayOfModels[indexPath.row];
  
  cell.titleTxt.text = modelObj.dealersName;
  cell.subTititleTxt.text = modelObj.dealersAddress;
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ((SCREEN_HEIGHT * 0.10 ) >= 125) {
    return 125.0f;
  }
  else {
    return SCREEN_HEIGHT * 0.15;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  DealersModelObj *modelObj = arrayOfModels[indexPath.row];
  NSLog(@"%@", modelObj);
}

@end
