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
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 1;
        self.alpha = 0.5;
    }
    return self;
}

@end
