//
//  ViewController.m
//  AutolayoutAnimation
//
//  Created by yuqiu on 15/12/3.
//  Copyright © 2015年 yuqiu. All rights reserved.
//

#import "ViewController.h"
#import "HomePageAnimationUtil.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldBottomLineConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *phoneIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *topTipsLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomTipsView;
@property (weak, nonatomic) IBOutlet UIButton *regButton;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  实用了autolayout 就不能用改变控件的frame来实现动画
     */
    _topTitleLabel.transform = CGAffineTransformMakeTranslation(0, -200);
    _bottomTitleLabel.transform = CGAffineTransformMakeTranslation(0, -200);

    _phoneIconImageView.transform = CGAffineTransformMakeTranslation(-200, 0);
    
    _textFieldBottomLineConstraint.constant = 0;//通过改变NSLayoutConstraint的constraint来实现动画 Autolayout中的constant ＝ 345
    
    
    CGFloat progress = _numberTextField.text.length/11.0;
    
    [HomePageAnimationUtil registerButtonWidthAnimation:_regButton withView:self.view andProgress:progress];
    
    //为什么要用通知不用协议？因为协议不能达到实时性
    //    通知
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLength) name:UITextFieldTextDidChangeNotification object:self.numberTextField];
}

//实现通知方法
- (void)updateLength {
    CGFloat progress = _numberTextField.text.length/11.0;//不加.0 除出来的结果是一个int类型 (取当前数的最大整数 0.9 ＝ 0 , 1.1 ＝ 1)
    
    [HomePageAnimationUtil registerButtonWidthAnimation:_regButton withView:self.view andProgress:progress];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [HomePageAnimationUtil titleLabelAnimationWithLabel:_topTitleLabel withView:self.view];
    [HomePageAnimationUtil titleLabelAnimationWithLabel:_bottomTitleLabel withView:self.view];
    
    [HomePageAnimationUtil textFieldBottomLineAnimationWithConstraint:_textFieldBottomLineConstraint WithView:self.view];
    
    [HomePageAnimationUtil phoneIconAnimationWithLabel:_phoneIconImageView withView:self.view];
    
    [HomePageAnimationUtil tipsLabelMaskAnimation:_topTipsLabel withBeginTime:0];
    [HomePageAnimationUtil tipsLabelMaskAnimation:_bottomTipsView withBeginTime:1];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - override view method

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
