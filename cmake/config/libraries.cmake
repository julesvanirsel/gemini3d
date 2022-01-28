set(_names
iniparser
glow hwm14 msis2
hwloc openmpi
lapack mumps scalapack
matgemini
nc4fortran h5fortran
ffilesystem
)

file(READ ${CMAKE_CURRENT_LIST_DIR}/libraries.json _libj)

foreach(n ${_names})
  foreach(t url git tag zip sha256)
    string(JSON m ERROR_VARIABLE e GET ${_libj} ${n} ${t})
    if(m)
      set(${n}_${t} ${m})
    endif()
  endforeach()
endforeach()

# --- Mumps
string(JSON MUMPS_UPSTREAM_VERSION GET ${_libj} mumps upstream_version)

# --- Zlib
if(zlib_legacy)
  string(JSON zlib_url GET ${_libj} zlib1 url)
  string(JSON zlib_sha256 GET ${_libj} zlib1 sha256)
else()
  string(JSON zlib_url GET ${_libj} zlib2 url)
  string(JSON zlib_sha256 GET ${_libj} zlib2 sha256)
endif()

# --- HDF5
if(NOT HDF5_VERSION)
  set(HDF5_VERSION 1.12.1 CACHE STRING "HDF5 version built")
endif()

string(JSON hdf5_url GET ${_libj} hdf5 ${HDF5_VERSION} url)
string(JSON hdf5_sha256 GET ${_libj} hdf5 ${HDF5_VERSION} sha256)
