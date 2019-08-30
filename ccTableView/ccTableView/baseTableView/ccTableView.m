//
//  baseTableView.m
//  xmjr-restructure
//
//  Created by foxdingding on 2018/7/19.
//  Copyright © 2018年 QuickstartApp. All rights reserved.
//

#import "ccTableView.h"


@interface ccTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) Class cellClass;

@property (nonatomic,strong) NSString* reuseIdentifier;

/**
 * 头部视图
 */
@property(nonatomic,copy) cc_heightForHeader heightForHeader;
@property(nonatomic,copy) cc_ViewForHeader viewForHeader;

/**
 * 尾部视图
 */
@property(nonatomic,copy) cc_heightForFooter heightForFooter;
@property(nonatomic,copy) cc_ViewForFooter viewForFooter;

/**
 * cell视图
 */
@property(nonatomic,copy) cc_numberOfSections numberOfSections;
@property(nonatomic,copy) cc_numberOfRows numberOfRows;
@property(nonatomic,copy) cc_heightForCell heightForCell;
@property(nonatomic,copy) cc_ViewForCell viewForCell;

/**
 * 左滑编辑样式
 */
@property(nonatomic,copy) cc_canEditRowAtIndexPath canEditRowAtIndexPath;

@property(nonatomic,copy) cc_editingStyleForRowAtIndexPath editingStyleForRowAtIndexPath;

@property(nonatomic,copy) cc_commitEditingStylePath commitEditingStylePath;

@property(nonatomic,copy) cc_titleEditString titleEditString;

/**
 * 点击
 */

@property (nonatomic,copy) cc_didSelectRowAtIndexPath didSelectRowAtIndexPath;

@end

@implementation ccTableView

//创建Group样式
- (instancetype)initGroupTableView:(nullable Class)cellClass reuseIdentifier:(nonnull NSString*)reuseIdentifier frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.reuseIdentifier = reuseIdentifier;
        self.cellClass = cellClass;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
        [self defaultConfig];
    }
    return self;
}

//创建Plain样式
- (instancetype)initPlainTableView:(nullable Class)cellClass reuseIdentifier:(nonnull NSString*)reuseIdentifier frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.reuseIdentifier = reuseIdentifier;
        self.cellClass = cellClass;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        [self defaultConfig];
    }
    return self;
}

- (void)defaultConfig{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    
    [self addSubview:_tableView];
}

-(void)layoutSubviews{
    self.tableView.frame = self.bounds;
}

-(void)cc_reload{
    [self.tableView reloadData];
}

#pragma mark ------------------------- UITableViewDataSource -------------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.heightForCell) {
        return self.heightForCell(indexPath,tableView);
    }
    return UITableViewAutomaticDimension;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.numberOfSections?self.numberOfSections(tableView) : 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.numberOfRows?self.numberOfRows(section,tableView) : 0;
}


#pragma mark ------------------------- UITableViewDelegate -------------------------
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return self.heightForHeader?self.heightForHeader(section,tableView):0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return self.heightForFooter?self.heightForFooter(section,tableView):0;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return self.viewForFooter?self.viewForFooter(section,tableView):[UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return self.viewForHeader?self.viewForHeader(section,tableView):[UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.didSelectRowAtIndexPath) {
        self.didSelectRowAtIndexPath(indexPath,tableView);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier];
    
    if (!cell) {
        
        if (self.cellClass) {
            cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier];
        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier];
        }
    }
    
    if (self.viewForCell) {
        self.viewForCell(indexPath, tableView,cell);
    }
    
    return cell;
}

#pragma mark ------------------------- 左滑样式 默认删除 -------------------------

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.canEditRowAtIndexPath?self.canEditRowAtIndexPath(indexPath,tableView):NO;
}
// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.editingStyleForRowAtIndexPath?self.editingStyleForRowAtIndexPath(indexPath,tableView):UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.commitEditingStylePath) {
        self.commitEditingStylePath(indexPath,tableView,editingStyle);
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.titleEditString?self.titleEditString(indexPath,tableView):@"删除";
}

#pragma mark ------------------------- set&get -------------------------

- (ccTableView *(^)(cc_heightForHeader))cc_heightForHeader{
    return ^ccTableView*(cc_heightForHeader block){
        if (block) {
            self.heightForHeader = block;
        }
        return self;
    };
}

- (ccTableView *(^)(cc_ViewForHeader))cc_ViewForHeader{
    return ^ccTableView*(cc_ViewForHeader block){
        if (block) {
            self.viewForHeader = block;
        }
        return self;
    };
}

- (ccTableView *(^)(cc_heightForFooter))cc_heightForFooter{
    return ^ccTableView*(cc_heightForFooter block){
        if (block) {
            self.heightForFooter = block;
        }
        return self;
    };
}

- (ccTableView *(^)(cc_ViewForFooter))cc_ViewForFooter{
    return ^ccTableView*(cc_ViewForFooter block){
        if (block) {
            self.viewForFooter = block;
        }
        return self;
    };
}

- (ccTableView *(^)(cc_numberOfSections))cc_numberOfSections{
    return ^ccTableView*(cc_numberOfSections block){
        if (block) {
            self.numberOfSections = block;
        }
        return self;
    };
}

- (ccTableView *(^)(cc_numberOfRows))cc_numberOfRows{
    return ^ccTableView*(cc_numberOfRows block){
        if (block) {
            self.numberOfRows = block;
        }
        return self;
    };
}

- (ccTableView *(^)(cc_heightForCell))cc_heightForCell{
    return ^ccTableView*(cc_heightForCell block){
        if (block) {
            self.heightForCell = block;
        }
        return self;
    };
}

- (ccTableView *(^)(cc_ViewForCell))cc_ViewForCell{
    return ^ccTableView*(cc_ViewForCell block){
        if (block) {
            self.viewForCell = block;
        }
        return self;
    };
}

- (ccTableView *(^)(cc_canEditRowAtIndexPath))cc_canEditRowAtIndexPath{
    return ^ccTableView*(cc_canEditRowAtIndexPath block){
        if (block) {
            self.canEditRowAtIndexPath = block;
        }
        return self;
    };
}

- (ccTableView *(^)(cc_commitEditingStylePath))cc_commitEditingStylePath{
    return ^ccTableView*(cc_commitEditingStylePath block){
        if (block) {
            self.commitEditingStylePath = block;
        }
        return self;
    };
}

- (ccTableView *(^)(cc_titleEditString))cc_titleEditString{
    return ^ccTableView*(cc_titleEditString block){
        if (block) {
            self.titleEditString = block;
        }
        return self;
    };
}

- (ccTableView *(^)(cc_didSelectRowAtIndexPath))cc_didSelectRowAtIndexPath{
    return ^ccTableView*(cc_didSelectRowAtIndexPath block){
        if (block) {
            self.didSelectRowAtIndexPath = block;
        }
        return self;
    };
}

@end
