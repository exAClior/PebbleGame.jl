servedocs:
	julia -e 'using Pkg; Pkg.activate("./docs"); Pkg.develop(path="."); Pkg.instantiate()'
	julia  -e 'using Pkg; Pkg.activate("./docs"); using PebbleGame,LiveServer; servedocs()'