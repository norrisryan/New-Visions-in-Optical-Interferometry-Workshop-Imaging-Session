import Pkg

# Install IJulia first — this registers the Julia kernel with Jupyter
Pkg.add("IJulia")

# Point PyCall at conda Python
ENV["PYTHON"] = "/opt/conda/bin/python"

Pkg.activate("..")
Pkg.Registry.add("General")
try
    Pkg.Registry.add(Pkg.RegistrySpec(url="https://github.com/emmt/EmmtRegistry"))
catch e
    @warn "EmmtRegistry: $e"
end

Pkg.instantiate()

using IJulia
using OITOOLS
using PyCall
using PyPlot

@info "Setup complete."
