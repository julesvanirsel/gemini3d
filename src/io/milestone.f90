submodule (io) milestone

use timeutils, only : date_filename,dateinc
use h5fortran, only : h5exist
use filesystem, only : suffix

implicit none (type,external)   !! external procedures must be explicitly denoted thusly

contains

module procedure find_milestone

!> search path having output rate cadence (s) and find the last file that is a milestone.
integer, dimension(3) :: ymd
real(wp) :: UTsec
character(:), allocatable :: fn, suff
logical :: exists
real(wp) :: tsim

tsim = 0
tmile = 0

ymd = cfg%ymd0
UTsec = cfg%UTsec0
ymdmile = cfg%ymd0
UTsecmile = cfg%UTsec0

suff = suffix(cfg%indatsize)
filemile = date_filename(cfg%outdir, ymd, UTsec) // suff
!! This presumes the first file output is a milestone.
!! We don't test the situation wheere a first output was not produced.
!! User should not be restarting in that case.

if (cfg%mcadence <= 0 .and. cfg%flagoutput/=1) then      !okay for milestone if full output specified
!! milestone was not in config.nml
  inquire(file=filemile, exist=exists)
 ! error stop filemile
  if (exists) error stop 'a fresh simulation should not have data in output directory: ' // filemile
  return
endif

if (suff /= '.h5') return

milesearch : do
  !! new filename, add the 1 if it is the first
  fn = date_filename(cfg%outdir, ymd, UTsec) // suff

  inquire(file=fn, exist=exists)
  if ( .not. exists ) exit milesearch
  !! last output file

  if (h5exist(fn, '/nsall')) then
    !! this file is milestone
    ymdmile=ymd
    UTsecmile=UTsec
    filemile=fn
    tmile=tsim
  end if

  !! next time
  call dateinc(cfg%dtout, ymd,UTsec)
  tsim = tsim + cfg%dtout
end do milesearch

end procedure find_milestone

end submodule milestone
