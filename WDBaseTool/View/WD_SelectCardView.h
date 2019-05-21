//
// WD_SelectCardView.h
//  GY
//
//  Created by wangwei on 2019/5/18.
//  Copyright © 2019 SuperD. All rights reserved.
//

/*
 1.这里必须导入Manory
 2.必须有View.width 等的基本分类
 */



#import <UIKit/UIKit.h>
#define WScale(x) ([UIScreen mainScreen].bounds.size.width * (x) / 375.0 )

NS_ASSUME_NONNULL_BEGIN

@protocol SelectCardViewClickDelegate <NSObject>


@optional
/**
 click message
 
 @param index click index
 */
- (void)selectCardClickIndex:(NSInteger)index;


/**
 return ArrayCount = 2
 first: TitleArray
 secound: ImageNameArray
 
 @return Array
 */
- (NSArray *)selectCardTitleAndImageName;

@end

@interface WD_SelectCardView : UIView

/**
 init View
 @param configuration configuration message
 @{
 @"leftHorizontalMargin":@(10.0),
 @"midHorizontalMargin":@(10.0),
 @"rightHorizontalMargin":@(10.0),
 @"topVerticalMargin":@(10.0),
 @"midVerticalMargin":@(10.0),
 @"bottomVerticalMargin":@(10.0),
 @"rowL":@(4)
 }
 @return PersonCenterSelectCardView
 */
- (instancetype)initWithConfiguration:(NSDictionary *)configuration unitViewConfiguration:(NSDictionary *)unitConfiguration titleArray:(NSArray<NSString *> *)titleArray imageNameArray:(NSArray<NSString *> *)imageNameArray;

/**
 click message Delegate
 */
@property (nonatomic,weak)id<SelectCardViewClickDelegate> delegate;


@end

@interface WD_UnitView : UIControl



/**
 init
 
 @param title title
 @param imageName image name
 @param configuration
 @{
 @"topImageViewMargin":@(10),
 @"leftImageViewMargin":@(10),
 @"rightImageViewMargin":@(10),
 @"imageViewWidth":@(30),
 @"imageViewHeight":@(30),
 @"topLabelMargin":@(10),
 @"bottomLabelMargin":@(10),
 @"font":@(14),
 @"textColor":@"#000000"
 }
 @return UnitView
 */
- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName configuration:(NSDictionary *)configuration;

@end

NS_ASSUME_NONNULL_END
