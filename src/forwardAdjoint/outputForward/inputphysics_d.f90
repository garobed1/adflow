   !        Generated by TAPENADE     (INRIA, Tropics team)
   !  Tapenade 3.10 (r5363) -  9 Sep 2014 09:53
   !
   !      ==================================================================
   MODULE INPUTPHYSICS_D
   !
   !      ******************************************************************
   !      *                                                                *
   !      * Input parameters which are related to the physics of the flow, *
   !      * like governing equations, mode of the equations, turbulence    *
   !      * model and free stream conditions.                              *
   !      *                                                                *
   !      ******************************************************************
   !
   USE PRECISION
   IMPLICIT NONE
   SAVE 
   !
   !      ******************************************************************
   !      *                                                                *
   !      * Definition of some parameters which make the code more         *
   !      * readable. The actual values of this parameters are arbitrary;  *
   !      * in the code always the symbolic names are (should be) used.    *
   !      *                                                                *
   !      ******************************************************************
   !
   INTEGER(kind=inttype), PARAMETER :: eulerequations=1, nsequations=2, &
   & ransequations=3
   INTEGER(kind=inttype), PARAMETER :: steady=1, unsteady=2, timespectral&
   & = 3
   INTEGER(kind=inttype), PARAMETER :: internalflow=1, externalflow=2
   INTEGER(kind=inttype), PARAMETER :: cpconstant=1, cptempcurvefits=2
   INTEGER(kind=inttype), PARAMETER :: baldwinlomax=1, spalartallmaras=2&
   & , spalartallmarasedwards=3, komegawilcox=4, komegamodified=5, ktau=6, &
   & mentersst=7, v2f=10
   INTEGER(kind=inttype), PARAMETER :: strain=1, vorticity=2, katolaunder&
   & = 3
   !
   !      ******************************************************************
   !      *                                                                *
   !      * Definition of the physics input parameters.                    *
   !      *                                                                *
   !      ******************************************************************
   !
   ! equations:           Governing equations to be solved.
   ! equationMode:        Mode of the equations, steady, unsteady
   !                      or timeSpectral.
   ! flowType:            Type of flow, internal or external.
   ! cpModel:             Which cp model, constant or function of
   !                      temperature via curve fits.
   ! turbModel:           Turbulence model.
   ! turbProd:            Which production term to use in the transport
   !                      turbulence equations, strain, vorticity or
   !                      kato-launder.
   ! rvfN:                Determines the version of v2f turbulence model.
   ! rvfB:                Whether or not to solve v2f with an
   !                      upper bound.
   ! wallFunctions:       Whether or not to use wall functions.
   ! wallDistanceNeeded:  Whether or not the wall distance is needed
   !                      for the turbulence model in a RANS problem.
   ! Mach:                Free stream Mach number.
   ! MachCoef:            Mach number used to compute coefficients;
   !                      only relevant for translating geometries.
   ! MachGrid:            Mach number of the Mesh. Used in stability 
   !                      derivative calculations. Specified as the
   !                      negative of the desired freestream Mach number.
   !                      When this option is set, set Mach = 0.0...
   ! velDirFreestream(3): Direction of the free-stream velocity.
   !                      Internally this vector is scaled to a unit
   !                      vector, so there is no need to specify a
   !                      unit vector. Specifying this vector solves
   !                      the problem of angle of attack and yaw angle
   !                      definition as well as the direction of the
   !                      axis (e.g. y- or z-axis in spanwise direction).
   ! liftDirection(3):    Direction vector for the lift.
   ! dragDirection(3):    Direction vector for the drag.
   ! Reynolds:            Reynolds number.
   ! ReynoldsLength:      Length used to compute the Reynolds number.
   ! tempFreestream:      Free stream temperature in Kelvin.
   ! gammaConstant:       Constant specific heat ratio.
   ! RGasDim:             Gas constant in S.I. units.
   ! Prandtl:             Prandtl number.
   ! PrandtlTurb:         Turbulent prandtl number.
   ! pklim:               Limiter for the production of k, the production
   !                      is limited to pklim times the destruction.
   ! wallOffset:          Offset from the wall when wall functions
   !                      are used.
   ! eddyVisInfRatio:     Free stream value of the eddy viscosity.
   ! turbIntensityInf:    Free stream value of the turbulent intensity.
   ! surfaceRef:          Reference area for the force and moments
   !                      computation.
   ! lengthRef:           Reference length for the moments computation.
   ! pointRef(3):         Moment reference point.
   ! pointRefEC(3):       Elastic center. Bending moment refernce point
   INTEGER(kind=inttype) :: equations, equationmode, flowtype
   INTEGER(kind=inttype) :: turbmodel, cpmodel, turbprod
   INTEGER(kind=inttype) :: rvfn
   LOGICAL :: rvfb
   LOGICAL :: wallfunctions, walldistanceneeded
   REAL(kind=realtype) :: mach, machcoef, machgrid
   REAL(kind=realtype) :: machd, machcoefd, machgridd
   REAL(kind=realtype) :: reynolds, reynoldslength
   REAL(kind=realtype) :: tempfreestream, gammaconstant, rgasdim
   REAL(kind=realtype) :: tempfreestreamd
   REAL(kind=realtype) :: prandtl, prandtlturb, pklim, walloffset
   REAL(kind=realtype) :: eddyvisinfratio, turbintensityinf
   REAL(kind=realtype) :: surfaceref, lengthref
   REAL(kind=realtype) :: lengthrefd
   REAL(kind=realtype), DIMENSION(3) :: veldirfreestream
   REAL(kind=realtype), DIMENSION(3) :: veldirfreestreamd
   REAL(kind=realtype), DIMENSION(3) :: liftdirection
   REAL(kind=realtype), DIMENSION(3) :: liftdirectiond
   REAL(kind=realtype), DIMENSION(3) :: dragdirection
   REAL(kind=realtype), DIMENSION(3) :: dragdirectiond
   REAL(kind=realtype), DIMENSION(3) :: pointref
   REAL(kind=realtype), DIMENSION(3) :: pointrefd
   REAL(kind=realtype), DIMENSION(3) :: pointrefec
   ! Return forces as tractions instead of forces:
   LOGICAL :: forcesastractions
   END MODULE INPUTPHYSICS_D