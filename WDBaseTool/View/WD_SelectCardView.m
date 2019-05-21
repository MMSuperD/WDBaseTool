//
// WD_SelectCardView.m
//  GY
//
//  Created by wangwei on 2019/5/18.
//  Copyright © 2019 SuperD. All rights reserved.
//

#import "WD_SelectCardView.h"
#import <Masonry.h>

@interface WD_SelectCardView()

/**
 Default 4 rowL
 */
@property (nonatomic,assign)NSUInteger rowL;

/**
 Default 10pt
 */
@property (nonatomic,assign)CGFloat leftHorizontalMargin;

/**
 Default 10pt
 */
@property (nonatomic,assign)CGFloat midHorizontalMargin;

/**
 Default 10pt
 */
@property (nonatomic,assign)CGFloat rightHorizontalMargin;


/**
 Default 10pt
 */
@property (nonatomic,assign)CGFloat topVerticalMargin;

/**
 Default 10pt
 */
@property (nonatomic,assign)CGFloat midVerticalMargin;

/**
 Default 10pt
 */
@property (nonatomic,assign)CGFloat bottomVerticalMargin;


@property (nonatomic,strong)NSMutableArray<WD_UnitView *> *unitViewArray;

/**
 Default 4,The number of titleArrayCount has to be equal to imageNameArrayCount
 */
@property (nonatomic,strong)NSArray<NSString *> *titleArray;

/**
 Default 4,The number of titleArrayCount has to be equal to imageNameArrayCount
 */
@property (nonatomic,strong)NSArray<NSString *> *imageNameArray;


/**
 unitConfiguration value
 */
@property (nonatomic,strong)NSDictionary *unitViewConfiguration;

@end

@implementation WD_SelectCardView

- (NSMutableArray<WD_UnitView *> *)unitViewArray {
    if (!_unitViewArray) {
        
        _unitViewArray = [NSMutableArray array];
        
    }
    return _unitViewArray;
}

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
- (instancetype)initWithConfiguration:(NSDictionary *)configuration unitViewConfiguration:(NSDictionary *)unitConfiguration titleArray:(NSArray<NSString *> *)titleArray imageNameArray:(NSArray<NSString *> *)imageNameArray
{
    self = [super init];
    if (self) {
        [self initData:configuration unitViewConfiguration:unitConfiguration titleArray:titleArray imageNameArray:imageNameArray];
        [self setSubView];
        
    }
    return self;
}

- (void)initData:(NSDictionary *)configuration unitViewConfiguration:(NSDictionary *)unitViewConfiguration titleArray:(NSArray<NSString *> *)titleArray imageNameArray:(NSArray<NSString *> *)imageNameArray {
    
    //unitViewConfiguration
    self.unitViewConfiguration = unitViewConfiguration;
    
    if (configuration && imageNameArray.count > 0 && titleArray.count > 0) {
        self.leftHorizontalMargin       = [configuration[@"leftHorizontalMargin"] floatValue];
        self.midHorizontalMargin        = [configuration[@"midHorizontalMargin"] floatValue];
        self.rightHorizontalMargin      = [configuration[@"midHorizontalMargin"] floatValue];
        self.topVerticalMargin          = [configuration[@"topVerticalMargin"] floatValue];
        self.midVerticalMargin          = [configuration[@"midVerticalMargin"] floatValue];
        self.bottomVerticalMargin       = [configuration[@"bottomVerticalMargin"] floatValue];
        self.rowL                       = [configuration[@"rowL"] integerValue];
        self.titleArray = titleArray;
        self.imageNameArray = imageNameArray;
        return;
    }
    self.leftHorizontalMargin       = 10.0;
    self.midHorizontalMargin        = 10.0;
    self.rightHorizontalMargin      = 10.0;
    self.topVerticalMargin          = 10.0;
    self.midVerticalMargin          = 10.0;
    self.bottomVerticalMargin       = 10.0;
    self.rowL                       = 4;
}

- (void)setSubView {
    
    //创建View
    for (int i = 0; i < self.titleArray.count; i++) {
        WD_UnitView *unitView = [[WD_UnitView alloc] initWithTitle:self.titleArray[i] imageName:self.imageNameArray[i] configuration:self.unitViewConfiguration];
        [self.unitViewArray addObject:unitView];
        unitView.tag = i;
        [unitView addTarget:self action:@selector(actionUnitView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:unitView];
    }
    
    //设置约束
    NSInteger rowL = 0,rowH = 0;
    for (int i = 0; i < self.unitViewArray.count; i++) {
        rowL = i % self.rowL;
        rowH = i / self.rowL;
        [self.unitViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (rowH < 1) {
                make.top.mas_equalTo(self.mas_top).mas_equalTo(WScale(self.topVerticalMargin));
            } else {
                make.top.mas_equalTo(self.unitViewArray[self.rowL * (rowH - 1) + rowL].mas_bottom).mas_offset(WScale(self.midVerticalMargin));
            }
            
            if (rowL == 0) {
                make.leading.mas_equalTo(self.mas_leading).mas_offset(WScale(self.leftHorizontalMargin));
            } else {
                
                make.leading.mas_equalTo(self.unitViewArray[rowL - 1].mas_trailing).mas_offset(WScale(self.midHorizontalMargin));
            }
            
            if (i == self.unitViewArray.count - 1) {
                make.bottom.mas_equalTo(self.mas_bottom).mas_offset(WScale(-self.bottomVerticalMargin));
            }
            
            if (i == self.rowL - 1 ) {
                
                make.trailing.mas_equalTo(self.mas_trailing).mas_offset(WScale(-self.rightHorizontalMargin));
            }
            
            if (i == self.unitViewArray.count - 1 && i < self.rowL - 1) {
                
                make.trailing.mas_equalTo(self.mas_trailing).mas_offset(WScale(-self.rightHorizontalMargin));
            }
            
        }];
    }
    
    
    
}

