//
//  RLVerticalLabel.h
//  RLVerticalLabelDemo
//
//  Created by 李韦琼 on 17/3/21.
//  Copyright © 2017年 ___ Zoro___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLVerticalLabel : UIView

@property (nonatomic, copy  ) NSString  *text;
@property (nonatomic, strong) UIFont    *font;
@property (nonatomic, strong) UIColor   *textColor;
@property (nonatomic, assign) CGFloat   lineSpace;

@end
