!        generated by tapenade     (inria, ecuador team)
!  tapenade 3.16 () -  9 feb 2021 14:55
!
module paramturb_diff
!
!       module that contains the constants for the turbulence models
!       as well as some global variables/parameters for the turbulent
!       routines.
!
  use constants, only : realtype, inttype
  use inputphysicsiff, only : saconsts, saconstsd
  implicit none
  save 
!
!       spalart-allmaras constants.
!
  real(kind=realtype), save :: rsak=0.41_realtype
  real(kind=realtype) :: rsakd=0.0_8
  real(kind=realtype), save :: rsacb1=0.1355_realtype
  real(kind=realtype) :: rsacb1d=0.0_8
  real(kind=realtype), save :: rsacb2=0.622_realtype
  real(kind=realtype) :: rsacb2d=0.0_8
  real(kind=realtype), save :: rsacb3=0.66666666667_realtype
  real(kind=realtype) :: rsacb3d=0.0_8
  real(kind=realtype), save :: rsacv1=7.1_realtype
  real(kind=realtype) :: rsacv1d=0.0_8
! = rsacb1/(rsak**2) &
  real(kind=realtype) :: rsacw1
  real(kind=realtype) :: rsacw1d
!         + (1.+rsacb2)/rsacb3
  real(kind=realtype), save :: rsacw2=0.3_realtype
  real(kind=realtype) :: rsacw2d=0.0_8
  real(kind=realtype), save :: rsacw3=2.0_realtype
  real(kind=realtype) :: rsacw3d=0.0_8
  real(kind=realtype), save :: rsact1=1.0_realtype
  real(kind=realtype), save :: rsact2=2.0_realtype
  real(kind=realtype), save :: rsact3=1.2_realtype
  real(kind=realtype) :: rsact3d=0.0_8
  real(kind=realtype), save :: rsact4=0.5_realtype
  real(kind=realtype) :: rsact4d=0.0_8
  real(kind=realtype), save :: rsacrot=2.0_realtype
  real(kind=realtype) :: rsacrotd=0.0_8
!
!       k-omega constants.
!
  real(kind=realtype), parameter :: rkwk=0.41_realtype
  real(kind=realtype), parameter :: rkwsigk1=0.5_realtype
  real(kind=realtype), parameter :: rkwsigw1=0.5_realtype
  real(kind=realtype), parameter :: rkwsigd1=0.5_realtype
  real(kind=realtype), parameter :: rkwbeta1=0.0750_realtype
  real(kind=realtype), parameter :: rkwbetas=0.09_realtype
!
!       k-omega sst constants.
!
  real(kind=realtype), parameter :: rsstk=0.41_realtype
  real(kind=realtype), parameter :: rssta1=0.31_realtype
  real(kind=realtype), parameter :: rsstbetas=0.09_realtype
  real(kind=realtype), parameter :: rsstsigk1=0.85_realtype
  real(kind=realtype), parameter :: rsstsigw1=0.5_realtype
  real(kind=realtype), parameter :: rsstbeta1=0.0750_realtype
  real(kind=realtype), parameter :: rsstsigk2=1.0_realtype
  real(kind=realtype), parameter :: rsstsigw2=0.856_realtype
  real(kind=realtype), parameter :: rsstbeta2=0.0828_realtype
!
!       k-tau constants.
!
  real(kind=realtype), parameter :: rktk=0.41_realtype
  real(kind=realtype), parameter :: rktsigk1=0.5_realtype
  real(kind=realtype), parameter :: rktsigt1=0.5_realtype
  real(kind=realtype), parameter :: rktsigd1=0.5_realtype
  real(kind=realtype), parameter :: rktbeta1=0.0750_realtype
  real(kind=realtype), parameter :: rktbetas=0.09_realtype
!
!       v2-f constants.
!
  real(kind=realtype), parameter :: rvfc1=1.4_realtype
  real(kind=realtype), parameter :: rvfc2=0.3_realtype
  real(kind=realtype), parameter :: rvfbeta=1.9_realtype
  real(kind=realtype), parameter :: rvfsigk1=1.0_realtype
  real(kind=realtype), parameter :: rvfsige1=0.7692307692_realtype
  real(kind=realtype), parameter :: rvfsigv1=1.00_realtype
  real(kind=realtype), parameter :: rvfcn=70.0_realtype
  real(kind=realtype), parameter :: rvfn1cmu=0.190_realtype
  real(kind=realtype), parameter :: rvfn1a=1.300_realtype
  real(kind=realtype), parameter :: rvfn1b=0.250_realtype
  real(kind=realtype), parameter :: rvfn1cl=0.300_realtype
  real(kind=realtype), parameter :: rvfn6cmu=0.220_realtype
  real(kind=realtype), parameter :: rvfn6a=1.400_realtype
  real(kind=realtype), parameter :: rvfn6b=0.045_realtype
  real(kind=realtype), parameter :: rvfn6cl=0.230_realtype
  real(kind=realtype) :: rvflimitk, rvflimite, rvfcl
  real(kind=realtype) :: rvfcmu
