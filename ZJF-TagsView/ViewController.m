//
//  ViewController.m
//  ZJF-TagsView
//
//  Created by zjf on 2018/11/5.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ViewController.h"
#import "ZJFTagsView.h"

@interface ViewController () <TagsViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZJFTagsView * tagsView = [[ZJFTagsView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 130)];
    
    tagsView.tagsArr = @[@"你好", @"你好吗", @"你好吗最近", @"你好吗昨天", @"你好？？？", @"你好123", @"你好你好你好你好", @"你好！", @"你好666", @"你好", @"你好你好", @"你好---++", @"你好666", @"你好", @"你好你好", @"你好---++", @"你好666", @"你好", @"你好你好", @"你好---++", @"你好666", @"你好", @"你好你好", @"你好---++"];
    tagsView.delegate = self;
    [self.view addSubview:tagsView];
    
    [tagsView initSubViews];
}

#pragma mark - TagsViewDelegate
- (void)tagsClickedWithIndex:(NSInteger)index {
    NSLog(@"---%ld", index);
}

- (void)switchBtnClicked:(BOOL)fullScreen {
    if (fullScreen) {
        NSLog(@"---Full");
    }
    else {
        NSLog(@"---Not Full");
    }
}



@end
