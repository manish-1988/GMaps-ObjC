//
//  ViewController.m
//  GMaps
//
//  Created by Bhalchandra on 19/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import "BranchViewController.h"
#import "DashboardViewController.h"
#import "MPHelper.h"
#import "ViewController.h"

@interface ViewController ()

@property (readonly, nonatomic) UIStoryboard *storyboardObj;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  [MPHelper makeMyNavigationControllerOfColor:[UIColor blackColor] tintColor:[UIColor whiteColor] titleColor:[UIColor whiteColor]];
}

#pragma mark - IBActions

- (IBAction)dashboardButtonPressed:(UIButton *)sender
{
  NSArray *json = [MPHelper parseJSONFromFile];
  [self showAllDistributorsPage:json allBranches:json];
}

- (void)showAllDistributorsPage:(NSArray *)arrayJSONNearBy allBranches:(NSArray *)arrayJSONAllBranches
{
  DashboardViewController *dashboard = [self.storyboard instantiateViewControllerWithIdentifier:@"dashboardVCID"];
  
  dashboard.arrayOfDataNearBy = arrayJSONNearBy;
  dashboard.arrayOfDataAllBranches = arrayJSONAllBranches;
  
  [self.navigationController pushViewController:dashboard animated:YES];
}

- (IBAction)branchButtonPressed:(UIButton *)sender
{
  [self showBranchPage:[MPHelper parseJSONFromFile]];
}

- (void)showBranchPage:(NSArray *)arrayJSONNearBy
{
  BranchViewController *branchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"branchVCID"];
  
  branchVC.arrayOfData = arrayJSONNearBy;
  [self.navigationController pushViewController:branchVC animated:YES];
}

#pragma mark - Properties

- (UIStoryboard *)storyboardObj
{
  return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

@end
