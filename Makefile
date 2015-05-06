CC = nvcc
CFLAGS = -O3 -std=c++11 -code sm_50 -arch compute_50
CFLAGS_DEBUG = -g -G -std=c++11 -code sm_50 -arch compute_50 -DDEBUG

GRC = grc
GRC_DEBUG = grc_d
GRD = grd
GRD_DEBUG = grd_d


##################
# COMMON OBJECTS #
##################

COMMON_OBJECTS = PGMImage.o PGMImageError.o
COMMON_OBJECTS_DEBUG = PGMImage_d.o PGMImageError_d.o 


#################
# CODER OBJECTS #
#################
CODER = cbpc
CODER_DEBUG = cbpc_d
CODER_OBJECTS = PredictorN.o PredictorNW.o PredictorGW.o PredictorW.o PredictorNE.o PredictorGN.o PredictorPL.o PGMCBPCCUDA.o cbpc.o
CODER_OBJECTS_DEBUG = PredictorN_d.o PredictorNW_d.o PredictorGW_d.o PredictorW_d.o PredictorNE_d.o PredictorGN_d.o PredictorPL_d.o PGMCBPCCUDA_d.o cbpc_d.o


###################
# DECODER OBJECTS #
###################
DECODER = cbpd
DECODER_DEBUG = cbpd_d
DECODER_OBJECTS = PGMCBPDCUDA.o cbpd.o
DECODER_OBJECTS_DEBUG = PGMCBPDCUDA_d.o cbpd_d.o


##################
# COMMON RELEASE #
##################

all: $(CODER) $(DECODER) $(GRC) $(GRD)

PGMImage.o: PGMImage.cpp PGMImage.h
	$(CC) -c -o PGMImage.o $(CFLAGS) PGMImage.cpp

PGMImageError.o: PGMImageError.cpp PGMImageError.h
	$(CC) -c -o PGMImageError.o $(CFLAGS) PGMImageError.cpp


################
# COMMON DEBUG #
################

debug: $(CODER_DEBUG) $(DECODER_DEBUG) $(GRC_DEBUG) $(GRD_DEBUG)

PGMImage_d.o: PGMImage.cpp PGMImage.h
	$(CC) -c -o PGMImage_d.o $(CFLAGS_DEBUG) PGMImage.cpp

PGMImageError_d.o: PGMImageError.cpp PGMImageError.h
	$(CC) -c -o PGMImageError_d.o $(CFLAGS_DEBUG) PGMImageError.cpp


#################
# CODER RELEASE #
#################

$(CODER): $(COMMON_OBJECTS) $(CODER_OBJECTS)
	$(CC) -o $(CODER) $(CFLAGS) $(COMMON_OBJECTS) $(CODER_OBJECTS)

PredictorN.o: coderPredictors/PredictorN.cu coderPredictors/PredictorN.h
	$(CC) -c -o PredictorN.o $(CFLAGS) coderPredictors/PredictorN.cu

PredictorNW.o: coderPredictors/PredictorNW.cu coderPredictors/PredictorNW.h
	$(CC) -c -o PredictorNW.o $(CFLAGS) coderPredictors/PredictorNW.cu

PredictorGW.o: coderPredictors/PredictorGW.cu coderPredictors/PredictorGW.h
	$(CC) -c -o PredictorGW.o $(CFLAGS) coderPredictors/PredictorGW.cu

PredictorW.o: coderPredictors/PredictorW.cu coderPredictors/PredictorW.h
	$(CC) -c -o PredictorW.o $(CFLAGS) coderPredictors/PredictorW.cu

PredictorNE.o: coderPredictors/PredictorNE.cu coderPredictors/PredictorNE.h
	$(CC) -c -o PredictorNE.o $(CFLAGS) coderPredictors/PredictorNE.cu

PredictorGN.o: coderPredictors/PredictorGN.cu coderPredictors/PredictorGN.h
	$(CC) -c -o PredictorGN.o $(CFLAGS) coderPredictors/PredictorGN.cu

