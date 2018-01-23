//
//  DealerTableViewCell.m
//  GMaps
//
//  Created by Bhalchandra on 23/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import "DealerTableViewCell.h"
#import "MPHelper.h"

@interface DealerTableViewCell ()

- (IBAction)callButtonPressed:(id)sender;
- (IBAction)DirectionButtonPressed:(id)sender;

@end

@implementation DealerTableViewCell

- (void)awakeFromNib
{
  [super awakeFromNib];
  self.backgroundColor      = TABLE_CELL_COLOR;
  _titleTxt.textColor       = TEXT_RED_COLOR;
  _subTititleTxt.textColor  = GRAY_RED_COLOR;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  self.backgroundColor = TABLE_SELECTION_COLOR;
}

#pragma mark - IBActions

- (IBAction)callButtonPressed:(id)sender
{
  // not in swift
}

- (IBAction)DirectionButtonPressed:(id)sender
{
  // not in swift
}

@end
