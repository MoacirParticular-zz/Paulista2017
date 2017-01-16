//
//  Classificacao_Celula.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Classificacao_Celula : UITableViewCell


@property (nonatomic, strong) IBOutlet UILabel* posicao;
@property (nonatomic, strong) IBOutlet UIImageView* imgViewTime;
@property (nonatomic, strong) IBOutlet UILabel* pontosGanhos;
@property (nonatomic, strong) IBOutlet UILabel* jogos;
@property (nonatomic, strong) IBOutlet UILabel* vitorias;
@property (nonatomic, strong) IBOutlet UILabel* empates;
@property (nonatomic, strong) IBOutlet UILabel* derrotas;
@property (nonatomic, strong) IBOutlet UILabel* golsPro;
@property (nonatomic, strong) IBOutlet UILabel* golsContra;
@property (nonatomic, strong) IBOutlet UILabel* saldoGols;
@property (nonatomic, strong) UIColor *bgColor;
@property (strong, nonatomic) IBOutlet UILabel *nmTime;

@end
