//
//  normsinv.c
//  Calcul
//
//  Created by Fan ZHAO on 11-8-7.
//  Copyright 2011年 Personne. All rights reserved.
//

#include "normsinv.h"
double normInv(double p1) {
    double x, p, c0, c1, c2, d1, d2, d3, t, q;
    double result;
    
    q = p1;
    
    
    if (q == 0.5) {
        result = 0;
    }else{
        q = 1.0 - q;
        
        if ( (q>0) && (q<0.5) ){
            p = q;
        }
        else {
            if (q == 1) {
                p = 1-0.999999;
            }
            else{
                p = 1.0 - q;
            }
        }
        
        t = sqrt( log(1.0/(p*p)));
        
        c0 = 2.515517;
        c1 = 0.802853;
        c2 = 0.010328;
        
        d1 = 1.432788;
        d2 = 0.189269;
        d3 = 0.001308;
        x = t - (c0 + c1 * t + c2 * (t * t)) / (1.0 + d1 * t + d2 * (t * t) + d3 * (t * t * t));
        
        if (q>0.5) x = -1.0 * x;
    }
    
    return (x * 1) + 0;
}
