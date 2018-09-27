//
//  ViewController.m
//  MHPickerMenu
//
//  Created by 哈哈 on 2018/9/27.
//  Copyright © 2018年 MengHeng. All rights reserved.
//

#import "ViewController.h"
#import "MHPickerMenuView.h"
@interface ViewController ()
@property (nonatomic,strong)  MHPickerMenuView *pickerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shiftDataList" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    NSDictionary *dataDict = arr.firstObject;
    MHPickerMenuView *view = [[MHPickerMenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 400) dataDict:dataDict];
    [self.view addSubview:view];
    self.pickerView = view;
    view.block = ^(NSString * _Nonnull selectedStr) {
        NSLog(@"%@",selectedStr);
    };
}



@end