!
!       variables to store the parameters for the wall functions fits.
!       as these variables depend on the turbulence model they are set
!       during runtime. allocatables are used, because the number of
!       fits could be different for the different models.
!       the curve is divided in a number of intervals and is
!       constructed such that both the function and the derivatives
!       are continuous. consequently cubic polynomials are used.
!
! nfit:               number of intervals of the curve.
! ypt(0:nfit):        y+ values at the interval boundaries.
! ret(0:nfit):        reynolds number at the interval
!                     boundaries, where the reynolds number is
!                     defined with the local velocity and the
!                     wall distance.
! up0(nfit):          coefficient 0 in the fit for the
!                     nondimensional tangential velocity as a
!                     function of the reynolds number.
! up1(nfit):          idem for coefficient 1.
! up2(nfit):          idem for coefficient 2.
! up3(nfit):          idem for coefficient 3.
! tup0(nfit,nt1:nt2): coefficient 0 in the fit for the
!                     nondimensional turbulence variables as a
!                     function of y+.
! tup1(nfit,nt1:nt2): idem for coefficient 1.
! tup2(nfit,nt1:nt2): idem for coefficient 2.
! tup3(nfit,nt1:nt2): idem for coefficient 3.
! tulogfit(nt1:nt2):  whether or not the logarithm of the variable
!                     has been fitted.
  integer(kind=inttype) :: nfit
  real(kind=realtype), dimension(:), allocatable :: ypt, ret
  real(kind=realtype), dimension(:), allocatable :: up0, up1
  real(kind=realtype), dimension(:), allocatable :: up2, up3
  real(kind=realtype), dimension(:, :), allocatable :: tup0, tup1
  real(kind=realtype), dimension(:, :), allocatable :: tup2, tup3
  logical, dimension(:), allocatable :: tulogfit

contains
!  differentiation of saassign in forward (tangent) mode (with options i4 dr8 r8):
!   variations   of useful results: rsak rsacv1 rsacw1 rsacw2 rsacw3
!                rsact3 rsact4 rsacrot rsacb1 rsacb2 rsacb3
!   with respect to varying inputs: saconsts
!reassign sa constants
  subroutine saassign_d()
    implicit none
    real(kind=realtype) :: temp
    real(kind=8) :: temp0
    rsakd = saconstsd(1)
    rsak = saconsts(1)
    rsacb1d = saconstsd(2)
    rsacb1 = saconsts(2)
    rsacb2d = saconstsd(3)
    rsacb2 = saconsts(3)
    rsacb3d = saconstsd(4)
    rsacb3 = saconsts(4)
    rsacv1d = saconstsd(5)
    rsacv1 = saconsts(5)
    temp = rsacb1/(rsak*rsak)
    temp0 = (rsacb2+1.)/rsacb3
    rsacw1d = (rsacb1d-temp*2*rsak*rsakd)/rsak**2 + (rsacb2d-temp0*&
&     rsacb3d)/rsacb3
    rsacw1 = temp + temp0
    rsacw2d = saconstsd(6)
    rsacw2 = saconsts(6)
    rsacw3d = saconstsd(7)
    rsacw3 = saconsts(7)
    rsact1 = saconsts(8)
    rsact2 = saconsts(9)
    rsact3d = saconstsd(10)
    rsact3 = saconsts(10)
    rsact4d = saconstsd(11)
    rsact4 = saconsts(11)
    rsacrotd = saconstsd(12)
    rsacrot = saconsts(12)
  end subroutine saassign_d

!reassign sa constants
  subroutine saassign()
    implicit none
    rsak = saconsts(1)
    rsacb1 = saconsts(2)
    rsacb2 = saconsts(3)
    rsacb3 = saconsts(4)
    rsacv1 = saconsts(5)
    rsacw1 = rsacb1/rsak**2 + (1.+rsacb2)/rsacb3
    rsacw2 = saconsts(6)
    rsacw3 = saconsts(7)
    rsact1 = saconsts(8)
    rsact2 = saconsts(9)
    rsact3 = saconsts(10)
    rsact4 = saconsts(11)
    rsacrot = saconsts(12)
  end subroutine saassign

end module paramturb_diff

