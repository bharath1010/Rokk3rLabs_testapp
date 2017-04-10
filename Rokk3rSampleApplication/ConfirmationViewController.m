//
//  ConfirmationViewController.m
//  Rokk3rSampleApplication
//
//  Created by apple on 4/10/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "ProductTableViewCell.h"

@interface ConfirmationViewController ()
{
    IBOutlet UITableView *table;
    NSIndexPath *indexpath;
    
}

@end

@implementation ConfirmationViewController
@synthesize products,totalAmount,price;

- (void)viewDidLoad {
    [super viewDidLoad];
    total.text=[NSString stringWithFormat:@"₹ %@",totalAmount];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView-Sample

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in section.
    return [[products valueForKey:@"product_name"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"ProductTableViewCell";
    ProductTableViewCell * product =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    
    //Remove selection style in tableview
    product.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Custom cell declaration
    product.productName.text = [[products valueForKey:@"product_name"] objectAtIndex:indexPath.row];
    
    product.productPrice.text =[NSString stringWithFormat:@"₹ %@",[price  objectAtIndex:indexPath.row]];
    
    
    
    product.productImage.image = [UIImage imageNamed:[[products valueForKey:@"product_imageName"]objectAtIndex:indexPath.row]];
    product.deleteButton.tag=indexPath.row;

    [product.deleteButton addTarget:self
                          action:@selector(deleteButt:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return product;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)deleteButt:(UIButton *)sender
{
  
    [products removeObjectAtIndex:sender.tag];
    [price removeObjectAtIndex:sender.tag];
    int m=0;
    for (int i=0; i<price.count; i++) {
         m+=[[price objectAtIndex:i] intValue];
    }
    total.text=[NSString stringWithFormat:@"₹ %d",m];
    [table reloadData];
    if (products.count == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   }
-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
-(IBAction)confirm:(id)sender
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Success!!"
                                  message:@"Thank you for shopping with us !!"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self dismissViewControllerAnimated:YES completion:nil];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
