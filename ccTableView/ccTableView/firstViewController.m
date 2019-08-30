//
//  firstViewController.m
//  ccTableView
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 cc. All rights reserved.
//

#import "firstViewController.h"
#import "ccTableView.h"
#import "firstTableViewCell.h"

@interface firstViewController ()

@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义cell";
    
    // Do any additional setup after loading the view.
    ccTableView* tableView = [[ccTableView alloc] initPlainTableView:[firstTableViewCell class] reuseIdentifier:@"firstTableViewCellID" frame:self.view.bounds];
    
    tableView.cc_commitEditingStylePath(^(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView, UITableViewCellEditingStyle style) {
        
        NSLog(@"=删除了%ld",(long)indexPath.row);
        
    }).cc_canEditRowAtIndexPath(^BOOL(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView) {
        return YES;
    }).cc_numberOfRows(^NSInteger(NSInteger section, UITableView * _Nonnull tableView) {
        return 2;
    }).cc_numberOfSections(^NSInteger(UITableView * _Nonnull tableView) {
        return 2;
    }).cc_ViewForFooter(^UIView * _Nonnull(NSInteger section, UITableView * _Nonnull tableView) {
      
        UIView* footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor redColor];
        return footerView;
    }).cc_ViewForHeader(^UIView * _Nonnull(NSInteger section, UITableView * _Nonnull tableView) {
        
        UIView* headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor yellowColor];
        return headerView;
    }).cc_heightForFooter(^NSInteger(NSInteger section, UITableView * _Nonnull tableView) {
        
        return 40;
    }).cc_heightForHeader(^NSInteger(NSInteger section, UITableView * _Nonnull tableView) {
        
        return 20;
    }).cc_heightForCell(^NSInteger(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView) {
        
        return 100;
    }).cc_ViewForCell(^(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell) {
                
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
    }).cc_didSelectRowAtIndexPath(^(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView) {
        NSLog(@"点击了%ld",(long)indexPath.row);
    });
    
    [self.view addSubview:tableView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