PredictorPL.o: coderPredictors/PredictorPL.cu coderPredictors/PredictorPL.h
	$(CC) -c -o PredictorPL.o $(CFLAGS) coderPredictors/PredictorPL.cu

PGMCBPCCUDA.o: PGMCBPCCUDA.cu PGMCBPCCUDA.h config.h util.h
	$(CC) -c -o PGMCBPCCUDA.o $(CFLAGS) PGMCBPCCUDA.cu

cbpc.o: cbpc.cpp config.h
	$(CC) -c -o cbpc.o $(CFLAGS) cbpc.cpp


###############
# CODER DEBUG #
###############

$(CODER_DEBUG): $(COMMON_OBJECTS_DEBUG) $(CODER_OBJECTS_DEBUG)
	$(CC) -o $(CODER_DEBUG) $(CFLAGS_DEBUG) $(COMMON_OBJECTS_DEBUG) $(CODER_OBJECTS_DEBUG)

PredictorN_d.o: coderPredictors/PredictorN.cu coderPredictors/PredictorN.h
	$(CC) -c -o PredictorN_d.o $(CFLAGS_DEBUG) coderPredictors/PredictorN.cu

PredictorNW_d.o: coderPredictors/PredictorNW.cu coderPredictors/PredictorNW.h
	$(CC) -c -o PredictorNW_d.o $(CFLAGS_DEBUG) coderPredictors/PredictorNW.cu

PredictorGW_d.o: coderPredictors/PredictorGW.cu coderPredictors/PredictorGW.h
	$(CC) -c -o PredictorGW_d.o $(CFLAGS_DEBUG) coderPredictors/PredictorGW.cu

PredictorW_d.o: coderPredictors/PredictorW.cu coderPredictors/PredictorW.h
	$(CC) -c -o PredictorW_d.o $(CFLAGS_DEBUG) coderPredictors/PredictorW.cu

PredictorNE_d.o: coderPredictors/PredictorNE.cu coderPredictors/PredictorNE.h
	$(CC) -c -o PredictorNE_d.o $(CFLAGS_DEBUG) coderPredictors/PredictorNE.cu

PredictorGN_d.o: coderPredictors/PredictorGN.cu coderPredictors/PredictorGN.h
	$(CC) -c -o PredictorGN_d.o $(CFLAGS_DEBUG) coderPredictors/PredictorGN.cu

PredictorPL_d.o: coderPredictors/PredictorPL.cu coderPredictors/PredictorPL.h
	$(CC) -c -o PredictorPL_d.o $(CFLAGS_DEBUG) coderPredictors/PredictorPL.cu

PGMCBPCCUDA_d.o: PGMCBPCCUDA.cu PGMCBPCCUDA.h config.h util.h
	$(CC) -c -o PGMCBPCCUDA_d.o $(CFLAGS_DEBUG) PGMCBPCCUDA.cu

cbpc_d.o: cbpc.cpp config.h
	$(CC) -c -o cbpc_d.o $(CFLAGS_DEBUG) cbpc.cpp


###################
# DECODER RELEASE #
###################

$(DECODER): $(COMMON_OBJECTS) $(DECODER_OBJECTS)
	$(CC) -o $(DECODER) $(CFLAGS) $(COMMON_OBJECTS) $(DECODER_OBJECTS)

PGMCBPDCUDA.o: PGMCBPDCUDA.cu PGMCBPDCUDA.h config.h util.h
	$(CC) -c -o PGMCBPDCUDA.o $(CFLAGS) PGMCBPDCUDA.cu

cbpd.o: cbpd.cpp config.h
	$(CC) -c -o cbpd.o $(CFLAGS) cbpd.cpp


#################
# DECODER DEBUG #
#################

