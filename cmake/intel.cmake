add_compile_options(
$<$<COMPILE_LANGUAGE:Fortran>:-warn>
$<$<COMPILE_LANGUAGE:C,CXX>:-Wall>
$<$<COMPILE_LANGUAGE:Fortran>:-traceback>
$<$<COMPILE_LANGUAGE:Fortran>:$<IF:$<BOOL:${WIN32}>,/Qdiag-disable:5268$<COMMA>7712$<COMMA>10182,-diag-disable=5268$<COMMA>7712$<COMMA>10182>>
$<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:$<IF:$<BOOL:${WIN32}>,/Qdiag-disable:5415,-diag-disable=5415>>
)
# remark #5415: Feature not yet implemented: Some 'check' options temporarily disabled.
# warning #10182: disabling optimization; runtime debug checks enabled

if(WIN32)
  add_compile_options($<$<CONFIG:Debug>:/Od>)
else()
  add_compile_options($<$<CONFIG:Debug>:-O0>)
endif()


if(NOT WIN32)
  if(CMAKE_Fortran_COMPILER_ID STREQUAL IntelLLVM)
    add_compile_options(-fiopenmp)
  endif()
  # -fiopenmp:
  # undefined reference to `omp_get_max_threads'
  # undefined reference to `__kmpc_global_thread_num' and more similar
  add_link_options(-qopenmp)
  # undefined reference to `__kmpc_begin'
endif()

#add_compile_options($<$<COMPILE_LANGUAGE:Fortran>:-heap-arrays>)
# heap-arrays: avoid stack overflow, especially in units tests like interp3

# --- IMPORTANT: bounds checking
# add_compile_options("$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug,RelWithDebInfo>>:-check>")
# -check is an alias for -check all. However, MUMPS trips on -check, so we have to use a less stringent check.
add_compile_options(
"$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug>>:-CB>"
"$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:RelWithDebInfo>>:-CB>"
)
# -CB is an alias for -check bounds.
# separate $<CONFIG: lines for CMake < 3.19
# --- IMPORTANT

add_compile_options(
"$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug>>:-debug>"
"$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:RelWithDebInfo>>:-debug>"
)
# -debug is an alias for -debug all
# -fpe0 causes MUMPS failures (internal to MUMPS)

# Fortran 2018 standard too many false warnings
