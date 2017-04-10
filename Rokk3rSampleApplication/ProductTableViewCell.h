//
//  ProductTableViewCell.h
//  Rokk3rSampleApplication
//
//  Created by apple on 4/10/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell

@property(nonatomic,retain) IBOutlet UILabel * productName;
@property(nonatomic,retain) IBOutlet UILabel * productPrice;
@property(nonatomic,retain) IBOutlet UILabel * productStock;
@property(nonatomic,retain) IBOutlet UILabel * quantity;
@property(nonatomic,retain) IBOutlet UIImageView * productImage;
@property(nonatomic,retain) IBOutlet UIButton * plusButton;
@property(nonatomic,retain) IBOutlet UIButton * minusButton;
@property(nonatomic,retain) IBOutlet UIButton * deleteButton;

@end