$(DECODER_DEBUG): $(COMMON_OBJECTS_DEBUG) $(DECODER_OBJECTS_DEBUG)
	$(CC) -o $(DECODER_DEBUG) $(CFLAGS_DEBUG) $(COMMON_OBJECTS_DEBUG) $(DECODER_OBJECTS_DEBUG)

PGMCBPDCUDA_d.o: PGMCBPDCUDA.cu PGMCBPDCUDA.h config.h util.h
	$(CC) -c -o PGMCBPDCUDA_d.o $(CFLAGS_DEBUG) PGMCBPDCUDA.cu

cbpd_d.o: cbpd.cpp config.h
	$(CC) -c -o cbpd_d.o $(CFLAGS_DEBUG) cbpd.cpp


################
# CODER TESTER #
################

tester: coderTester.cpp $(COMMON_OBJECTS)
	$(CC) -o ct $(CFLAGS) coderTester.cpp $(COMMON_OBJECTS)

tester_d: coderTester.cpp $(COMMON_OBJECTS_DEBUG)
	$(CC) -o ct_d $(CFLAGS_DEBUG) coderTester.cpp $(COMMON_OBJECTS_DEBUG)


############
# GR CODER #
############

grc: GRcodec/grc.cpp GRCoder.o PGMImageError.o Bitset.o
	$(CC) -o grc $(CFLAGS) GRcodec/grc.cpp GRCoder.o PGMImageError.o Bitset.o

GRCoder.o: GRcodec/GRCoder.cpp GRcodec/GRCoder.h GRcodec/config.h
	$(CC) -c -o GRCoder.o $(CFLAGS) GRcodec/GRCoder.cpp

Bitset.o: GRcodec/Bitset.cpp GRcodec/Bitset.h
	$(CC) -c -o Bitset.o $(CFLAGS) GRcodec/Bitset.cpp


##################
# GR CODER DEBUG #
##################

grc_d: GRcodec/grc.cpp PGMImageError_d.o GRCoder_d.o Bitset_d.o
	$(CC) -o grc_d $(CFLAGS_DEBUG) GRcodec/grc.cpp PGMImageError_d.o GRCoder_d.o Bitset_d.o

GRCoder_d.o: GRcodec/GRCoder.cpp GRcodec/GRCoder.h GRcodec/config.h
	$(CC) -c -o GRCoder_d.o $(CFLAGS_DEBUG) GRcodec/GRCoder.cpp

Bitset_d.o: GRcodec/Bitset.cpp GRcodec/Bitset.h
	$(CC) -c -o Bitset_d.o $(CFLAGS_DEBUG) GRcodec/Bitset.cpp


##############
# GR DECODER #
##############

grd: GRcodec/grd.cpp GRDecoder.o PGMImageError.o Bitset.o
	$(CC) -o grd $(CFLAGS) GRcodec/grd.cpp GRDecoder.o PGMImageError.o Bitset.o

GRDecoder.o: GRcodec/GRDecoder.cpp GRcodec/GRDecoder.h GRcodec/config.h
	$(CC) -c -o GRDecoder.o $(CFLAGS) GRcodec/GRDecoder.cpp


####################
# GR DECODER DEBUG #
####################

grd_d: GRcodec/grd.cpp PGMImageError_d.o GRDecoder_d.o Bitset_d.o
	$(CC) -o grd_d $(CFLAGS_DEBUG) GRcodec/grd.cpp PGMImageError_d.o GRDecoder_d.o Bitset_d.o

GRDecoder_d.o: GRcodec/GRDecoder.cpp GRcodec/GRDecoder.h GRcodec/config.h
	$(CC) -c -o GRDecoder_d.o $(CFLAGS_DEBUG) GRcodec/GRDecoder.cpp



clean:
	-rm -f $(CODER) $(CODER_DEBUG) $(DECODER) $(DECODER_DEBUG) $(GRC) $(GRC_DEBUG) $(GRD) $(GRD_DEBUG) *.o ct ct_d
