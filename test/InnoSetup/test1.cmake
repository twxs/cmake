include(${CMAKE_CURRENT_SOURCE_DIR}/../../modules/InnoSetup.cmake)

if(NOT ISCC_COMMAND)
	message(SEND_ERROR "ISCC_COMMAND NOT FOUND  ${ISCC_COMMAND}")
else()
	message(STATUS "ISCC_COMMAND : ${ISCC_COMMAND}")
endif()

is_generate_iss(
	GUID "{E9C50EE6-35C0-4A48-B814-F37E71690DA0}"
	NAME "My Application"
	VERSION "1.0"
	PUBLISHER "MyCompany"
	URL "http://www.mycompagny.com"
	TARGET_NAME "TargetName"
)

is_generate_file(LINE 
	SOURCE "C:/program files/app.exe" 
	DESTDIR "{app}" 
	FLAGS ignoreversion)
message(STATUS "${LINE}")