//
//  ViewController.m
//  tableViewSpike
//
//  Created by u16suzu on 2013/09/15.
//  Copyright (c) 2013年 u16suzu. All rights reserved.
//

#import "ViewController.h"
#import "AnimalManager.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property UITableView *table;
@property NSMutableArray *animals;
@property NSMutableArray *birds;
@property NSMutableArray *fish;
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
    self.animals =  @[@"dog", @"cat", @"rat", @"elephant", @"tiger", @"lion"].mutableCopy;
    self.birds = @[@"crow", @"swallow", @"sparrow"].mutableCopy;
    self.fish = @[@"tuna", @"salmon"].mutableCopy;
    
    // dispatch_onceのspike
    AnimalManager* am = [AnimalManager sharedManager];
    AnimalManager* am2 = [AnimalManager sharedManager];
    // for dismiss warnning
    NSLog(@"%@", am);
    NSLog(@"%@", am2);

    
}

// Section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

// Section Header
-(NSString *)tableView: (UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * ret;
    switch (section) {
        case 0:
            ret = @"animals";
            break;
        case 1:
            ret = @"birds";
            break;
        case 2:
            ret = @"fish";            
            break;
        default:
            break;
    }
    return ret;
}

// Section Footer
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"footer";
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.animals.count;
            break;
        case 1:
            return self.birds.count;
            break;
        case 2:
            return self.fish.count;
            break;
        default:
            return 0;
            break;
    }
    return 0;
}

// Editボタンを押すと毎回実行される.
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.table setEditing:editing animated:YES];
    
    NSLog(@"animals : %@", self.animals);
    
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

// 行移動処理
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if(fromIndexPath.section == toIndexPath.section) { // 移動元と移動先は同じセクションです。
        if(self.animals && toIndexPath.row < [self.animals count]) {
            id item = [self.animals objectAtIndex:fromIndexPath.row]; // 移動対象を保持します。
            [self.animals removeObject:item]; // 配列から一度消します。
            [self.animals insertObject:item atIndex:toIndexPath.row]; // 保持しておいた対象を挿入します。
        }
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.textColor = [UIColor purpleColor];
            cell.textLabel.text = self.animals[indexPath.row];
            break;
        case 1:
            cell.textLabel.textColor = [UIColor purpleColor];
            cell.textLabel.text = self.birds[indexPath.row];
            break;
        case 2:
            cell.textLabel.textColor = [UIColor purpleColor];
            cell.textLabel.text = self.fish[indexPath.row];
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
