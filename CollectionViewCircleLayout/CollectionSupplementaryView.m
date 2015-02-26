//
//  CollectionSupplementaryView.m
//  CollectionViewCircleLayout
//
//  Created by AnujKosambi on 25/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionSupplementaryView.h"

@implementation CollectionSupplementaryView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame] ) {
        [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.7]];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 1;
//        self.layer.shadowOffset = CGSizeMake(0,20);
//        self.layer.shadowRadius = 20;
        self.layer.zPosition = 2;
        self.layer.shouldRasterize = YES;
        self.layer.opaque = YES;
        self.sectionHeader = [[UILabel alloc] initWithFrame:self.bounds];
        [self.sectionHeader setTextAlignment:NSTextAlignmentCenter];
        [self.sectionHeader setFont:[UIFont boldSystemFontOfSize:14]];
        [self addSubview:self.sectionHeader];
    }
    return self;
}


@end
