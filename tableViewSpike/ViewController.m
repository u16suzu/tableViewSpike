//
//  ViewController.m
//  tableViewSpike
//
//  Created by u16suzu on 2013/09/15.
//  Copyright (c) 2013年 u16suzu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property UITableView *table;
@property NSMutableArray *animals;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Navigation
    self.navigationItem.title = @"Table Test";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    // Status bar, Navigation barの高さを抜いたCGRect を生成する.
    CGFloat barHeight = self.navigationController.navigationBar.frame.size.height;    
    CGRect tableFrame = CGRectMake(0, 0,
                                   UIScreen.mainScreen.bounds.size.width,
                                   UIScreen.mainScreen.applicationFrame.size.height - barHeight);
    
    // Table
    self.table = [[UITableView alloc]initWithFrame:tableFrame];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    // Data for display
    self.animals =  @[@"dog", @"cat", @"rat"].mutableCopy;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return self.animals.count;
}

// Editボタンを押すと毎回実行される.
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.table setEditing:editing animated:YES];
    
    if (editing) { // 現在編集モードです。
        NSLog(@"%@", @"edit mode");

        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                      target:self
                                      action:@selector(addRow:)] ;
        [self.navigationItem setLeftBarButtonItem:addButton animated:YES]; // 追加ボタンを表示します。
    } else { // 現在通常モードです。
        NSLog(@"%@", @"usual mode");

        [self.navigationItem setLeftBarButtonItem:nil animated:YES]; // 追加ボタンを非表示にします。
    }
}

// 行追加処理
-(void)addRow:(id)sender{
    int rand = random() % self.animals.count;
    [self.animals addObject:self.animals[rand]];
    [self.table reloadData];
}

// 行削除処理
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.animals removeObjectAtIndex:indexPath.row]; // 削除ボタンが押された行のデータを配列から削除します。
        [self.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // ここは空のままでOKです。
    }
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    cell.textLabel.text = self.animals[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
