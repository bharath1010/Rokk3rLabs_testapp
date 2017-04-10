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

@end

@implementation ConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"ProductTableViewCell";
    ProductTableViewCell * product =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    
    //Remove selection style in tableview
    product.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Custom cell declaration
    product.productName.text =@"Apple";
    product.productPrice.text =@"Rs.15";
    product.productStock.text =@"10Kg";
    product.productImage.image = [UIImage imageNamed:@"1.png"];
    [product.deleteButton addTarget:self
                          action:@selector(deleteButt:) forControlEvents:UIControlEventTouchUpInside];
    return product;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)deleteButt:(UIButton *)sender
{
    
}
-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
