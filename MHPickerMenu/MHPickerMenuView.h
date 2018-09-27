//
//  MHPickerMenuView.h
//  MHPickerMenu
//
//  Created by 哈哈 on 2018/9/27.
//  Copyright © 2018年 MengHeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^selectedBlock)(NSString *selectedStr);

@interface MHPickerMenuView : UIView
@property (nonatomic,strong)  NSDictionary *dataDict;
@property (nonatomic,strong)  NSMutableArray *rightData;
@property (nonatomic,assign)  selectedBlock block;
-(instancetype)initWithFrame:(CGRect)frame dataDict:(NSDictionary*)dataDict;
@end

NS_ASSUME_NONNULL_END
