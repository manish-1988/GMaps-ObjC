//
//  DealerTableViewCell.h
//  GMaps
//
//  Created by Bhalchandra on 23/01/18.
//  Copyright © 2018 Bhalchandra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealerTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleTxt;
@property (strong, nonatomic) IBOutlet UILabel *subTititleTxt;
@property (strong, nonatomic) IBOutlet UIImageView *dealerImage;

@end
