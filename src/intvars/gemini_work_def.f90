module gemini_work_def

use phys_consts, only: wp
use precipdataobj, only: precipdata
use efielddataobj, only: efielddata
use neutraldataobj, only: neutraldata
use neutraldata3Dobj, only: neutraldata3D
use neutraldata3Dobj_fclaw, only: neutraldata3D_fclaw
use neutral, only: neutral_info
use solfluxdataobj, only: solfluxdata

!> type encapsulating internal arrays and parameters needed by gemini.  This is basically a catch-all for any data
!    in a gemini instance that is needed to advance the solution that must be passed into numerical procedures BUt
!    doesn't conform to simple array shapes.
! type gemini_work
!   real(wp), dimension(:,:,:), pointer :: Phiall=>null()    !! full-grid potential solution.  To store previous time step value
!   real(wp), dimension(:,:,:), pointer :: iver    !! integrated volume emission rate of aurora calculated by GLOW

!   !> Other variables used by the fluid solvers
!   real(wp), dimension(:,:,:,:), pointer :: vs1i
!   real(wp), dimension(:,:,:,:), pointer :: vs2i
!   real(wp), dimension(:,:,:,:), pointer :: vs3i
!   real(wp), dimension(:,:,:,:), pointer :: Q    ! artificial viscosity

!   !> Neutral information for top-level gemini program
!   type(neutral_info), pointer :: atmos

!   !> Inputdata objects that are needed for each subgrid
!   type(precipdata), pointer :: eprecip=>null()
!   type(efielddata), pointer :: efield=>null()
!   class(neutraldata), pointer :: atmosperturb=>null()   ! not associated by default and may never be associated

!   !> User can add any other parameters they want to pass around into this type
!   real(wp), dimension(:,:,:), pointer :: sigP=>null()
!   real(wp), dimension(:,:,:), pointer :: sigH=>null()
! end type gemini_work

type gemini_work
  real(wp), dimension(:,:,:), pointer :: Phiall=>null()    ! full-grid potential solution.  To store previous time step value
  real(wp), dimension(:,:,:), pointer :: iver=>null()      ! integrated volume emission rate of aurora calculated by GLOW

  !> Other variables used by the fluid solvers
  real(wp), dimension(:,:,:,:), pointer :: vs1i=>null()    ! cell interface velocities for the 1,2, and 3 directions
  real(wp), dimension(:,:,:,:), pointer :: vs2i=>null()
  real(wp), dimension(:,:,:,:), pointer :: vs3i=>null()
  real(wp), dimension(:,:,:,:), pointer :: Q=>null()       ! artificial viscosity

  !> Used to pass information about electron precipitation between procedures
  integer :: lprec=2                                                            ! number of precipitating electron populations
  real(wp), dimension(:,:,:), pointer :: W0=>null(),PhiWmWm2=>null()            ! characteristic energy and total energy flux arrays
  real(wp), dimension(:,:,:,:), pointer :: PrPrecip=>null(), Prionize=>null()   ! ionization rates from precipitation and total sources
  real(wp), dimension(:,:,:), pointer :: QePrecip=>null(), Qeionize=>null()     ! electron heating rates from precip. and total
  real(wp), dimension(:,:,:,:), pointer :: Pr=>null(),Lo=>null()                ! work arrays for tracking production/loss rates for conservation laws

  !> Use to pass information about electromagnetic boundary condtions between procedures
  integer :: flagdirich
  real(wp), dimension(:,:), pointer :: Vminx1,Vmaxx1
  real(wp), dimension(:,:), pointer :: Vminx2,Vmaxx2
  real(wp), dimension(:,:), pointer :: Vminx3,Vmaxx3
  real(wp), dimension(:,:,:), pointer :: E01,E02,E03
  real(wp), dimension(:,:), pointer :: Vminx1slab,Vmaxx1slab

  !> Used to pass solar flux data between routine
  real(wp), dimension(:,:,:,:), pointer :: Iinf

  !> Neutral information for top-level gemini program
  type(neutral_info), pointer :: atmos=>null()

  !> Inputdata objects that are needed for each subgrid
  type(precipdata), pointer :: eprecip=>null()          ! input precipitation information 
  type(efielddata), pointer :: efield=>null()           ! contains input electric field data
  class(neutraldata), pointer :: atmosperturb=>null()   ! perturbations about atmospheric background; not associated by default and may never be associated
  type(solfluxdata), pointer :: solflux=>null()         ! perturbations to solar flux, e.g., from a flare or eclipse

  !> User can add any other parameters they want to pass around into this type
  real(wp), dimension(:,:,:), pointer :: sigP=>null()
  real(wp), dimension(:,:,:), pointer :: sigH=>null()

  end type gemini_work

contains

end module gemini_work_def
