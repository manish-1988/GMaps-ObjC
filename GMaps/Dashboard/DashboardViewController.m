//
//  DashboardViewController.m
//  GMaps
//
//  Created by Bhalchandra on 23/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import "AllDistributorsViewController.h"
#import "BranchViewController.h"
#import <CarbonTabSwipeNavigation.h>
#import "DashboardViewController.h"

@interface DashboardViewController () <CarbonTabSwipeNavigationDelegate>
{
  NSArray<UIViewController *> *vcArray;
  AllDistributorsViewController *allDistributorsVC;
  BranchViewController *branchVC;
}

@property (strong, nonatomic) CarbonTabSwipeNavigation *swipeView;
@property (readonly, nonatomic) NSArray *vcTitles;
@property (readonly, nonatomic) UIStoryboard *storyboardObj;

- (void)setupViewControllers;
- (void)setupSwipeView;

@end

@implementation DashboardViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = @"Nearby Dealers";
  
  [self setupViewControllers];
  [self setupSwipeView];
}

- (void)setupViewControllers
{
  branchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"branchVCID"];
  branchVC.arrayOfData = _arrayOfDataNearBy;
  
  allDistributorsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"allDistributorVCID"];
  allDistributorsVC.arrayOfData = _arrayOfDataAllBranches;
  
  vcArray = @[branchVC, allDistributorsVC];
}

#pragma mark - Swipe view

- (void)setupSwipeView
{
  _swipeView = [[CarbonTabSwipeNavigation alloc] initWithItems:self.vcTitles delegate:self];
    
  [_swipeView insertIntoRootViewController:self];
}

- (UIViewController *)carbonTabSwipeNavigation:(CarbonTabSwipeNavigation *)carbonTabSwipeNavigation viewControllerAtIndex:(NSUInteger)index
{
  return vcArray[index];
}

#pragma mark - Properties

- (NSArray *)vcTitles
{
  return @[@"Nearby Branches", @"All Branches"];
}

- (UIStoryboard *)storyboardObj
{
  return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

@end
