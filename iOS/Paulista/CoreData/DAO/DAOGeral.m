//
//  DAOGeral.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "DAOGeral.h"
#import "AppDelegate.h"
#import "DAOClube.h"
#import "Clube.h"

@implementation DAOGeral

+(Geral*)fetchGeralWithCode:(int)codigo
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allGeral = [[NSFetchRequest alloc] init];
    [allGeral setEntity:[NSEntityDescription entityForName:@"Geral" inManagedObjectContext:context]];
    
    NSError * readError = nil;
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"codigo == %i", codigo];
    [allGeral setPredicate:predicate];
    
    NSArray *fetchArray = [context executeFetchRequest:allGeral error:&readError];
    
    if (fetchArray.count > 0) {
        return [fetchArray objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

+(NSArray*)fetchAllGeral
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allGeral = [[NSFetchRequest alloc] init];
    [allGeral setEntity:[NSEntityDescription entityForName:@"Geral" inManagedObjectContext:context]];
    
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pontosGanhos" ascending:NO];
    //    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"nrVitorias" ascending:NO];
    //    NSSortDescriptor *sortDescriptor3 = [[NSSortDescriptor alloc] initWithKey:@"saldoGols" ascending:NO];
    //    NSSortDescriptor *sortDescriptor4 = [[NSSortDescriptor alloc] initWithKey:@"nrGolsMarcados" ascending:NO];
    //    NSSortDescriptor *sortDescriptor5 = [[NSSortDescriptor alloc] initWithKey:@"clube.nome" ascending:YES];
    //
    //    [allGeral setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, sortDescriptor2, sortDescriptor3, sortDescriptor4, sortDescriptor5, nil]];
    
    
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"posicao" ascending:YES];
    NSSortDescriptor *sortDescriptor5 = [[NSSortDescriptor alloc] initWithKey:@"clube.nome" ascending:YES];

    [allGeral setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor,sortDescriptor5, nil]];
    
    NSError * readError = nil;
    
    NSArray *fetchArray = [context executeFetchRequest:allGeral error:&readError];
    
    return fetchArray;
}

+(void)parseAndInsertObjectsWithJson:(NSDictionary*)json;
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSMutableArray *GeralArray = [json objectForKey:@"Classificacao"];
    
    for (NSDictionary *dictGeral in GeralArray) {
        Geral *geral = [DAOGeral fetchGeralWithCode:[[dictGeral objectForKey:@"codigo"] intValue]];
        
        if (geral == nil) {
            geral = [NSEntityDescription insertNewObjectForEntityForName:@"Geral" inManagedObjectContext:context];
            geral.codigo = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"codigo"] integerValue]];
            geral.pontosGanhos = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"pontosganhos"] integerValue]];
            geral.nrVitorias = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"nrvitorias"] integerValue]];
            geral.saldoGols = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"saldogols"] integerValue]];
            geral.nrGolsMarcados = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"nrgolsmarcados"] integerValue]];
            geral.dsgrupo = [dictGeral objectForKey:@"grupo"];
            geral.posicao = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"posicao"] integerValue]];
            geral.nrGolsContra = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"nrgolscontra"] integerValue]];
            geral.empates = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"empates"] integerValue]];
            geral.derrotas = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"derrotas"] integerValue]];
            geral.jogos = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"jogos"] integerValue]];
        }
        else
        {
            geral.pontosGanhos = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"pontosganhos"] integerValue]];
            geral.nrVitorias = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"nrvitorias"] integerValue]];
            geral.saldoGols = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"saldogols"] integerValue]];
            geral.nrGolsMarcados = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"nrgolsmarcados"] integerValue]];
            geral.dsgrupo = [dictGeral objectForKey:@"grupo"];
            geral.posicao = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"posicao"] integerValue]];
            geral.nrGolsContra = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"nrgolscontra"] integerValue]];
            geral.empates = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"empates"] integerValue]];
            geral.derrotas = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"derrotas"] integerValue]];
            geral.jogos = [NSNumber numberWithInteger:[[dictGeral objectForKey:@"jogos"] integerValue]];
        }
        
        Clube *clube = [DAOClube fetchClubeWithCode:[[dictGeral objectForKey:@"codigo"] intValue]];
        
        if (clube == nil)
        {
            NSDictionary *dictClube = [dictGeral objectForKey:@"clube"];
            clube = [NSEntityDescription insertNewObjectForEntityForName:@"Clube" inManagedObjectContext:context];
            clube.codigo = [NSNumber numberWithInteger:[[dictClube objectForKey:@"codigo"] integerValue]];
            clube.nome = [dictClube objectForKey:@"nome"];
            clube.escudo = [dictClube objectForKey:@"escudo"];
            clube.sigla = [dictClube objectForKey:@"sigla"];
        }
        
        [geral setClube:clube];
        
    }
    
    NSError *saveError;
    
    [context save:&saveError];
}

@end


