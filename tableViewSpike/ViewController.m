//
//  ViewController.m
//  tableViewSpike
//
//  Created by u16suzu on 2013/09/15.
//  Copyright (c) 2013年 u16suzu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.table = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
}

-(void)layoutSubviews{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_table deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.textColor = [UIColor purpleColor];
    cell.textLabel.text = [NSString stringWithFormat:@"cell %d", indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
