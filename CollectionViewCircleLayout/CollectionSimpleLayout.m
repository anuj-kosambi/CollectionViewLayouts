//
//
//  
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionSimpleLayout.h"
#define kCellWidth 100
#define kCellHeight 100

@implementation CollectionSimpleLayout

- (void)prepareLayout {
    [super prepareLayout];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kCellWidth, kCellHeight);
}

@end
