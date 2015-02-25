//
//  CollectionSupplementaryView.h
//  CollectionViewCircleLayout
//
//  Created by AnujKosambi on 25/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AlbumSupplyResuseIdentifier @"supply"
#define AlbumHeaderSupplyKind @"Header"

@interface CollectionSupplementaryView : UICollectionReusableView

@property (nonatomic, strong) UILabel *sectionHeader;

@end
