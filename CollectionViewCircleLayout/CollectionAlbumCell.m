//
//  CollectionCircleCell.m
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionAlbumCell.h"

@implementation CollectionAlbumCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    self.imageView.frame = self.bounds;
    self.imageView.layer.borderWidth = 2;
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.imageView.alpha = 1;
    self.layer.zPosition = 1;
}

- (void)prepareForReuse {
//    self.imageView.image = nil;
//    self.imageView.layer.borderWidth = 1;
    [self.contentView setBackgroundColor:[UIColor clearColor]];
}

@end
