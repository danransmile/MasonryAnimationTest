//
//  BViewController.m
//  MasonryAnimationTest
//
//  Created by 刘艳芹 on 2020/2/5.
//  Copyright © 2020 刘艳芹. All rights reserved.
//

#import "BViewController.h"
#import <Masonry/Masonry.h>
#import "ZRAQuestionView.h"

@interface BViewController ()
@property (nonatomic, strong) ZRAQuestionView *questionView;
@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configQuestionView];
}

-(void)configQuestionView{
    NSArray *array = @[@"1",@"2",@"3",@"4"];
    self.questionView = [[ZRAQuestionView alloc]initWithDataArray:array];
    [self.view addSubview:self.questionView];
    [self.questionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-130));
        make.trailing.equalTo(@(-20));
        make.width.equalTo(@160);
        make.height.equalTo(@(array.count * 40 + array.count * 6 + 40));
    }];
}

@end
