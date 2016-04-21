//
//  ViewController.m
//  invokeDylbDemo
//
//  Created by garin on 16/4/20.
//  Copyright © 2016年 com.abc.abc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)loadDyldBtnClick:(id)sender {
    
    [self testLib];
}

-(void) testLib
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = nil;
    if ([paths count] != 0)
        documentDirectory = [paths objectAtIndex:0];
    
    //拼接我们放到document中的framework路径
    NSString *libName = @"FaxianFramework.framework";
    NSString *destLibPath = [documentDirectory stringByAppendingPathComponent:libName];
    
    //判断一下有没有这个文件的存在　如果没有直接跳出
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:destLibPath]) {
        NSLog(@"There isn't have the file");
        return;
    }
    
    //复制到程序中
    //NSError *error = nil;
    
    //加载方式一：使用dlopen加载动态库的形式　使用此种方法的时候注意头文件的引入
    //    void* lib_handle = dlopen([destLibPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_LOCAL);
    //    if (!lib_handle) {
    //        NSLog(@"Unable to open library: %s\n", dlerror());
    //        return;
    //    }
    //加载方式一　关闭的方法
    // Close the library.
    //    if (dlclose(lib_handle) != 0) {
    //        NSLog(@"Unable to close library: %s\n",dlerror());
    //    }
    
    //加载方式二：使用NSBundle加载动态库
    NSError *err = nil;
    
    NSBundle *frameworkBundle = [NSBundle bundleWithPath:destLibPath];
    if (frameworkBundle && [frameworkBundle loadAndReturnError:&err]) {
        NSLog(@"bundle load framework success.");
    }else {
        NSLog(@"bundle load framework err:%@",err);
        return;
    }
    
    /*
     *通过NSClassFromString方式读取类
     *PacteraFramework　为动态库中入口类
     */
    Class pacteraClass = NSClassFromString(@"MainViewController");
    if (!pacteraClass) {
        NSLog(@"Unable to get TestDylib class");
        return;
    }
    
    /*
     *初始化方式采用下面的形式
     　alloc　init的形式是行不通的
     　同样，直接使用PacteraFramework类初始化也是不正确的
     *通过- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;
     　方法调用入口方法（showView:withBundle:），并传递参数（withObject:self withObject:frameworkBundle）
     */
    NSObject *pacteraObject = [pacteraClass new];
    //    [pacteraObject performSelector:@selector(showView:withBundle:) withObject:self withObject:frameworkBundle];
    
    if ([pacteraObject isKindOfClass:[UIViewController class]])
    {
        [self presentViewController:(UIViewController *)pacteraObject animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
