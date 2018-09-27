//
//  MHPickerMenuView.m
//  MHPickerMenu
//
//  Created by 哈哈 on 2018/9/27.
//  Copyright © 2018年 MengHeng. All rights reserved.
//

#import "MHPickerMenuView.h"

#define SCREENWIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT   [UIScreen mainScreen].bounds.size.height
#define TITLEHEADER  60
#define TITLE_NUMBER 5
#define BUTTON_HEIGHT 44

@interface MHPickerMenuView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  UIView *backgroundView;

@property (nonatomic,strong)  UITableView *leftTabelView;
@property (nonatomic,strong)  UITableView *rightTabelView;

@end

@implementation MHPickerMenuView

-(UIView*)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0)] ;
        _backgroundView.backgroundColor = [UIColor lightGrayColor];
        _backgroundView.alpha = 0.2;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapqq)];
        [_backgroundView addGestureRecognizer:tap];
        _backgroundView.userInteractionEnabled = YES;
    }
    
    return _backgroundView;
}


-(instancetype)initWithFrame:(CGRect)frame dataDict:(NSDictionary*)dataDict{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataDict = dataDict;
        [self setUpUi];
    }
    return self;
}

///
-(void)setUpUi{

 
    [self addSubview:self.backgroundView];
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"常用",@"类型",@"状态",@"位置",@"时间", nil];
    for (int i =0; i <TITLE_NUMBER; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i *SCREENWIDTH/TITLE_NUMBER, 0, SCREENWIDTH/TITLE_NUMBER, BUTTON_HEIGHT)];
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    UITableView *left = [[UITableView alloc] initWithFrame:CGRectMake(0, BUTTON_HEIGHT, SCREENWIDTH/2, 0)];
    left.delegate =self;
    left.dataSource = self;
    left.tableFooterView = [UIView new];

    [self addSubview:left];
    self.leftTabelView = left;
    UITableView *right = [[UITableView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2, TITLEHEADER, SCREENWIDTH/2, 0)];
    right.delegate =self;
    right.dataSource = self;
    right.tableFooterView = [UIView new];

    [self addSubview:right];
    self.rightTabelView = right;
}

#pragma mark ACTION
-(void)click:(UIButton*)sender{
    [UIView animateWithDuration:1 animations:^{
        self.backgroundView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        self.leftTabelView.frame = CGRectMake(0, BUTTON_HEIGHT, SCREENWIDTH/2, self.frame.size.height -TITLEHEADER);
        self.rightTabelView.frame = CGRectMake(SCREENWIDTH/2, BUTTON_HEIGHT, SCREENWIDTH/2, self.frame.size.height -TITLEHEADER);
        
    } completion:^(BOOL finished) {
        
    }];
}
    
-(void)tapqq{
    [self animation];
}

#pragma mark 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTabelView) {
        return self.dataDict.allKeys.count;
    } else {
        return self.rightData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (tableView == self.leftTabelView) {
        cell.textLabel.text = self.dataDict.allKeys[indexPath.row];
    } else{
        cell.textLabel.text = self.rightData[indexPath.row];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTabelView) {
        self.rightData = [self.dataDict objectForKey:self.dataDict.allKeys[indexPath.row]];
        [self.rightTabelView reloadData];
       
    } else {
        [self animation];
        if (self.block!=nil) {
            self.block(self.rightData[indexPath.row]);

        }
    }
    
}

-(void)animation{
    [UIView animateWithDuration:1 animations:^{
        self.leftTabelView.frame = CGRectMake(0, BUTTON_HEIGHT, SCREENWIDTH/2, 0);
        self.rightTabelView.frame = CGRectMake(SCREENWIDTH/2, BUTTON_HEIGHT, SCREENWIDTH/2, 0);
        self.backgroundView.frame = CGRectMake(0, 0, SCREENWIDTH, 0);

    } completion:^(BOOL finished) {
        
    }];
    
    
}
@end
