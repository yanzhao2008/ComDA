#include <stdio.h>
#include <stdlib.h>
#include <vicNl.h>

static char vcid[] = "$Id: soil_thermal_eqn.c,v 4.1.4.5 2007/10/08 20:25:18 vicadmin Exp $";

double soil_thermal_eqn(double T, va_list ap) {

 /******************************************************************
  Modifications:

  Apr 24, 2007: Added EXP_TRANS option.						JCA
                (therefore fprime removed)
  Apr 24, 2007: Rearranged terms in finite-difference heat equation (equation 8
                of Cherkauer et al. (1999)).  see note in solve_T_profile.
                This affects the equation for value.  (also see below for 
                the physical meaning of each of the terms).			JCA
  Apr 24, 2007: Added patch for the "cold nose" problem using the EXPLICIT  
                option. (see comments on this in fda_heat_eqn in frozen_soil.c)	JCA
  Aug 08, 2007: Added EXCESS_ICE option.					JCA
  Oct 08, 2007: Fixed error in EXP_TRANS formulation.				JCA
  ******************************************************************/


  double value;

  double TL;
  double TU;
  double T0;
  double moist;
  double max_moist;
#if QUICK_FS
  double **ufwc_table;
#else
  double bubble;
  double expt;
#endif
#if EXCESS_ICE
  double porosity;
  double effective_porosity;
#endif
  double ice0;
  double gamma;
  double A;
  double B;
  double C;
  double D;
  double E;
  double ice;
  int EXP_TRANS;
  int node;
  double flux_term1;
  double flux_term2;

  TL         = (double) va_arg(ap, double);
  TU         = (double) va_arg(ap, double);
  T0         = (double) va_arg(ap, double);
  moist      = (double) va_arg(ap, double);
  max_moist  = (double) va_arg(ap, double);
#if QUICK_FS
  ufwc_table = (double **) va_arg(ap, double **);
#else
  bubble     = (double) va_arg(ap, double);
  expt       = (double) va_arg(ap, double);
#endif
#if EXCESS_ICE
  porosity   = (double) va_arg(ap, double);
  effective_porosity   = (double) va_arg(ap, double);
#endif
  ice0       = (double) va_arg(ap, double);
  gamma      = (double) va_arg(ap, double);
  A          = (double) va_arg(ap, double);
  B          = (double) va_arg(ap, double);
  C          = (double) va_arg(ap, double);
  D          = (double) va_arg(ap, double);
  E          = (double) va_arg(ap, double);
  EXP_TRANS  = (int) va_arg(ap, int);
  node       = (int) va_arg(ap, int);

  if(T<0.) {
#if QUICK_FS
    ice = moist - maximum_unfrozen_water_quick(T, max_moist,
					       ufwc_table);
#else
#if EXCESS_ICE
    ice = moist - maximum_unfrozen_water(T,porosity,effective_porosity,max_moist,bubble,expt);
#else
    ice = moist - maximum_unfrozen_water(T,max_moist,bubble,expt);
#endif
#endif
    if(ice<0.) ice=0.;
    if(ice>max_moist) ice=max_moist;
  }
  else ice=0.;

  /* physical meaning of individual terms below: (JCA) */
  /* (see Cherkauer et al. 1999 equations 4-7) */
  /* A*(T-T0) / (a constant)  -> storage term */
  /* B*(TL-TU) / (a constant)  -> flux term 1 : this is the problem term in
     the "cold nose" problem*/
  /* C*(TL-T) / (a constant)  -> flux term 2a */
  /* D*(T-TU) / (a constant)  -> flux term 2b */
  /* E*(ice-ice0) / (a constant)  -> phase term */
  /* for !EXP_TRANS, this constant is alpha^2*deltat */
  /* for EXP_TRANS, this constant is 4*deltat*Bexp^2*(Zsum[node]+1)^2 */

  if(!EXP_TRANS) {
    value = -A*(T-T0) + B*(TL-TU) + C*(TL-T) - D*(T-TU) + E*(ice-ice0);  //new formulation
    //value = -A*(T-T0) + B*(TL-TU) + C*(TL+TU-2*T) - D*(TL-TU) + E*(ice-ice0);  //old formulation

    //inelegant fix for "cold nose" problem - when a very cold node skates off to
    //much colder and breaks the second law of thermodynamics (because
    //flux_term1 exceeds flux_term2 in absolute magnitude) - therefore, don't let
    //that node get any colder.  This only seems to happen in the first and
    flux_term1 = B*(TL-TU);
    flux_term2 = C*(TL-T) - D*(T-TU);
    if(node==1){  //for near-surface node only
      if(fabs(TL-TU)>5. && (T<TL && T<TU)){  //cold nose
	if((flux_term1<0 && flux_term2>0) && fabs(flux_term1)>fabs(flux_term2)){
	  //set flux_term1 equal to zero
	  value = -A*(T-T0) + C*(TL-T) - D*(T-TU) + E*(ice-ice0); //new formulation
	}
      }
    }

  }
  else { //grid transform value
    value = -A*(T-T0) + B*(TL-TU) + C*(TL-2.*T+TU) - D*(TL-TU) + E*(ice-ice0);

    // inelegant fix for "cold nose" problem (same as above)
    flux_term1 = B*(TL-TU);
    flux_term2 = C*(TL-2.*T+TU) - D*(TL-TU);
    if(node==1){  //for near-surface node only
      if(fabs(TL-TU)>5. && (T<TL && T<TU)){  //cold nose
	if((flux_term1<0 && flux_term2>0) && fabs(flux_term1)>fabs(flux_term2)){
	  //set flux_term1 equal to zero
	  value = -A*(T-T0) + C*(TL-2.*T+TU) - D*(TL-TU) + E*(ice-ice0);
	}
      }
    }

  }

  return(value);

}
