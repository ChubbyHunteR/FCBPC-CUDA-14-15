#include <iostream>
#include <vector>
#include <cstdlib>
#include <string>
#include <ctime>

#include "PGMCBPDCUDA.h"

string usage = " inputImageErrorFile...";

void fail(string msg){
	cerr<<msg<<endl;
	exit(EXIT_FAILURE);
}

int main(int argc, char* argv[]) {
	if(argc < 2){
		usage = string("Usage:\n") + argv[0] + usage;
		fail(usage);
	}

	for(unsigned imageOffset = 0; imageOffset < argc; imageOffset += CUDA_MAX_IMG){
		vector<PGMImageError> inputImagesError;
		vector<PGMImage> outputImages;
		for(int i = 0; i < CUDA_MAX_IMG && i + imageOffset < argc; ++i){
			if(i + imageOffset == 0){
				++i;
			}
			string inputName = argv[i + imageOffset];
			size_t dot = inputName.find_last_of('.');
			if(dot == inputName.npos){
				dot = inputName.length();
			}
			string outputName = inputName.substr(0, dot) + "_decoded" + inputName.substr(dot);

			inputImagesError.emplace_back(inputName.c_str());
			unsigned w = inputImagesError.back().getWidth();
			unsigned h = inputImagesError.back().getHeight();
			unsigned size = inputImagesError.back().getSize();
			unsigned maxPixel = inputImagesError.back().getPixelMax();
			outputImages.emplace_back(outputName.c_str(), w, h, maxPixel);
		}

		PGMCBPDCUDA cbpd(inputImagesError, outputImages);
		cbpd.decode();
	}

	return 0;
}
