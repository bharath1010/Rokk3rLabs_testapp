//
//  ViewController.m
//  Rokk3rSampleApplication
//
//  Created by apple on 4/10/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import "ViewController.h"
#import "ProductTableViewCell.h"
#import "ConfirmationViewController.h"

@interface ViewController ()
{
    IBOutlet UITableView *table;
    NSIndexPath *indexPaths;
    NSMutableArray *quantity;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i=0; i<=20; i++)
    {
        [quantity addObject:@"0"];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonText" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary * dict =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSLog(@"dict ---> %@",dict);
    
    NSLog(@"dicxt ----> %@",[[dict valueForKey:@"product_list"] valueForKey:@"in_stock"]);

    
    
    // Do any additional setup after loading the view, typically from a nib.
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
    product.quantity.text=[NSString stringWithFormat:@"%@",[quantity objectAtIndex:indexPath.row]];
    product.productImage.image = [UIImage imageNamed:@"1.png"];
    product.plusButton.tag = indexPath.row;
    product.minusButton.tag = indexPath.row;

    [product.plusButton addTarget:self
                    action:@selector(plus:) forControlEvents:UIControlEventTouchUpInside];
    [product.minusButton addTarget:self
                           action:@selector(buyButt:) forControlEvents:UIControlEventTouchUpInside];
    
    indexPaths=indexPath;
    return product;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(IBAction)plus:(UIButton*)sender
{
    
            
            NSLog(@"clicked plus");
            UIButton *button = (UIButton *)sender;
            button.selected = !button.selected;
            int p=[[quantity objectAtIndex:button.tag] intValue];
    
            int q=p+1;
    
    [quantity replaceObjectAtIndex:button.tag withObject:[NSString stringWithFormat:@"%d",q]];
    
            button.selected = !button.selected;
        
//            [table reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            [table reloadData];
    
}

-(IBAction)minus:(UIButton*)sender
{
        NSLog(@"clicked minus");
        
        UIButton *button = (UIButton *)sender;
        button.selected = !button.selected;
        
        int p= [[quantity objectAtIndex:button.tag] intValue];
        int q;
        if (p != 0)
        {
            q=p-1;
            
            [quantity replaceObjectAtIndex:button.tag withObject:[NSString stringWithFormat:@"%d",q]];

            if (q ==0)
            {
                
            }
        }
        else
        {
            q = 0;
            
            [quantity replaceObjectAtIndex:button.tag withObject:[NSString stringWithFormat:@"%d",q]];

            
        }
    
        button.selected = !button.selected;
        [table reloadData];

        
    
}

-(IBAction)CheckOutPage:(id)sender
{
    ConfirmationViewController * confirm =[self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmationViewController"];
    [self presentViewController:confirm animated:YES completion: nil];
}
-(IBAction)addProduct:(id)sender
{
}
-(IBAction)removeProduct:(id)sender
{
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
