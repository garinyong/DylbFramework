//
//  ViewController.m
//  FaxianFramework
//
//  Created by garin on 16/4/15.
//  Copyright © 2016年 com.dangdang.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//    imageView.image = [UIImage imageNamed:@"11"];
//    imageView.image = [UIImage imageNamed:@"11" inBundle:[NSBundle bundleForClass:self.class]
//            compatibleWithTraitCollection:nil];
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    NSString *imageUrl = [NSString stringWithFormat:@"%@/11.png",frameworkBundle.bundlePath];
    imageView.image = [[UIImage alloc] initWithContentsOfFile:imageUrl];
//    imageView.image = [UIImage imageNamed:@"FaxianFramework.framework/11"];
//    imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:imageView];
    
    NSLog(@"imageurl:%@",imageUrl);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"close" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    btn.frame = CGRectMake(self.view.bounds.size.width - 100, 20, 80, 60);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void) btnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
