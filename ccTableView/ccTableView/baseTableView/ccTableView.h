//
//  baseTableView.h
//  xmjr-restructure
//
//  Created by foxdingding on 2018/7/19.
//  Copyright © 2018年 QuickstartApp. All rights reserved.
//

#import "ccTableView.h"
#import <UIKit/UIKit.h>

@interface ccTableView : UIView

NS_ASSUME_NONNULL_BEGIN

//创建Group样式 参数可空
- (instancetype)initGroupTableView:(nullable Class)cellClass reuseIdentifier:(nonnull NSString*)reuseIdentifier frame:(CGRect)frame;

//创建Plain样式 参数可空
- (instancetype)initPlainTableView:(nullable Class)cellClass reuseIdentifier:(nonnull NSString*)reuseIdentifier frame:(CGRect)frame;

- (void)cc_reload;//最后需要刷新

@property (nonatomic, strong) UITableView* tableView;

#pragma mark ------------------------- typedef -------------------------

/**
 * 高度
 */
typedef NSInteger (^cc_heightForHeader)(NSInteger section,UITableView* tableView);
typedef NSInteger (^cc_heightForFooter)(NSInteger section,UITableView* tableView);
typedef NSInteger (^cc_heightForCell)(NSIndexPath *indexPath,UITableView* tableView);

/**
 * view
 */
typedef UIView* _Nonnull (^cc_ViewForFooter)(NSInteger section,UITableView* tableView);
typedef UIView* _Nonnull (^cc_ViewForHeader)(NSInteger section,UITableView* tableView);
typedef void (^cc_ViewForCell)(NSIndexPath *indexPath,UITableView* tableView,UITableViewCell* cell);

/**
 * 数量
 */
typedef NSInteger (^cc_numberOfSections)(UITableView* tableView);
typedef NSInteger (^cc_numberOfRows)(NSInteger section,UITableView* tableView);

/**
 * 左滑样式
 */
typedef BOOL (^cc_canEditRowAtIndexPath)(NSIndexPath *indexPath,UITableView* tableView);
typedef UITableViewCellEditingStyle (^cc_editingStyleForRowAtIndexPath)(NSIndexPath *indexPath,UITableView* tableView);
typedef void (^cc_commitEditingStylePath)(NSIndexPath *indexPath,UITableView* tableView,UITableViewCellEditingStyle style);
typedef NSString* _Nullable (^cc_titleEditString)(NSIndexPath *indexPath,UITableView* tableView);

/**
 * 点击
 */
typedef void (^cc_didSelectRowAtIndexPath)(NSIndexPath *indexPath,UITableView* tableView);

#pragma mark ------------------------- property -------------------------

/**
 * 头部视图
 */
@property(nonatomic,copy,readonly) ccTableView *(^cc_heightForHeader)(cc_heightForHeader block);
@property(nonatomic,copy,readonly) ccTableView *(^cc_ViewForHeader)(cc_ViewForHeader block);

/**
 * 尾部视图
 */
@property(nonatomic,copy,readonly) ccTableView *(^cc_heightForFooter)(cc_heightForFooter block);
@property(nonatomic,copy,readonly) ccTableView *(^cc_ViewForFooter)(cc_ViewForFooter block);

/**
 * cell视图
 */
@property(nonatomic,copy,readonly) ccTableView *(^cc_numberOfSections)(cc_numberOfSections block);
@property(nonatomic,copy,readonly) ccTableView *(^cc_numberOfRows)(cc_numberOfRows block);
@property(nonatomic,copy,readonly) ccTableView *(^cc_heightForCell)(cc_heightForCell block);
@property(nonatomic,copy,readonly) ccTableView *(^cc_ViewForCell)(cc_ViewForCell block);

/**
 * 左滑编辑样式
 */
@property(nonatomic,copy,readonly) ccTableView *(^cc_canEditRowAtIndexPath)(cc_canEditRowAtIndexPath block);

@property(nonatomic,copy,readonly) ccTableView *(^cc_editingStyleForRowAtIndexPath)(cc_editingStyleForRowAtIndexPath block);

@property(nonatomic,copy,readonly) ccTableView *(^cc_commitEditingStylePath)(cc_commitEditingStylePath block);

@property(nonatomic,copy,readonly) ccTableView *(^cc_titleEditString)(cc_titleEditString block);

/**
 * 点击
 */

@property(nonatomic,copy,readonly) ccTableView *(^cc_didSelectRowAtIndexPath)(cc_didSelectRowAtIndexPath block);

NS_ASSUME_NONNULL_END

@end
