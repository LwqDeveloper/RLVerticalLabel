//
//  RLVerticalLabel.m
//  RLVerticalLabelDemo
//
//  Created by 李韦琼 on 17/3/21.
//  Copyright © 2017年 ___ Zoro___. All rights reserved.
//

#import "RLVerticalLabel.h"
#import <CoreText/CoreText.h>

@interface RLVerticalLabel ()

@property (nonatomic, assign) CGRect originalFrame;

@property (nonatomic, assign) CGFloat trailing;

@end

@implementation RLVerticalLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _lineSpace = 5.0;
        _font = [UIFont systemFontOfSize:16];
        _textColor = [UIColor blackColor];
        _originalFrame = frame;
    }
    return self;
}

- (void)adjustFrameFromTextNeedRotate:(BOOL)needRotate
{
    if (!needRotate) {
        self.transform = CGAffineTransformRotate (self.transform, -M_PI_2);
    }
    //计算宽度
    CGRect rect = [self calculateTextRect];
    _trailing = (_originalFrame.size.height -rect.size.width) *2/3.0;

    CGRect currentFrame = _originalFrame;
    //宽度<-高度
    currentFrame.size.width = currentFrame.size.height;
    //高度<-宽度
    currentFrame.size.height = rect.size.height;
    self.frame = currentFrame;

    //旋转 顺时针90°
    self.transform = CGAffineTransformRotate (self.transform, M_PI_2);
    //回位
    CGRect newFrame = self.frame;
    newFrame.origin = _originalFrame.origin;
    self.frame = newFrame;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 步骤 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 步骤 2
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, rect.size.height +_trailing);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // 步骤 3
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    NSString *content = self.text;
    NSInteger length = [content length];
    // 步骤 4
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    
    [attString addAttribute:(NSString *)kCTFontAttributeName
                      value:_font
                      range:NSMakeRange(0, length)];
    [attString addAttribute:(NSString *)kCTForegroundColorAttributeName value:_textColor range:NSMakeRange(0, length)];
    [attString addAttribute:(id)kCTVerticalFormsAttributeName value:[NSNumber numberWithBool:YES] range:NSMakeRange(0, length)];
    [attString addAttribute:(id)kCTFrameProgressionAttributeName value:[NSNumber numberWithUnsignedInt:kCTFrameProgressionRightToLeft] range:NSMakeRange(0, length)];
    
    CGFloat lineSpace = _lineSpace;//间距数据
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    lineSpaceStyle.value = &lineSpace;
    
    CTParagraphStyleSetting settings[] = {
        lineSpaceStyle
    };
    
    CTParagraphStyleRef paragraphStyle1 = CTParagraphStyleCreate(settings, sizeof(settings));
    
    //给字符串添加样式attribute
    [attString addAttribute:(id)kCTParagraphStyleAttributeName
                      value:(id)paragraphStyle1
                      range:NSMakeRange(0, length)];
    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, length), path, NULL);
    
    // 步骤 5
    CTFrameDraw(frame, context);
    
    // 步骤 6
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

#pragma mark - setter
- (void)setText:(NSString *)text
{
    _text = text;
    
    [self adjustFrameFromTextNeedRotate:YES];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    
    [self adjustFrameFromTextNeedRotate:NO];
}

- (void)setLineSpace:(CGFloat)lineSpace
{
    _lineSpace = lineSpace;
    
    [self adjustFrameFromTextNeedRotate:NO];
}

- (CGRect)calculateTextRect
{
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    style.lineSpacing = _lineSpace;
    
    NSDictionary *attributes = @{NSFontAttributeName : _font, NSParagraphStyleAttributeName : style,NSKernAttributeName:@(_lineSpace)};
    CGRect rect = [_text boundingRectWithSize:CGSizeMake(_originalFrame.size.height, CGFLOAT_MAX) options:opts attributes:attributes context:nil];
    return rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
