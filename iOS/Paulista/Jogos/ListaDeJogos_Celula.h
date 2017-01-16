//
//  ListaDeJogos_Celula.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaDeJogos_Celula : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel* golTimeMandante;
@property (nonatomic, strong) IBOutlet UILabel* golTimeVisitante;
@property (nonatomic, strong) IBOutlet UILabel* nmTimeMandante;
@property (nonatomic, strong) IBOutlet UILabel* nmTimeVisitante, *data, *hora;
@property (nonatomic, strong) IBOutlet UIImageView* imgTimeMandante;
@property (nonatomic, strong) IBOutlet UIImageView* imgTimeVisitante;
@property (nonatomic, strong) UIColor *bgColor;

@end
