//
//  firstTableViewCell.m
//  ccTableView
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 cc. All rights reserved.
//

#import "firstTableViewCell.h"

@implementation firstTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel* label = [[UILabel alloc] initWithFrame:self.bounds];
        label.text = @"自定义...左滑一下";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
    }
    return self;
}

@end
