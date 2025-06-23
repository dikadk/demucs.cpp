include(FetchContent)

set(OPENBLAS_VERSION "0.3.26")  # Latest stable version as of 2024

FetchContent_Declare(
        openblas
        URL https://github.com/xianyi/OpenBLAS/releases/download/v${OPENBLAS_VERSION}/OpenBLAS-${OPENBLAS_VERSION}.zip
        URL_HASH SHA256=d85c91df52c3dc549e3a919940215edc5af95d7fe01a768be9e6fc700cf436a2
        DOWNLOAD_NO_EXTRACT TRUE
)

# Configure OpenBLAS build options
set(NOFORTRAN ON CACHE BOOL "Disable Fortran compiler requirement")
set(BUILD_WITHOUT_LAPACK OFF CACHE BOOL "Build without LAPACK")
set(BUILD_SHARED_LIBS ON CACHE BOOL "Build shared libraries")
set(USE_THREAD ON CACHE BOOL "Use threading")

if(NOT openblas_POPULATED)
    FetchContent_MakeAvailable(openblas)

    # Add OpenBLAS subdirectory
    add_subdirectory(${openblas_SOURCE_DIR} ${openblas_BINARY_DIR})

    # Set variables for the main project
    set(BLAS_LIBRARIES openblas CACHE STRING "OpenBLAS library")
    set(BLAS_FOUND TRUE CACHE BOOL "BLAS found")

    # Include directories
    set(BLAS_INCLUDE_DIRS ${openblas_SOURCE_DIR} CACHE STRING "OpenBLAS include directories")
endif()