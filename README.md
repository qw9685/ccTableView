# ccTableView
tableView组件化

什么是链式编程？ 最简单的理解就是通过点语法，调用返回参数为相同对象的方法，通过这种方式，不断的点出方法拼接，最终得出结果。

Masonry，RAC等框架就是通过链式编程实现的。

tableView组件化思考：平常使用tavleView需要实现他的代理及数据源，方法扩散，不方便追踪代码和修改。所以我封装了一个tableView组建，使用链式编程的方式，能够快速实现一个tableView，代理及数据源都是通过block返回代码块，这样一个tableView模块相对高内聚，低耦合。

github链接：https://github.com/qw9685/ccTableView.git

![Untitled.gif](https://upload-images.jianshu.io/upload_images/1822713-34a17ed7f49c26f5.gif?imageMogr2/auto-orient/strip)

最简单的实现：
```
    ccTableView* tableView = [[ccTableView alloc] initPlainTableView:nil reuseIdentifier:@"cellID" frame:self.view.bounds];
    
    tableView.cc_numberOfRows(^NSInteger(NSInteger section, UITableView * _Nonnull tableView) {
        return 5;
    }).cc_ViewForCell(^(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
    }).cc_didSelectRowAtIndexPath(^(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView) {
        
        [self.navigationController pushViewController:[firstViewController new] animated:YES];
        
    });
```
自定义cell，header，footer，左滑删除。

```
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
```

