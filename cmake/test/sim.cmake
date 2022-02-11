# this file defines simulation tests.
# The names of these must match those in ref_data.json

set(sim_timeout 1800)  # seconds to allow simulation tests to run

# --- setup tests

set(gemini_test_sim_names)

if(hwm14)
  list(APPEND gemini_test_sim_names mini2dns_hwm14_fang mini2dew_hwm14_fang mini3d_hwm14_fang)
  if(glow)
    list(APPEND gemini_test_sim_names mini2dns_hwm14_glow mini2dew_hwm14_glow mini3d_hwm14_glow)
  endif(glow)
else()
  list(APPEND gemini_test_sim_names mini2dns_fang mini2dew_fang mini3d_fang)
  if(glow)
    list(APPEND gemini_test_sim_names mini2dns_glow mini2dew_glow mini3d_glow)
  endif(glow)
endif()


foreach(_s ${gemini_test_sim_names})
  setup_gemini_test(${_s} ${sim_timeout} ${arc_json_file})

  if(python)
    setup_magcalc_test(${_s})
  endif()
endforeach()
