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
    IBOutlet UILabel * itemCount;
    NSIndexPath *indexPaths;
    NSMutableArray *quantity;
    NSMutableArray *price;
    int totalAmount;
    NSMutableArray *quantiyCount;
    NSDictionary * dict;
    NSMutableArray *instock;
    ProductTableViewCell *product;
    NSMutableArray *mutableDict;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    quantity =[[NSMutableArray alloc]init];
    price =[[NSMutableArray alloc]init];
    instock =[[NSMutableArray alloc]init];
    
    
    for (int i=0; i<20; i++)
    {
        [quantity addObject:@"0"];
        [price addObject:@"0"];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonText" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    dict =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    instock =[[NSMutableArray alloc]initWithArray:[[dict valueForKey:@"product_list"] valueForKey:@"in_stock"]];
    totalAmount=0;
    [quantiyCount removeAllObjects];
    [table reloadData];
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
    return [[[dict valueForKey:@"product_list"] valueForKey:@"product_name"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"ProductTableViewCell";
    
    product =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    
    itemCount.text=[NSString stringWithFormat:@"%lu items - ₹%d",(unsigned long)quantiyCount.count,totalAmount];
    
    
   
    //Remove selection style in tableview
    product.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Custom cell declaration
    product.productName.text = [[[dict valueForKey:@"product_list"] valueForKey:@"product_name"] objectAtIndex:indexPath.row];
    
    product.productPrice.text =[NSString stringWithFormat:@"₹ %@",[[[dict valueForKey:@"product_list"] valueForKey:@"product_cost"] objectAtIndex:indexPath.row]];
    
    product.productStock.text =[NSString stringWithFormat:@"%@ instock",[instock objectAtIndex:indexPath.row]];
    
    product.quantity.text=[NSString stringWithFormat:@"%@",[quantity objectAtIndex:indexPath.row]];
    product.productImage.image = [UIImage imageNamed:[[[dict valueForKey:@"product_list"] valueForKey:@"product_imageName"] objectAtIndex:indexPath.row]];
    product.plusButton.tag = indexPath.row;
    product.minusButton.tag = indexPath.row;

    [product.plusButton addTarget:self
                    action:@selector(plus:) forControlEvents:UIControlEventTouchUpInside];
    [product.minusButton addTarget:self
                           action:@selector(minus:) forControlEvents:UIControlEventTouchUpInside];
    
    indexPaths=indexPath;
    return product;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(IBAction)plus:(UIButton*)sender
{
    
    
    if (!([[instock objectAtIndex:sender.tag]intValue] == 0)) {
            NSLog(@"clicked plus");
            UIButton *button = (UIButton *)sender;
            button.selected = !button.selected;
            int p=[[quantity objectAtIndex:button.tag] intValue];
    
            int q=p+1;
    
    int m=[[instock objectAtIndex:sender.tag]intValue];
    
    m -= 1;

    [instock replaceObjectAtIndex:sender.tag withObject:[NSString stringWithFormat:@"%d",m]];
    
    
    
    
    int total = q *[[[[dict valueForKey:@"product_list"] valueForKey:@"product_cost"] objectAtIndex:button.tag] intValue];
    
    [quantity replaceObjectAtIndex:button.tag withObject:[NSString stringWithFormat:@"%d",q]];
    
    [price replaceObjectAtIndex:button.tag withObject:[NSString stringWithFormat:@"%d",total]];
    
    totalAmount = 0;
    
    for (int i=0; i< price.count; i++)
    {
        totalAmount = totalAmount + [[price objectAtIndex:i]intValue];
    }
    NSLog(@"%d",totalAmount);

    quantiyCount = [[NSMutableArray alloc]initWithArray:quantity];
    
    
    [quantiyCount removeObject:@"0"];

            button.selected = !button.selected;
        
//            [table reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            [table reloadData];
    }
    else
    {
        [product.plusButton setEnabled:NO];
    }
    
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
            int m=[[instock objectAtIndex:sender.tag]intValue];
            
            m += 1;
            
            [instock replaceObjectAtIndex:sender.tag withObject:[NSString stringWithFormat:@"%d",m]];
            
            

            if (q ==0)
            {
                
            }
        }
        else
        {
            q = 0;
            
            [quantity replaceObjectAtIndex:button.tag withObject:[NSString stringWithFormat:@"%d",q]];

            
        }
    
    int total = q *[[[[dict valueForKey:@"product_list"] valueForKey:@"product_cost"] objectAtIndex:button.tag] intValue];
    
    [quantity replaceObjectAtIndex:button.tag withObject:[NSString stringWithFormat:@"%d",q]];
    
    [price replaceObjectAtIndex:button.tag withObject:[NSString stringWithFormat:@"%d",total]];
    
    totalAmount = 0;
    
    for (int i=0; i< price.count; i++)
    {
        totalAmount = totalAmount + [[price objectAtIndex:i]intValue];
    }
    NSLog(@"%d",totalAmount);
    
    quantiyCount = [[NSMutableArray alloc]initWithArray:quantity];
    
    
    [quantiyCount removeObject:@"0"];

    
        button.selected = !button.selected;
        [table reloadData];

        
    
}

-(IBAction)CheckOutPage:(id)sender
{
    [price removeObject:@"0"];

    if (price.count == 0){
        for (int i=0; i<20; i++)
        {
            [quantity addObject:@"0"];
            [price addObject:@"0"];
        }

        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Message!!"
                                      message:@"Please add items to cart!!"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [self dismissViewControllerAnimated:YES completion:nil];
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else{
    mutableDict = [[NSMutableArray alloc]init];
    for (int i=0; i < price.count;i++ )
    {
        if (![[price objectAtIndex:i] isEqualToString:@"0"])
        {
            [mutableDict addObject:[[dict valueForKey:@"product_list"] objectAtIndex:i]];
        }
     }
    NSLog(@"checkout ----> %@",mutableDict);
    ConfirmationViewController * confirm =[self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmationViewController"];
    confirm.price=[[NSMutableArray alloc]initWithArray:price];
    
    confirm.products=[[NSMutableArray alloc]initWithArray:mutableDict];
    confirm.totalAmount=[NSString stringWithFormat:@"%d",totalAmount];

    [self presentViewController:confirm animated:YES completion: nil];
    }
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
