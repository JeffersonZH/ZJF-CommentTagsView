//
//  ZJFTagsView.m
//  Demo-TagsView
//
//  Created by zjf on 2018/11/5.
//  Copyright © 2018年 zjf. All rights reserved.
//

#define BtnHeight 30
#define SpaceValue 10

#import "ZJFTagsView.h"

@interface ZJFTagsView ()

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat totalWidth;
@property (nonatomic, assign) NSInteger lineCount;
@property (nonatomic, assign) CGFloat lastBtnWdith;

@property (nonatomic, strong) UIButton * currentBtn;//记录所选btn
//@property (nonatomic, assign) NSInteger currentBtnIndex;//记录所选btn

@property (nonatomic, assign) BOOL fullFrame;

@end


@implementation ZJFTagsView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor cyanColor];
        self.layer.masksToBounds = YES;
        
        _x = 0;
        _lineCount = 0;
        _lastBtnWdith = 0;
        _currentBtn = nil;
    }
    return self;
}

- (void)initSubViews {
    
    for (NSInteger i = 0; i < self.tagsArr.count; i++) {
        CGFloat screenWidth = self.frame.size.width;
        CGSize btnSize = [self sizeWithText:self.tagsArr[i] font:[UIFont systemFontOfSize:17]];
        //width
        CGFloat btnWidth = btnSize.width;
        //height
        CGFloat btnHeight = 30;
        //x
        if (i == 0) {
            _x = SpaceValue;
        }
        else {
            if (_x + _lastBtnWdith + SpaceValue + btnSize.width < screenWidth) {
                _x = _x + _lastBtnWdith + SpaceValue;
            }
            else {
                _x = SpaceValue;
                _lineCount++;
            }
        }
        //y
        CGFloat y =  (btnHeight + SpaceValue) * _lineCount + SpaceValue;
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(_x, y, btnWidth, btnHeight);
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn setTitle:self.tagsArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.layer.cornerRadius = 4;
        btn.tag = 300 + i;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        _lastBtnWdith = btnSize.width;
    }
    
    UIButton * switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    switchBtn.frame = CGRectMake(SpaceValue, self.frame.size.height - 40, self.frame.size.width - SpaceValue * 2, 40);
    switchBtn.backgroundColor = self.backgroundColor;
    [switchBtn setTitle:@"大" forState:UIControlStateNormal];
    [switchBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [switchBtn addTarget:self action:@selector(switchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:switchBtn];
}

- (void)tagBtnClicked:(UIButton *)btn {
    BOOL selected;
    //是同一个：取消选中
    if (_currentBtn.tag == btn.tag) {
        selected = NO;
        _currentBtn = nil;
        btn.backgroundColor = [UIColor lightGrayColor];
    }
    //不是同一个：选中
    else {
        selected = YES;
        btn.backgroundColor = [UIColor redColor];
        _currentBtn.backgroundColor = [UIColor lightGrayColor];
        _currentBtn = btn;
    }
    

    if ([self.delegate respondsToSelector:@selector(tagsClickedWithIndex:isSelected:)]) {
        [self.delegate tagsClickedWithIndex:btn.tag isSelected:selected];
    }
}

- (void)switchBtnClicked:(UIButton *)btn {
    __weak typeof(self) wewakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        CGRect tempFrame = wewakSelf.frame;
        //放大
        if (!wewakSelf.fullFrame) {
            wewakSelf.fullFrame = YES;
            [btn setTitle:@"小" forState:UIControlStateNormal];
            
            tempFrame.size.height = SpaceValue + (BtnHeight + SpaceValue) * (wewakSelf.lineCount + 2);
            wewakSelf.frame = tempFrame;
        }
        //缩小
        else {
            wewakSelf.fullFrame = NO;
            [btn setTitle:@"大" forState:UIControlStateNormal];
            
            tempFrame.size.height = SpaceValue + (BtnHeight + SpaceValue) * 3;
            wewakSelf.frame = tempFrame;
        }
        
        btn.frame = CGRectMake(SpaceValue, self.frame.size.height - 40, self.frame.size.width - SpaceValue * 2, 40);
    } completion:^(BOOL finished) {
    }];
    
    if ([self.delegate respondsToSelector:@selector(switchBtnClicked:)]) {
        [self.delegate switchBtnClicked:self.fullFrame];
    }
}

//根据NSString、Font计算UILabel的Size
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font {
    NSDictionary * attDic = @{NSFontAttributeName : font};
    return [text sizeWithAttributes:attDic];
}

@end
