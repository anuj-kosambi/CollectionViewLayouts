//
//  CollectionCircleCell.m
//  CollectionViewCircleLayout
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionCircleCell.h"

@implementation CollectionCircleCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [self.contentView setBackgroundColor:[UIColor darkGrayColor]];
        [self.contentView addSubview:self.imageView];
        self.layer.borderWidth = 3;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return self;
}

- (void)layoutSubviews {
    self.imageView.frame = self.bounds;
}

- (void)prepareForReuse {
    self.imageView.image = nil;
}

@end
