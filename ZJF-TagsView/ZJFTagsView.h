//
//  ZJFTagsView.h
//  Demo-TagsView
//
//  Created by zjf on 2018/11/5.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TagsViewDelegate <NSObject>
//标签点击回调事件
-(void)tagsClickedWithIndex:(NSInteger)index isSelected:(BOOL)isSelected;
//切换frame大小按钮事件
-(void)switchBtnClicked:(BOOL)fullScreen;
@end

@interface ZJFTagsView : UIView

//标签文字内容数组
@property(nonatomic, strong)NSArray * tagsArr;

@property (nonatomic, weak) id<TagsViewDelegate> delegate;

- (void)initSubViews;

@end

NS_ASSUME_NONNULL_END
