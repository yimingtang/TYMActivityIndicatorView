//
//  TYMDemoViewController.m
//  Example
//
//  Created by Yiming Tang on 14-2-9.
//  Copyright (c) 2014 Yiming Tang. All rights reserved.
//

#import "TYMDemoViewController.h"
#import "TYMActivityIndicatorView.h"

@interface TYMDemoViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView1;
@property (nonatomic, strong) TYMActivityIndicatorView *activityIndicatorView2;
@property (nonatomic, strong) TYMActivityIndicatorView *activityIndicatorView3;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation TYMDemoViewController

#pragma mark - Accessors


- (UIActivityIndicatorView *)activityIndicatorView1
{
    if (!_activityIndicatorView1) {
        _activityIndicatorView1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityIndicatorView1 stopAnimating];
        _activityIndicatorView1.hidesWhenStopped = NO;
    }
    return _activityIndicatorView1;
}


- (TYMActivityIndicatorView *)activityIndicatorView2
{
    if (!_activityIndicatorView2) {
        _activityIndicatorView2 = [[TYMActivityIndicatorView alloc] initWithActivityIndicatorStyle:TYMActivityIndicatorViewStyleNormal];
        _activityIndicatorView2.hidesWhenStopped = NO;
    }
    return _activityIndicatorView2;
}


- (TYMActivityIndicatorView *)activityIndicatorView3
{
    if (!_activityIndicatorView3) {
        _activityIndicatorView3 = [[TYMActivityIndicatorView alloc] initWithActivityIndicatorStyle:TYMActivityIndicatorViewStyleLarge];
        _activityIndicatorView3.hidesWhenStopped = NO;
    }
    return _activityIndicatorView3;
}


- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_button setTitle:@"Start" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}


- (UISlider *)slider
{
    if (!_slider) {
        _slider = [[UISlider alloc] init];
        [_slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];

    [self.view addSubview:self.activityIndicatorView1];
    [self.view addSubview:self.activityIndicatorView2];
    [self.view addSubview:self.activityIndicatorView3];
    [self.view addSubview:self.slider];
    [self.view addSubview:self.button];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    CGSize size = self.view.bounds.size;
    CGFloat offsetY = 40.0f;
    
    self.activityIndicatorView1.frame = CGRectMake(150.0f, offsetY, 20.0f, 20.0f);
    offsetY += 30.0;
    self.activityIndicatorView2.frame = CGRectMake(141.0f, offsetY, 37.0f, 37.0f);
    offsetY += 47.0f;
    self.activityIndicatorView3.frame = CGRectMake(81.0f, offsetY, 157.0f, 157.0f);
    offsetY += 167.0f;
    self.slider.frame = CGRectMake(20.0f, offsetY, 280.0f, 32.0f);
    offsetY += 42.0f;
    self.button.frame = CGRectMake((size.width - 100.0f) / 2, offsetY, 100.0f, 40.0f);
}


#pragma mark - Actions

- (void)sliderChanged:(UISlider *)slider
{
    self.activityIndicatorView2.progress = slider.value;
    self.activityIndicatorView3.progress = slider.value;
}


- (void)buttonClicked:(UIButton *)button
{
    if (self.activityIndicatorView1.isAnimating) {
        [self.activityIndicatorView1 stopAnimating];
        [self.activityIndicatorView2 stopAnimating];
        [self.activityIndicatorView3 stopAnimating];
        [_button setTitle:@"Start" forState:UIControlStateNormal];
        self.slider.enabled = YES;
    } else {
        [self.activityIndicatorView1 startAnimating];
        [self.activityIndicatorView2 startAnimating];
        [self.activityIndicatorView3 startAnimating];
        [_button setTitle:@"Stop" forState:UIControlStateNormal];
        self.slider.enabled = NO;
    }
    
    self.slider.value = 0.0f;
}

@end
