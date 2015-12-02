

find_program(ISCC_COMMAND iscc.exe 
	HINTS "C:/Program Files (x86)/Inno Setup 5"
)

include(CMakeParseArguments)

function(_assert_are_defined PREFIX )
	foreach(ARG_NAME ${ARGN})
		if( "${${PREFIX}${ARG_NAME}}" STREQUAL "" )
			message(FATAL_ERROR "${ARG_NAME} is required")
		endif()
	endforeach()	
endfunction()

function(_assert_is_valid OPTION_VAR )
	list(FIND ARGN ${${OPTION_VAR}} INDEX)
	if(${INDEX} EQUAL -1)
		message(FATAL_ERROR "${OPTION_VAR} (${${OPTION_VAR}}) should be in {${ARGN}}")
	endif()
endfunction()

function(is_generate_file OUT_VAR)
	set(options )
	set(args FLAGS)
	set(arg SOURCE DESTDIR)
	cmake_parse_arguments(IS "${options}" "${arg}"
                        "${args}" ${ARGN} )
	_assert_are_defined(IS_  ${arg})	
	file(TO_NATIVE_PATH ${IS_SOURCE} IS_SOURCE)
	file(TO_NATIVE_PATH ${IS_DESTDIR} IS_DESTDIR)
	
	set(LINE "Source: \"${IS_SOURCE}\"; DestDir: \"${IS_DESTDIR}\"")	
	list(LENGTH IS_FLAGS FLAG_COUNT)
	if(FLAG_COUNT GREATER 0)
		set(LINE "${LINE}; Flags:")	
		foreach(FLAG ${IS_FLAGS})
			set(LINE "${LINE} ${FLAG}")		
		endforeach()
	endif() 
	set(${OUT_VAR} "${LINE}" PARENT_SCOPE)		
endfunction()

function(is_generate_iss)
  set(options 
  	RUN # if ON Run the ap after the install
  ) 
  set(oneValueArgs 
  	  GUID # Application GUID  
	  NAME # Application Name
	  VERSION # Aplication Version String "1.5"
	  PUBLISHER # "My Company, Inc."
	  URL # "http://www.mycorp.org" 
	  TARGET_NAME # TARGET_NAME
	  )
  set(multiValueArgs FILES)
  
  cmake_parse_arguments(IS "${options}" "${oneValueArgs}"
                        "${multiValueArgs}" ${ARGN} )
  _assert_are_defined(IS_ ${oneValueArgs})
  
  
endfunction()
