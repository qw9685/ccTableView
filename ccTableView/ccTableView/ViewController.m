//
//  ViewController.m
//  ccTableView
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 cc. All rights reserved.
//

#import "ViewController.h"
#import "ccTableView.h"
#import "firstViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"默认的tableview";
    
    // Do any additional setup after loading the view.
    ccTableView* tableView = [[ccTableView alloc] initPlainTableView:nil reuseIdentifier:@"cellID" frame:self.view.bounds];
    
    tableView.cc_numberOfRows(^NSInteger(NSInteger section, UITableView * _Nonnull tableView) {
        return 5;
    }).cc_ViewForCell(^(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
    }).cc_didSelectRowAtIndexPath(^(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView) {
        
        [self.navigationController pushViewController:[firstViewController new] animated:YES];
        
    });
    
    
    [self.view addSubview:tableView];
}


@end
