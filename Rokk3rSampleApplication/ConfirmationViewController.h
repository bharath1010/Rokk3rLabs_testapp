//
//  ConfirmationViewController.h
//  Rokk3rSampleApplication
//
//  Created by apple on 4/10/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmationViewController : UIViewController
{
    IBOutlet UILabel *total;
}
@property(nonatomic,retain) NSMutableArray *products;
@property(nonatomic,retain) NSMutableArray *price;

@property(nonatomic,retain) NSString *totalAmount;
@end
