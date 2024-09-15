# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0"

if (USE_NIST_RAND)
    FILE(GLOB HEADERS ${CMAKE_CURRENT_LIST_DIR}/*.h)

    target_sources(PQCgenKAT_kem
            PRIVATE
            ${CMAKE_CURRENT_LIST_DIR}/FromNIST/rng.c
            #      ${CMAKE_CURRENT_LIST_DIR}/FromNIST/PQCgenKAT_kem.c
            ../../_common/tomas/PQCgenKAT_kem.c

            ${HEADERS}
    )
    target_sources(PQCgenKAT_kem_keygen
            PRIVATE
            ${CMAKE_CURRENT_LIST_DIR}/FromNIST/rng.c
            #      ${CMAKE_CURRENT_LIST_DIR}/FromNIST/PQCgenKAT_kem.c
            ../../_common/tomas/PQCgenKAT_kem_keygen.c

            ${HEADERS}
    )
    target_sources(PQCgenKAT_kem_enc
            PRIVATE
            ${CMAKE_CURRENT_LIST_DIR}/FromNIST/rng.c
            #      ${CMAKE_CURRENT_LIST_DIR}/FromNIST/PQCgenKAT_kem.c
            ../../_common/tomas/PQCgenKAT_kem_enc.c

            ${HEADERS}
    )
    target_sources(PQCgenKAT_kem_dec
            PRIVATE
            ${CMAKE_CURRENT_LIST_DIR}/FromNIST/rng.c
            #      ${CMAKE_CURRENT_LIST_DIR}/FromNIST/PQCgenKAT_kem.c
            ../../_common/tomas/PQCgenKAT_kem_dec.c

            ${HEADERS}
    )
else ()
    target_sources(PQCgenKAT_kem
            PRIVATE
#            ${CMAKE_CURRENT_LIST_DIR}/main_test.c
            ../../_common/tomas/PQCgenKAT_kem.c
    )
    target_sources(PQCgenKAT_kem_keygen
            PRIVATE
#            ${CMAKE_CURRENT_LIST_DIR}/main_test.c
            ../../_common/tomas/PQCgenKAT_kem_keygen.c
    )
    target_sources(PQCgenKAT_kem_enc
            PRIVATE
#            ${CMAKE_CURRENT_LIST_DIR}/main_test.c
            ../../_common/tomas/PQCgenKAT_kem_enc.c
    )
    target_sources(PQCgenKAT_kem_dec
            PRIVATE
#            ${CMAKE_CURRENT_LIST_DIR}/main_test.c
            ../../_common/tomas/PQCgenKAT_kem_dec.c
    )
endif ()
