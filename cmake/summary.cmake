include(FeatureSummary)

set_package_properties(MPI PROPERTIES
    URL "https://www.open-mpi.org/"
    DESCRIPTION "OpenMPI, IntelMPI, MPICH and MS-MPI are known to work with GEMINI"
    PURPOSE "MPI is essential to GEMINI for massively parallel computation.")

add_feature_info(UseMPI mpi "Use MPI parallelization")

add_feature_info(GLOW glow "airglow / aurora model")

add_feature_info(NetCDF4 nc4fortran_FOUND "file read / write")

add_feature_info(Python python_ok "simulation generation, HPC script generator and plotting")

if(hdf5_external)
  add_feature_info(HDF5 true "file read / write")
else()
  add_feature_info(HDF5 h5fortran_FOUND "file read / write")
endif()
add_feature_info(AutoHDF5 hdf5_external "auto-build HDF5")

add_feature_info(AutoMumps mumps_external "auto-build Mumps")
add_feature_info(AutoScalapack scalapack_external "auto-build Scalapack")
add_feature_info(AutoLapack lapack_external "auto-build Lapack")

# print to screen
feature_summary(WHAT ENABLED_FEATURES DISABLED_FEATURES)
