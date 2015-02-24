//
//  CollectionDecorationView.m
//  CollectionViewCircleLayout
//
//  Created by AnujKosambi on 24/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionDecorationView.h"

@implementation CollectionDecorationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.layer.borderWidth = 10;
        self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:kBackgroundOpacity].CGColor;
        self.layer.shadowRadius = kShadowRadius;
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSizeMake(0, 10);
        
    }
    return self;
}

@end
