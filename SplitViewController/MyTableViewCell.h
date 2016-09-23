//
//  MyTableViewCell.h
//  SplitViewController
//
//  Created by vignesh on 9/14/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *genderLbl;
@property (strong, nonatomic) IBOutlet UILabel *ageLbl;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end
