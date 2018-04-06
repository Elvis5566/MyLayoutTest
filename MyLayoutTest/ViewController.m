//
//  ViewController.m
//  MyLayoutTest
//
//  Created by Elvis Lee on 4/5/18.
//

#import "ViewController.h"
#import <MyLayout/MyLinearLayout.h>

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

@interface ViewController ()<UIPageViewControllerDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) MyLinearLayout *contentLayout;
@property (strong, nonatomic) UIView *testView;

@property (strong, nonatomic) NSArray *controllers;
@property (strong, nonatomic) UIViewController *pageViewController;

@end

@implementation ViewController

- (void)setControllers:(NSArray *)controllers {
    _controllers = controllers;
    int i = 0;
    for (UIViewController *controller in controllers) {
        controller.view.tag = i++;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = false;
    MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLayout.myHorzMargin = 0;                          //同时指定左右边距为0表示宽度和父视图一样宽
    contentLayout.heightSize.lBound(self.view.heightSize, 10, 1); //高度虽然是wrapContentHeight的。但是最小的高度不能低于父视图的高度加10.

    [self.scrollView addSubview:contentLayout];
    self.contentLayout = contentLayout;

    UIButton *yellowButton = [UIButton new];
    [yellowButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [yellowButton setTitle:@"Button" forState:UIControlStateNormal];
    [yellowButton addTarget:self action:@selector(onButtonClick) forControlEvents:UIControlEventTouchUpInside];
    yellowButton.backgroundColor = UIColor.yellowColor;
    yellowButton.myHorzMargin = 0;
    yellowButton.myHeight = SCREEN_WIDTH * 0.5625f + STATUS_BAR_HEIGHT;
    [self.contentLayout addSubview:yellowButton];

    NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(0)};
//    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
//                                                                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
//                                                                                             options:options];

    UIViewController *pageViewController = [UIViewController new];

    pageViewController.view.backgroundColor = UIColor.brownColor;
    pageViewController.view.myHorzMargin = 0;
    pageViewController.view.myHeight = 500;

    [self.contentLayout addSubview:pageViewController.view];
    self.pageViewController = pageViewController;

    // 用一般的view沒問題, height
//    UIView *view = [UIView new];
//    view.myHorzMargin = 0;
//    view.myHeight = 500;
//    view.backgroundColor = UIColor.redColor;
//    [self.contentLayout addSubview:view];
//    self.testView = view;
}

- (void)onButtonClick {
    NSLog(@"self.pageViewController.view height: %f", self.pageViewController.view.frame.size.height);
    NSLog(@"self.testView.frame.size.height: %f", self.testView.frame.size.height);
}

@end
