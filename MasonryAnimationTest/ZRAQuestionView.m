//
//  ZRAQuestionView.m
//  ios_ZRAModule
//
//  Created by 刘艳芹 on 2020/2/4.
//

#import "ZRAQuestionView.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>

@interface ZRAQuestionSubView : UIView
- (instancetype)initWithQuestionText:(NSString *)question;
//@property (nonatomic, strong)RACSubject *questionSubject;
@property (nonatomic, copy) void (^clickQuestionBlock)(void);
@end

@implementation ZRAQuestionSubView

- (instancetype)initWithQuestionText:(NSString *)question
{
    self = [super init];
    if (self) {
        self.layer.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.65].CGColor;
        self.layer.cornerRadius = 4;
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@14);
            make.bottom.equalTo(@(-14));
            make.trailing.equalTo(@(-10));
            make.width.height.equalTo(@12);
        }];
        imageView.image = [UIImage imageNamed:@"icon_send"];
        
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@12);
            make.bottom.equalTo(@(-12));
            make.leading.equalTo(@10);
            make.trailing.equalTo(imageView.mas_leading).offset(-9);
        }];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        label.text = question;
        label.numberOfLines = 1;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(questionMethod)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}

-(void)questionMethod{
//    [self.questionSubject sendNext:nil];
    if (self.clickQuestionBlock) {
        self.clickQuestionBlock();
    }
}

//-(RACSubject *)questionSubject{
//    if (_questionSubject == nil) {
//        _questionSubject = [RACSubject subject];
//    }
//    return _questionSubject;
//}

@end


@interface ZRAQuestionView (){
    BOOL _isShow;
}

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *whiteView;
@end

@implementation ZRAQuestionView

- (instancetype)initWithDataArray:(NSArray *)dataArray
{
    self = [super init];
    if (self) {
        self.dataArray = dataArray;
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
    self.whiteView = [[UIView alloc]init];
    [self addSubview:self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@78);
        make.height.equalTo(@40);
    }];
    
    self.whiteView.layer.borderWidth = 0.5;
    self.whiteView.layer.borderColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.12].CGColor;
    
    self.whiteView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.whiteView.layer.cornerRadius = 20.5;
    self.whiteView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.08].CGColor;
    self.whiteView.layer.shadowOffset = CGSizeMake(0,2);
    self.whiteView.layer.shadowOpacity = 1;
    self.whiteView.layer.shadowRadius = 10;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(questionMethod)];
    [self.whiteView addGestureRecognizer:gesture];
    UIImageView *arrowImageView = [[UIImageView alloc]init];
    [self.whiteView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.leading.equalTo(@16);
        make.width.height.equalTo(@12);
    }];
    arrowImageView.image = [UIImage imageNamed:@"icon_unfoldup_12_c4"];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [self.whiteView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.leading.equalTo(arrowImageView.mas_trailing).offset(4);
    }];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.85];
    titleLabel.text = @"提问";
    
    for (int i = 0; i< self.dataArray.count; i++) {
        
        ZRAQuestionSubView *questionView = [[ZRAQuestionSubView alloc]initWithQuestionText:self.dataArray[i]];
        [self addSubview:questionView];
        questionView.tag = 100 + i;
        questionView.alpha = 0;
        [questionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.bottom.equalTo(self.whiteView.mas_top).offset(-6);
            make.trailing.equalTo(@0);
        }];
//        @weakify(self);
//        [questionView.questionSubject subscribeNext:^(id x) {
//            @strongify(self);
//        }];
        __weak typeof(self) weakSelf = self;
        questionView.clickQuestionBlock = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
        };
    }
}

-(void)questionMethod{
    if (_isShow == YES) {
        [self dismissView];
        _isShow = NO;
    }else{
        [self showView];
        _isShow = YES;
    }
    
}

-(void)showView{
    MASViewAttribute *attribute;
    for (UIView *view in self.subviews) {
        if (view.tag < self.dataArray.count + 100 && [view isKindOfClass:[ZRAQuestionSubView class]]) {
            ZRAQuestionSubView *subView = (ZRAQuestionSubView *)view;
            
            [UIView animateWithDuration:1 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                subView.alpha = 1;
                [subView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@40);
                    make.trailing.equalTo(@0);
                    if (attribute) {
                        make.bottom.equalTo(attribute).offset(-6);
                    }else{
                        make.bottom.equalTo(self.whiteView.mas_top).offset(-6);
                    }
                }];
                [self layoutIfNeeded];
                
            } completion:nil];
            
            attribute = subView.mas_top;
            
        }
    }
}

-(void)dismissView{
    MASViewAttribute *attribute;
    for (UIView *view in self.subviews) {
        if (view.tag < self.dataArray.count + 100 && [view isKindOfClass:[ZRAQuestionSubView class]]) {
            ZRAQuestionSubView *subView = (ZRAQuestionSubView *)view;
            
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                subView.alpha = 0;
                [subView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@40);
                    make.bottom.equalTo(self.whiteView.mas_top).offset(-6);
                    make.trailing.equalTo(@0);
                }];
                [self layoutIfNeeded];
            } completion:nil];
            
            attribute = subView.mas_bottom;
        }
    }
}

@end
