//
//  Artilharia_Celula.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Artilharia_Celula : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* posicao;
@property (nonatomic, strong) IBOutlet UILabel* numeroGols;
@property (nonatomic, strong) IBOutlet UILabel* nmArtilheiro;
@property (nonatomic, strong) IBOutlet UIImageView* imgTimeArtilheiro;
@property (nonatomic, strong) UIColor *bgColor;

@end