- (void)actionUnitView:(WD_UnitView *)sender {
    if (self.delegate) {
        [self.delegate selectCardClickIndex:sender.tag];
    }
}



@end

@interface WD_UnitView()

/**
 title
 */
@property (nonatomic,strong)NSString *title;


/**
 image name
 */
@property (nonatomic,strong)NSString *imageName;

/**
 Default 10pt
 */
@property (nonatomic,assign)CGFloat topImageViewMargin;

/**
 Default 10pt
 */
@property (nonatomic,assign)CGFloat leftImageViewMargin;

/**
 Default 10pt
 */
@property (nonatomic,assign)CGFloat rightImageViewMargin;

/**
 Default 30pt
 */
@property (nonatomic,assign)CGFloat imageViewWidth;

/**
 Default 30pt
 */
@property (nonatomic,assign)CGFloat imageViewHeight;

/**
 Default 10pt
 */
@property (nonatomic,assign)CGFloat topLabelMargin;

/**
 Default 10pt
 */
@property (nonatomic,assign)CGFloat bottomLabelMargin;

/**
 Default 14pt
 */
@property (nonatomic,assign)CGFloat font;

/**
 Default [UIColor black]
 */
@property (nonatomic,copy)NSString *textColor;

@end

@implementation WD_UnitView

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName configuration:(NSDictionary *)configuration
{
    self = [super init];
    if (self) {
        [self initDataTitle:title imageName:imageName configuration:configuration];
        [self setSubView];
        
    }
    return self;
}

- (void)initDataTitle:(NSString *)title imageName:(NSString *)imageName configuration:(NSDictionary *)configuration {
    self.title = title;
    self.imageName = imageName;
    self.backgroundColor = [UIColor whiteColor];
    
    if (configuration) {
        self.topImageViewMargin = [configuration[@"topImageViewMargin"] floatValue];
        self.leftImageViewMargin = [configuration[@"leftImageViewMargin"] floatValue];
        self.rightImageViewMargin = [configuration[@"rightImageViewMargin"] floatValue];
        self.imageViewWidth = [configuration[@"imageViewWidth"] floatValue];
        self.imageViewHeight = [configuration[@"imageViewHeight"] floatValue];
        self.topLabelMargin = [configuration[@"topLabelMargin"] floatValue];
        self.font = [configuration[@"font"] floatValue];
        self.bottomLabelMargin = [configuration[@"bottomLabelMargin"] floatValue];
        self.textColor = [configuration[@"textColor"] description];
        
        return;
    }
    
    self.topImageViewMargin = WScale(10.0);
    self.leftImageViewMargin = WScale(10.0);
    self.rightImageViewMargin = WScale(10.0);
    self.imageViewWidth = WScale(20.0);
    self.imageViewHeight = WScale(20.0);
    self.topLabelMargin = WScale(10.0);
    self.font = WScale(14);
    self.bottomLabelMargin = WScale(10.0);
    self.textColor = @"#000000";
    
    
    
}

- (void)setSubView {
    
    UIImageView *iconImageV = [UIImageView new];
    [self addSubview:iconImageV];
    [iconImageV setImage:[UIImage imageNamed:self.imageName]];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WScale(self.imageViewWidth));
        make.height.mas_equalTo(WScale(self.imageViewHeight));
        make.top.mas_equalTo(self.mas_top).mas_offset(WScale(self.topImageViewMargin));
        make.leading.mas_equalTo(self.mas_leading).mas_offset(WScale(self.leftImageViewMargin));
        make.trailing.mas_equalTo(self.mas_trailing).mas_offset(WScale(-self.rightImageViewMargin));
    }];
    
    UILabel *titleLael = [UILabel new];
    [self addSubview:titleLael];
    titleLael.text = self.title;
    titleLael.font = [UIFont systemFontOfSize:WScale(self.font)];
    
    [titleLael mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageV.mas_bottom).mas_offset(WScale(self.topLabelMargin));
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(WScale(-self.bottomLabelMargin));
        make.centerX.mas_equalTo(iconImageV.mas_centerX);
    }];
    
}

@end
